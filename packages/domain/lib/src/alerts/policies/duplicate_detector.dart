import 'package:buckets_domain/src/accounts/value_objects/match_key.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';

/// Finds alerts that report the same payment twice (R-PARSE-4).
abstract final class DuplicateDetector {
  /// The longest gap between two reports of the same payment without a
  /// reference.
  static const window = Duration(minutes: 2);

  /// The alert in [existing] that [candidate] duplicates, or null. With a
  /// reference: same provider and reference. Without: same amount and
  /// counterparty, and occurredAt within [window].
  static PaymentAlert? findDuplicate(
    PaymentAlert candidate,
    Iterable<PaymentAlert> existing,
  ) {
    final p = candidate.parsed;
    final others = existing.where((e) => e.id != candidate.id);
    if (p.reference != null) {
      return others
          .where(
            (e) =>
                e.source == candidate.source &&
                e.parsed.reference == p.reference,
          )
          .firstOrNull;
    }
    final (amount, counterparty, at) = (
      p.amount,
      p.counterparty,
      p.occurredAt,
    );
    if (amount == null || counterparty == null || at == null) return null;
    final key = MatchKey.normalize(counterparty);
    return others.where((e) {
      final q = e.parsed;
      final qAt = q.occurredAt;
      return q.amount == amount &&
          q.counterparty != null &&
          MatchKey.normalize(q.counterparty!) == key &&
          qAt != null &&
          qAt.difference(at).abs() <= window;
    }).firstOrNull;
  }
}
