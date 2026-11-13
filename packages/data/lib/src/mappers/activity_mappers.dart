import 'dart:convert';

import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:drift/drift.dart';

/// Row ⇄ entity for alerts, spending, receipts and planning.
abstract final class ActivityMappers {
  /// A payment alert from its row.
  static Result<PaymentAlert> alert(PaymentAlertRow row) => PaymentAlert.create(
    id: row.id,
    rawText: row.rawText,
    source: row.source,
    receivedAt: row.receivedAt,
    status: row.status,
    parsed: row.confidence == 0 && row.amount == null && row.direction == null
        ? ParsedMessage.unparsed
        : ParsedMessage(
            confidence: row.confidence,
            direction: row.direction,
            amount: _money(row.amount),
            fee: _money(row.fee),
            counterparty: row.counterparty,
            reference: row.reference,
            occurredAt: row.occurredAt,
            balanceAfter: _money(row.balanceAfter),
            isWithdrawal: row.isWithdrawal,
          ),
  );

  /// The row for [alert].
  static PaymentAlertsCompanion alertRow(PaymentAlert alert) {
    final p = alert.parsed;
    return PaymentAlertsCompanion.insert(
      id: alert.id,
      rawText: Value(alert.rawText),
      source: alert.source,
      receivedAt: alert.receivedAt,
      status: alert.status,
      direction: Value(p.direction),
      amount: Value(p.amount?.ngwee),
      fee: Value(p.fee?.ngwee),
      counterparty: Value(p.counterparty),
      reference: Value(p.reference),
      occurredAt: Value(p.occurredAt),
      balanceAfter: Value(p.balanceAfter?.ngwee),
      confidence: p.confidence,
      isWithdrawal: p.isWithdrawal,
    );
  }

  /// A category from its stored name: a default one, or a custom one.
  static Result<Category> category(String name) {
    for (final c in [...Category.defaults, Category.untracked]) {
      if (c.name == name) return Ok(c);
    }
    return Category.create(name);
  }

  /// A transaction from its row and lines (in position order).
  static Result<Transaction> transaction(
    TransactionRow row,
    List<TransactionLineRow> lines,
  ) => switch (category(row.category)) {
    Ok(value: final c) => Transaction.create(
      id: row.id,
      amount: Money(row.amount),
      bucketId: row.bucketId,
      category: c,
      accountId: row.accountId,
      occurredAt: row.occurredAt,
      source: row.source,
      note: row.note,
      alertId: row.alertId,
      receiptId: row.receiptId,
      billId: row.billId,
      feeType: row.feeType,
      provider: row.provider,
      feeSource: row.feeSource,
      parentTransactionId: row.parentTransactionId,
      lines: [
        for (final l in lines) TransactionLine(l.bucketId, Money(l.amount)),
      ],
    ),
    Err(:final failure) => Err(failure),
  };

  /// The rows for [t].
  static (TransactionsCompanion, List<TransactionLinesCompanion>)
  transactionRows(Transaction t) => (
    TransactionsCompanion.insert(
      id: t.id,
      amount: t.amount.ngwee,
      bucketId: t.bucketId,
      category: t.category.name,
      accountId: t.accountId,
      occurredAt: t.occurredAt,
      source: t.source,
      note: Value(t.note),
      alertId: Value(t.alertId),
      receiptId: Value(t.receiptId),
      billId: Value(t.billId),
      feeType: Value(t.feeType),
      provider: Value(t.provider),
      feeSource: Value(t.feeSource),
      parentTransactionId: Value(t.parentTransactionId),
    ),
    [
      for (final (i, l) in t.lines.indexed)
        TransactionLinesCompanion.insert(
          transactionId: t.id,
          position: i,
          bucketId: l.bucketId,
          amount: l.amount.ngwee,
        ),
    ],
  );

  /// A cash withdrawal from its row.
  static Result<CashWithdrawal> withdrawal(CashWithdrawalRow row) =>
      CashWithdrawal.create(
        id: row.id,
        amount: Money(row.amount),
        fromAccountId: row.fromAccountId,
        cashAccountId: row.cashAccountId,
        occurredAt: row.occurredAt,
        alertId: row.alertId,
      );

  /// The row for [w].
  static CashWithdrawalsCompanion withdrawalRow(CashWithdrawal w) =>
      CashWithdrawalsCompanion.insert(
        id: w.id,
        amount: w.amount.ngwee,
        fromAccountId: w.fromAccountId,
        cashAccountId: w.cashAccountId,
        occurredAt: w.occurredAt,
        alertId: Value(w.alertId),
      );

