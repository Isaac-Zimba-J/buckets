import 'package:buckets_core/buckets_core.dart';
import 'package:test/test.dart';

void main() {
  test('redact keeps shape but hides letters and digits', () {
    expect(
      redact('Paid K1,540.00 to Chanda Mwila 0971234567. Ref AB12CD'),
      'xxxx x#,###.## xx xxxxxx xxxxx ##########. xxx xx##xx',
    );
  });

  test('redact hides non-ASCII letters too', () {
    expect(redact('Muli shani Ñkandu'), 'xxxx xxxxx xxxxxx');
  });
}
