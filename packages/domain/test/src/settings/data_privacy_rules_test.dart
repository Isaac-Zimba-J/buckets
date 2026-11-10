import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

void main() {
  group('DataPrivacyRules.confirmsDelete (R-PRIV-4)', () {
    test('the exact keyword confirms, trimming spaces', () {
      expect(DataPrivacyRules.confirmsDelete('DELETE'), isTrue);
      expect(DataPrivacyRules.confirmsDelete('  DELETE  '), isTrue);
    });

    test('anything else does not', () {
      expect(DataPrivacyRules.confirmsDelete('delete'), isFalse);
      expect(DataPrivacyRules.confirmsDelete('Delete'), isFalse);
      expect(DataPrivacyRules.confirmsDelete('DELETE ALL'), isFalse);
      expect(DataPrivacyRules.confirmsDelete(''), isFalse);
    });
  });
}
