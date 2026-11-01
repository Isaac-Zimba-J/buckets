import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/ledger/value_objects/ledger_refs.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// What a ledger entry records (DOMAIN §6).
enum LedgerEntryKind {
  /// Money into a bucket from a payday split. Zero or positive.
  allocation,

  /// Money spent. Negative.
  spend,

  /// The leaving half of a move between buckets. Negative.
  moveOut,

  /// The arriving half of a move between buckets. Positive.
  moveIn,

  /// Starting balances and untracked cash. Either sign.
  adjustment,

  /// Cancels an earlier entry. Either sign.
  reversal,
}

/// One append-only movement of money in or out of a bucket (DOMAIN §6).
final class LedgerEntry with Equatable {
  const LedgerEntry._({
    required this.id,
    required this.occurredAt,
    required this.kind,
    required this.bucketId,
    required this.amount,
    required this.counterBucketId,
    required this.refs,
    required this.note,
    required this.reversesEntryId,
  });

  /// Validates and creates an entry: the sign of [amount] fits [kind], moves
  /// name [counterBucketId], reversals name [reversesEntryId].
  static Result<LedgerEntry> create({
    required String id,
    required DateTime occurredAt,
    required LedgerEntryKind kind,
    required String bucketId,
    required Money amount,
    String? counterBucketId,
    LedgerRefs refs = LedgerRefs.none,
    String? note,
    String? reversesEntryId,
  }) {
    final isMove =
        kind == LedgerEntryKind.moveOut || kind == LedgerEntryKind.moveIn;
    return validated(
      [
        requireUtc(occurredAt, 'occurredAt'),
        if (!_signFits(kind, amount))
          ValidationFailure('amount.sign', 'Wrong sign for a ${kind.name}.'),
        if (isMove && counterBucketId == null)
          const ValidationFailure(
            'counterBucketId.missing',
            'A move needs the other bucket.',
          ),
        if (kind == LedgerEntryKind.reversal && reversesEntryId == null)
          const ValidationFailure(
            'reversesEntryId.missing',
            'A reversal needs the entry it reverses.',
          ),
      ],
      () => LedgerEntry._(
        id: id,
        occurredAt: occurredAt,
        kind: kind,
        bucketId: bucketId,
        amount: amount,
        counterBucketId: counterBucketId,
        refs: refs,
        note: note,
        reversesEntryId: reversesEntryId,
      ),
    );
  }

  static bool _signFits(LedgerEntryKind kind, Money amount) => switch (kind) {
    LedgerEntryKind.allocation => !amount.isNegative,
    LedgerEntryKind.spend || LedgerEntryKind.moveOut => amount.isNegative,
    LedgerEntryKind.moveIn => amount.isPositive,
    LedgerEntryKind.adjustment || LedgerEntryKind.reversal => true,
  };

  /// Unique ID.
  final String id;

  /// When the money moved, in UTC.
  final DateTime occurredAt;

  /// What the entry records.
  final LedgerEntryKind kind;

  /// The bucket whose balance changes.
  final String bucketId;

  /// Signed amount: positive adds to the bucket.
  final Money amount;

  /// The other bucket of a move.
  final String? counterBucketId;

  /// What caused it.
  final LedgerRefs refs;

  /// Optional note.
  final String? note;

  /// The entry a reversal cancels.
  final String? reversesEntryId;

  @override
  List<Object?> get props => [
    id,
    occurredAt,
    kind,
    bucketId,
    amount,
    counterBucketId,
    refs,
    note,
    reversesEntryId,
  ];
}
