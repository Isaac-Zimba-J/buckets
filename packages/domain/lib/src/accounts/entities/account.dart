import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/value_objects/match_key.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// The kind of place an account's money is held.
enum AccountKind {
  /// A bank account.
  bank,

  /// An MTN MoMo wallet.
  mtnMomo,

  /// An Airtel Money wallet.
  airtelMoney,

  /// Physical cash.
  cash,

  /// An investment account.
  investment,

  /// Anything else.
  other,
}

/// A real place money sits (DOMAIN §2).
final class Account with Equatable {
  const new _({
    required this.id,
    required this.name,
    required this.kind,
    required this.matchKeys,
    required this.isSpending,
  });

  /// The automatic "Cash in hand" account (R-ACC-2).
  const new cashInHand({required this.id})
    : name = 'Cash in hand',
      kind = AccountKind.cash,
      matchKeys = const [],
      isSpending = false;

  /// Validates and creates an account.
  static Result<Account> create({
    required String id,
    required String name,
    required AccountKind kind,
    List<MatchKey> matchKeys = const [],
    bool isSpending = false,
  }) => validated(
    [requireText(name)],
    () => Account._(
      id: id,
      name: name.trim(),
      kind: kind,
      matchKeys: List.unmodifiable(matchKeys),
      isSpending: isSpending,
    ),
  );

  /// Unique ID.
  final String id;

  /// Display name.
  final String name;

  /// Where the money is held.
  final AccountKind kind;

  /// Text that identifies this account in confirmation messages.
  final List<MatchKey> matchKeys;

  /// Whether this is the default spending account (R-ACC-1).
  final bool isSpending;

  @override
  List<Object?> get props => [id, name, kind, matchKeys, isSpending];
}
