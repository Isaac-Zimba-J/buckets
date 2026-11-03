import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/checkin/policies/check_in_flow.dart';
import 'package:buckets_domain/src/checkin/use_cases/check_in_context.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// The check-in's steps and expected cash (R-CHECKIN-1).
final class GetCheckInState {
  /// Creates the use case.
  const GetCheckInState(this._context);

  final CheckInContext _context;

  /// The steps, unsorted alert count and expected cash.
  Future<Result<({List<CheckInStep> steps, int unsorted, Money expected})>>
  call() => attempt(() async {
    final unsorted =
        (await _context.alerts.watchByStatus(AlertStatus.newAlert).first)
            .length;
    return (
      steps: CheckInFlow.steps(unsortedAlerts: unsorted),
      unsorted: unsorted,
      expected: unwrap(await _context.expectedCash()),
    );
  });
}
