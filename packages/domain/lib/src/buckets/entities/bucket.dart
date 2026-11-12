import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// What a bucket is for (DOMAIN §3).
enum BucketKind {
  /// Everyday spending.
  living,

  /// Spending without guilt.
  guiltFree,

  /// Emergency fund. Protected.
  emergency,

  /// Short-term savings.
  shortTerm,

  /// Long-term savings. Protected.
  longTerm,

  /// A savings goal with a target.
  goal,

  /// Family support.
  family,

  /// Side-hustle business money, e.g. restock.
  business,

  /// Anything else.
  custom,

  /// Bill money set aside each payday (R-BUCKET-7). Not removable.
  bills,
}

/// A bucket's colour; matches the `bucket-*` tokens in
/// `docs/design/tokens.json`.
enum BucketColor {
  /// `bucket-living`.
  living,

  /// `bucket-fun`.
  fun,

  /// `bucket-emergency`.
  emergency,

  /// `bucket-short`.
  short,

  /// `bucket-long`.
  long,

  /// `bucket-goal`.
  goal,

  /// `bucket-family`.
  family,

  /// `bucket-business`.
  business,
}

/// A labelled share of money with a purpose (DOMAIN §3). Its balance is
/// never stored; it comes from the ledger (R-BUCKET-4).
final class Bucket with Equatable {
  const new _({
    required this.id,
    required this.name,
    required this.kind,
    required this.color,
    required this.accountId,
    required this.isProtected,
    required this.sortOrder,
    required this.archived,
  });

  /// Validates and creates a bucket. Emergency and Long-term are always
  /// protected (R-BUCKET-2).
  static Result<Bucket> create({
    required String id,
    required String name,
    required BucketKind kind,
    required BucketColor color,
    required String accountId,
    bool isProtected = false,
    int sortOrder = 0,
    bool archived = false,
  }) => validated(
    [requireText(name)],
    () => Bucket._(
      id: id,
      name: name.trim(),
      kind: kind,
      color: color,
      accountId: accountId,
      isProtected: isProtected || alwaysProtected.contains(kind),
      sortOrder: sortOrder,
      archived: archived,
    ),
  );

  /// The default buckets created at setup (R-BUCKET-1). Living and
  /// Guilt-free live in the spending account (R-BUCKET-3); savings buckets
  /// in [savingsAccountId].
  static List<Bucket> defaults({
    required IdGenerator ids,
    required String spendingAccountId,
    required String savingsAccountId,
  }) {
    const specs = [
      ('Living', BucketKind.living, BucketColor.living),
      ('Guilt-free', BucketKind.guiltFree, BucketColor.fun),
      ('Emergency', BucketKind.emergency, BucketColor.emergency),
      ('Short-term', BucketKind.shortTerm, BucketColor.short),
      ('Long-term', BucketKind.longTerm, BucketColor.long),
    ];
    return [
      for (final (i, (name, kind, color)) in specs.indexed)
        Bucket._(
          id: ids.newId(),
          name: name,
          kind: kind,
          color: color,
          accountId: i < 2 ? spendingAccountId : savingsAccountId,
          isProtected: alwaysProtected.contains(kind),
          sortOrder: i,
          archived: false,
        ),
    ];
  }

  /// This bucket living in [accountId].
  Bucket withAccount(String accountId) => Bucket._(
    id: id,
    name: name,
    kind: kind,
    color: color,
    accountId: accountId,
    isProtected: isProtected,
    sortOrder: sortOrder,
    archived: archived,
  );

  /// This bucket, archived (R-BUCKET-6).
  Bucket archive() => Bucket._(
    id: id,
    name: name,
    kind: kind,
    color: color,
    accountId: accountId,
    isProtected: isProtected,
    sortOrder: sortOrder,
    archived: true,
  );

  /// Whether the user may remove this bucket: goals and the custom kinds,
  /// never the five default buckets (R-BUCKET-6).
  bool get isRemovable => const {
    BucketKind.goal,
    BucketKind.custom,
    BucketKind.family,
    BucketKind.business,
  }.contains(kind);

  /// Kinds that are always protected (R-BUCKET-2).
  static const Set<BucketKind> alwaysProtected = {
    BucketKind.emergency,
    BucketKind.longTerm,
  };

  /// Unique ID.
  final String id;

  /// Display name, unique among active buckets (R-BUCKET-5).
  final String name;

  /// What the bucket is for.
  final BucketKind kind;

  /// Display colour.
  final BucketColor color;

  /// The account its money lives in.
  final String accountId;

  /// Whether only `WithdrawFromProtected` may reduce it (R-BUCKET-2).
  final bool isProtected;

  /// Position in lists.
  final int sortOrder;

  /// Whether it is hidden and excluded from the rules.
  final bool archived;

  @override
  List<Object?> get props => [
    id,
    name,
    kind,
    color,
    accountId,
    isProtected,
    sortOrder,
    archived,
  ];
}