  /// A merchant rule from its row.
  static Result<MerchantRule> merchantRule(MerchantRuleRow row) =>
      switch ((MerchantKey.create(row.merchantKey), category(row.category))) {
        (Ok(value: final key), Ok(value: final c)) => Ok(
          MerchantRule(
            id: row.id,
            merchantKey: key,
            category: c,
            bucketId: row.bucketId,
          ),
        ),
        (Err(:final failure), _) || (_, Err(:final failure)) => Err(failure),
      };

  /// The row for [rule].
  static MerchantRulesCompanion merchantRuleRow(MerchantRule rule) =>
      MerchantRulesCompanion.insert(
        id: rule.id,
        merchantKey: rule.merchantKey.value,
        category: rule.category.name,
        bucketId: rule.bucketId,
      );

  /// A stored receipt from its row. A draft that won't decode is a
  /// `StorageFailure`.
  static Result<StoredReceipt> receipt(ReceiptRow row) {
    try {
      final json = jsonDecode(row.draftJson) as Map<String, dynamic>;
      return Ok(
        StoredReceipt(
          id: row.id,
          imagePath: row.imagePath,
          draft: _draft(json),
        ),
      );
    } on FormatException {
      return const Err(
        StorageFailure('receipt.corrupt', 'Receipt is unreadable.'),
      );
      // A corrupt draft must come back as StorageFailure, not crash the app.
      // ignore: avoid_catching_errors, wrong JSON shapes throw TypeError.
    } on TypeError {
      return const Err(
        StorageFailure('receipt.corrupt', 'Receipt is unreadable.'),
      );
    }
  }

  /// The row for [receipt].
  static ReceiptsCompanion receiptRow(StoredReceipt receipt) {
    final d = receipt.draft;
    Map<String, Object?>? scored<T>(Scored<T>? s, Object? Function(T) v) =>
        s == null ? null : {'value': v(s.value), 'confidence': s.confidence};
    return ReceiptsCompanion.insert(
      id: receipt.id,
      imagePath: receipt.imagePath,
      draftJson: jsonEncode({
        'merchant': scored<String>(d.merchant, (v) => v),
        'date': scored<DateTime>(d.date, (v) => v.toIso8601String()),
        'total': scored<Money>(d.total, (v) => v.ngwee),
        'items': [
          for (final i in d.items)
            {
              'name': i.name,
              'amount': i.amount.ngwee,
              'confidence': i.confidence,
            },
        ],
      }),
    );
  }

  static ReceiptDraft _draft(Map<String, dynamic> json) {
    Scored<T>? scored<T>(String key, T Function(Object?) read) {
      final s = json[key] as Map<String, dynamic>?;
      return s == null
          ? null
          : Scored(read(s['value']), (s['confidence'] as num).toDouble());
    }

    return ReceiptDraft(
      merchant: scored('merchant', (v) => v! as String),
      date: scored('date', (v) => DateTime.parse(v! as String)),
      total: scored('total', (v) => Money(v! as int)),
      items: [
        for (final i in json['items'] as List<dynamic>)
          ReceiptItem(
            (i as Map<String, dynamic>)['name'] as String,
            Money(i['amount'] as int),
            (i['confidence'] as num).toDouble(),
          ),
      ],
    );
  }

  /// A planned purchase from its row.
  static Result<PlannedPurchase> planned(PlannedPurchaseRow row) =>
      PlannedPurchase.create(
        id: row.id,
        name: row.name,
        amount: Money(row.amount),
        bucketId: row.bucketId,
        due: row.due,
        repeatEvery: row.repeatEverySeconds == null
            ? null
            : Duration(seconds: row.repeatEverySeconds!),
        done: row.done,
        transactionId: row.transactionId,
      );

  /// The row for [p].
  static PlannedPurchasesCompanion plannedRow(PlannedPurchase p) =>
      PlannedPurchasesCompanion.insert(
        id: p.id,
        name: p.name,
        amount: p.amount.ngwee,
        bucketId: p.bucketId,
        due: Value(p.due),
        repeatEverySeconds: Value(p.repeatEvery?.inSeconds),
        done: p.done,
        transactionId: Value(p.transactionId),
      );

  /// A wish from its row.
  static Result<Wish> wish(WishRow row) => Wish.create(
    id: row.id,
    name: row.name,
    amount: Money(row.amount),
    bucketId: row.bucketId,
    createdAt: row.createdAt,
    endsAt: row.endsAt,
    status: row.status,
  );

  /// The row for [w].
  static WishesCompanion wishRow(Wish w) => WishesCompanion.insert(
    id: w.id,
    name: w.name,
    amount: w.amount.ngwee,
    bucketId: w.bucketId,
    createdAt: w.createdAt,
    endsAt: w.endsAt,
    status: w.status,
  );

  static Money? _money(int? ngwee) => ngwee == null ? null : Money(ngwee);
}
