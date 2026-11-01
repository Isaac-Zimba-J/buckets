import 'dart:math';

import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/bills/entities/bill.dart';

/// How much of each income is set aside for bills (DOMAIN §5).
abstract final class BillReservations {
  /// This cycle's reservation for [bill] (R-BILL-1).
  ///
  /// A monthly bill reserves its amount. Any other bill is a sinking fund:
  /// `ceil((amount − putAside) / cyclesUntilDue)`, counting at least 1
  /// cycle, and nothing once [putAside] covers the bill.
  static Money monthly(
    Bill bill, {
    Money putAside = Money.zero,
    int cyclesUntilDue = 1,
  }) {
    if (bill.frequency.isMonthly) return bill.amount;
    final remaining = (bill.amount - putAside).ngwee;
    if (remaining <= 0) return Money.zero;
    final cycles = max(1, cyclesUntilDue);
    return Money((remaining + cycles - 1) ~/ cycles);
  }

  /// The bill total shown in setup: the sum of [reservations] (R-BILL-3).
  static Money total(Iterable<Money> reservations) =>
      reservations.fold(Money.zero, (sum, m) => sum + m);
}
