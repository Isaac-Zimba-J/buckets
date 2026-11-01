import 'dart:io';

import 'package:test/test.dart';

// The receipt text parser (R-RECEIPT-1) is written only against redacted
// OCR text fixtures (AGENTS.md §5). Until test/fixtures/receipts/ has them,
// this suite is skipped.
void main() {
  final fixtures = Directory(
    'test/fixtures/receipts',
  ).listSync().whereType<File>().where((f) => f.path.endsWith('.txt'));
  test(
    'receipt fixtures parse',
    () {},
    skip: fixtures.isEmpty ? 'needs fixtures' : 'parser not written yet',
  );
}
