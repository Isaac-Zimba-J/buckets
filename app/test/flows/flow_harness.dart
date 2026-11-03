import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/bootstrap/overrides.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderListenable;
import 'package:flutter_test/flutter_test.dart';

DateTime _date(String raw, Duration offset) {
  final p = raw.split(RegExp('[- :]')).map(int.parse).toList();
  return DateTime.utc(p[0], p[1], p[2], p[3], p[4]).subtract(offset);
}

/// Synthetic message formats for tests only (AGENTS.md §5): no real
/// provider's SMS is copied here.
final SmsParser flowParser = SmsParser([
  MessageTemplate(
    source: AlertSource.unknown,
    name: 'test-received',
    direction: MessageDirection.incoming,
    pattern: RegExp(
      r'^TEST RECEIVED K(?<amount>[\d,.]+) FROM (?<counterparty>.+?) '
      r'REF (?<reference>\w+)$',
    ),
  ),
  MessageTemplate(
    source: AlertSource.unknown,
    name: 'test-sent',
    direction: MessageDirection.outgoing,
    pattern: RegExp(
      r'^TEST SENT K(?<amount>[\d,.]+) TO (?<counterparty>.+?) '
      r'REF (?<reference>\w+) AT (?<date>\d{4}-\d{2}-\d{2} \d{2}:\d{2})$',
    ),
    parseDate: _date,
  ),
  MessageTemplate(
    source: AlertSource.unknown,
    name: 'test-paid',
    direction: MessageDirection.outgoing,
    pattern: RegExp(
      r'^TEST PAID K(?<amount>[\d,.]+) TO (?<counterparty>.+?) '
      r'REF (?<reference>\w+)$',
    ),
  ),
]);

/// A transfer proof message to the savings account (match key 4521).
String sentToSavings(Money amount, String ref) =>
    'TEST SENT K${amount.ngwee ~/ 100}.${_two(amount.ngwee % 100)} '
    'TO acc ****4521 REF $ref AT 2026-10-25 09:00';

String _two(int n) => n.toString().padLeft(2, '0');

/// One container on fakes with the test parser, plus flow helpers.
final class Flow {
  /// Creates the container; pass fakes to keep a handle on them.
  Flow({
    FakeClock? clock,
    TextRecognizer? textRecognizer,
    ReceiptTextParser? receiptParser,
  }) : c = ProviderContainer(
         overrides: [
           ...fakePortOverrides(
             clock: clock,
             textRecognizer: textRecognizer,
             receiptParser: receiptParser,
           ),
           smsParserProvider.overrideWithValue(flowParser),
         ],
         retry: retryUnlessFailure,
       );

  /// The container under test.
  final ProviderContainer c;

  /// Keeps [p] alive and waits for its next data value.
  Future<T> next<T>(ProviderListenable<AsyncValue<T>> p) async {
    c.listen(p, (_, _) {});
    for (var i = 0; i < 100; i++) {
      final v = c.read(p);
      if (v case AsyncData(:final value) when !v.isLoading) return value;
      if (v case AsyncError(:final error)) fail('$p failed: $error');
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
    fail('no value for $p');
  }

  /// Lets live streams deliver their latest values.
  Future<void> settle() =>
      Future<void>.delayed(const Duration(milliseconds: 50));

  /// The ID of the first bucket of [kind].
  String bucket(BucketKind kind) =>
      (c.read(bucketRepositoryProvider) as InMemoryBucketRepository)
          .store
          .items
          .values
          .firstWhere((b) => b.kind == kind)
          .id;

  /// A captured notification arrives and is ingested; its new alerts.
  Future<List<PaymentAlert>> ingest(String text) async {
    (c.read(paymentAlertSourceProvider) as FakePaymentAlertSource).queue.add(
      IncomingAlertText(
        packageName: 'test.package',
        text: text,
        receivedAt: c.read(clockProvider).now(),
      ),
    );
    return (await c.read(ingestPaymentAlertsProvider)()).orThrow();
  }

  /// Ends the container.
  void dispose() => c.dispose();
}
