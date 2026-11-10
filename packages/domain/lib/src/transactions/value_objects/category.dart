import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// What money was spent on (DOMAIN §10). Not to be confused with a bucket,
/// which is where the money came from.
final class Category with Equatable {
  const new _(this.name, {this.isDefault = false, this.archived = false});

  /// The longest a category name may be (R-CAT-2).
  static const maxNameLength = 24;

  /// Validates and creates a custom category. Uniqueness (R-CAT-2) is
  /// checked against other categories by the use case, not here.
  static Result<Category> create(String name) => validated([
    requireText(name, 'category'),
    requireMaxLength(name, maxNameLength, 'category'),
  ], () => Category._(name.trim()));

  /// Rebuilds a stored category with its flags (for the data layer). The
  /// name is validated like [create].
  static Result<Category> fromStored({
    required String name,
    required bool isDefault,
    required bool archived,
  }) => validated([
    requireText(name, 'category'),
    requireMaxLength(name, maxNameLength, 'category'),
  ], () => Category._(name.trim(), isDefault: isDefault, archived: archived));

  /// A validated copy under a new [name] (R-CAT-1). Keeps [isDefault] and
  /// [archived]; a default category may be renamed.
  Result<Category> rename(String name) => validated([
    requireText(name, 'category'),
    requireMaxLength(name, maxNameLength, 'category'),
  ], () => Category._(name.trim(), isDefault: isDefault, archived: archived));

  /// A copy marked archived (R-CAT-1). Default categories may not be
  /// archived; the use case enforces that before calling this.
  Category archive() => Category._(name, isDefault: isDefault, archived: true);

  /// A copy marked active again.
  Category unarchive() => Category._(name, isDefault: isDefault);

  /// Food.
  static const food = Category._('Food', isDefault: true);

  /// Transport.
  static const transport = Category._('Transport', isDefault: true);

  /// Airtime & data.
  static const airtimeData = Category._('Airtime & data', isDefault: true);

  /// Market.
  static const market = Category._('Market', isDefault: true);

  /// Family.
  static const family = Category._('Family', isDefault: true);

  /// Bill.
  static const bill = Category._('Bill', isDefault: true);

  /// Planned buy.
  static const plannedBuy = Category._('Planned buy', isDefault: true);

  /// Mobile money fees (R-SPEND-2).
  static const fees = Category._('Fees', isDefault: true);

  /// Other.
  static const other = Category._('Other', isDefault: true);

  /// Cash that went missing between counts (R-CASH-2).
  static const untracked = Category._('Untracked', isDefault: true);

  /// The default categories, in display order.
  static const List<Category> defaults = [
    food,
    transport,
    airtimeData,
    market,
    family,
    bill,
    plannedBuy,
    fees,
    other,
  ];

  /// Display name.
  final String name;

  /// Whether this is one of the built-in categories (R-CAT-1): it may be
  /// renamed but not archived.
  final bool isDefault;

  /// Whether the category is archived (R-CAT-1): hidden from new choices
  /// but kept for transactions that already use it.
  final bool archived;

  @override
  List<Object?> get props => [name, isDefault, archived];
}
