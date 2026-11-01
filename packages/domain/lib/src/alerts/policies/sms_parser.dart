import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/alerts/value_objects/message_template.dart';
import 'package:buckets_domain/src/alerts/value_objects/parsed_message.dart';

final _amount = RegExp(r'^(\d{1,3}(?:,\d{3})+|\d+)(?:\.(\d{1,2}))?$');
const _fields = {
  'amount',
  'fee',
  'counterparty',
  'reference',
  'date',
  'balance',
};

/// Reads payment messages with provider templates (DOMAIN §8).
final class SmsParser {
  /// Creates a parser that tries [templates] in order.
  const SmsParser(this.templates);

  /// Templates in the order they are tried.
  final List<MessageTemplate> templates;

  /// `"1,540.00"` → 154000 ngwee, without floating point (R-PARSE-3); null
  /// for anything that isn't a plain amount with at most 2 decimals.
  static Money? parseAmount(String text) {
    final m = _amount.firstMatch(text);
    if (m == null) return null;
    final kwacha = int.parse(m[1]!.replaceAll(',', ''));
    final ngwee = int.parse((m[2] ?? '0').padRight(2, '0'));
    return Money(kwacha * 100 + ngwee);
  }

  /// The first template match for [text], optionally only [source]'s
  /// templates. Confidence is the share of declared fields that parsed.
  /// Unparseable text gives [ParsedMessage.unparsed], never an exception
  /// (R-PARSE-2).
  ParsedMessage parse(
    String text, {
    required Duration utcOffset,
    AlertSource? source,
  }) {
    final trimmed = text.trim();
    for (final t in templates) {
      if (source != null && t.source != source) continue;
      final match = t.pattern.firstMatch(trimmed);
      if (match != null) return _read(t, match, utcOffset);
    }
    return ParsedMessage.unparsed;
  }

  static ParsedMessage _read(
    MessageTemplate t,
    RegExpMatch match,
    Duration utcOffset,
  ) {
    final declared = match.groupNames.where(_fields.contains).toSet();
    String? group(String name) {
      if (!declared.contains(name)) return null;
      final value = match.namedGroup(name)?.trim();
      return value == null || value.isEmpty ? null : value;
    }

    final date = group('date');
    final values = (
      amount: _money(group('amount')),
      fee: _money(group('fee')),
      counterparty: group('counterparty'),
      reference: group('reference'),
      occurredAt: date == null ? null : _date(t, date, utcOffset),
      balance: _money(group('balance')),
    );
    final read = [
      values.amount,
      values.fee,
      values.counterparty,
      values.reference,
      values.occurredAt,
      values.balance,
    ].nonNulls.length;
    return ParsedMessage(
      // The direction always comes from the template, so it counts as read.
      confidence: (read + 1) / (declared.length + 1),
      direction: t.direction,
      amount: values.amount,
      fee: values.fee,
      counterparty: values.counterparty,
      reference: values.reference,
      occurredAt: values.occurredAt,
      balanceAfter: values.balance,
    );
  }

  static Money? _money(String? text) => text == null ? null : parseAmount(text);

  static DateTime? _date(MessageTemplate t, String raw, Duration utcOffset) {
    try {
      final parsed = t.parseDate?.call(raw, utcOffset);
      return parsed == null || !parsed.isUtc ? null : parsed;
    } on FormatException {
      return null;
      // R-PARSE-2: a bad date in a message must never crash parsing.
      // ignore: avoid_catching_errors, RangeError from date math is data here.
    } on ArgumentError {
      return null;
    }
  }
}
