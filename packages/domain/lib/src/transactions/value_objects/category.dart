import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// What money was spent on (DOMAIN §10). Not to be confused with a bucket,
/// which is where the money came from.
final class Category with Equatable {
  const Category._(this.name);

  /// Validates and creates a custom category.
  static Result<Category> create(String name) => validated(
    [requireText(name, 'category')],
    () => Category._(name.trim()),
  );

  /// Food.
  static const food = Category._('Food');

  /// Transport.
  static const transport = Category._('Transport');

  /// Airtime & data.
  static const airtimeData = Category._('Airtime & data');

  /// Market.
  static const market = Category._('Market');

  /// Family.
  static const family = Category._('Family');

  /// Bill.
  static const bill = Category._('Bill');

  /// Planned buy.
  static const plannedBuy = Category._('Planned buy');

  /// Mobile money fees (R-SPEND-2).
  static const fees = Category._('Fees');

  /// Other.
  static const other = Category._('Other');

  /// Cash that went missing between counts (R-CASH-2).
  static const untracked = Category._('Untracked');

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

  @override
  List<Object?> get props => [name];
}
