import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

void main() {
  const pass = CheckPassed();

  test('R-PROOF-1 passes only when all four checks pass', () {
    const all = ProofResult(
      amount: pass,
      account: pass,
      date: pass,
      reference: pass,
    );
    expect(all.passed, isTrue);
    expect(all.checks, hasLength(4));
  });

  test('R-PROOF-2 failed and unknown both fail the proof', () {
    const failed = ProofResult(
      amount: CheckFailed('amountTooLow'),
      account: pass,
      date: pass,
      reference: pass,
    );
    const unknown = ProofResult(
      amount: pass,
      account: pass,
      date: pass,
      reference: CheckUnknown(),
    );
    expect(failed.passed, isFalse);
    expect(unknown.passed, isFalse);
    expect(const CheckFailed('x'), const CheckFailed('x'));
    expect(const CheckFailed('x').reason, 'x');
    expect(const CheckUnknown(), const CheckUnknown());
  });
}
