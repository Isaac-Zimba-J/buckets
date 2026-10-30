import 'package:buckets/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BucketsApp renders a blank scaffold', (tester) async {
    await tester.pumpWidget(const BucketsApp());
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
