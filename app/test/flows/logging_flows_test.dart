import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/features/home/presentation/controllers/home_controller.dart';
import 'package:buckets/features/logging/presentation/controllers/check_in_controller.dart';
import 'package:buckets/features/logging/presentation/controllers/log_payment_controller.dart';
import 'package:buckets/features/logging/presentation/controllers/receipt_review_controller.dart';
import 'package:buckets/features/logging/presentation/controllers/scan_controller.dart';
import 'package:buckets/features/logging/presentation/controllers/sort_alerts_controller.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter_test/flutter_test.dart';

import 'flow_harness.dart';

void main() {
  test(
    '2 alert ingested → sorted with a rule → next alert pre-filled',
    () async {
      final f = Flow();
      addTearDown(f.dispose);
      final c = f.c;
      (await seedDemo(c)).orThrow();
      final living = f.bucket(BucketKind.living);

      expect(
        await f.ingest('TEST PAID K185.00 TO [SHOP] REF A1'),
        hasLength(1),
      );
      final sort = sortAlertsControllerProvider;
      var next = await f.next(sort) as SortNext;
      expect(next.alert.amount, const Money.kwacha(185));
      expect(next.category, isNull);
      expect(
        await c
            .read(sort.notifier)
            .file(
              category: Category.market,
              bucketId: living,
              alwaysFile: true,
            ),
        isTrue,
      );
      await f.settle();
      expect(c.read(sort).value, isA<SortNone>());

      expect(await f.ingest('TEST PAID K60.00 TO [SHOP] REF A2'), hasLength(1));
      await f.settle();
      next = await f.next(sort) as SortNext;
      expect(next.category, Category.market);
      expect(next.bucketId, living);
      expect(
        await c
            .read(sort.notifier)
            .file(category: next.category!, bucketId: next.bucketId!),
        isTrue,
      );
      await f.settle();

      final home = await f.next(homeControllerProvider) as HomeActive;
      expect(home.livingLeft, const Money.kwacha(3080 - 185 - 60));
      expect(
        home.recent.map((t) => t.amount),
        unorderedEquals([const Money.kwacha(60), const Money.kwacha(185)]),
      );
    },
  );

  test('4 receipt scanned, reviewed and split across buckets', () async {
    final ocr = FakeTextRecognizer()..text = '[OCR TEXT]';
    final parser = FakeReceiptTextParser()
      ..draft = ReceiptDraft(
        total: Scored(const Money.kwacha(300), 0.95),
        items: [
          ReceiptItem('Bread', const Money.kwacha(200), 0.9),
          ReceiptItem('Speaker', const Money.kwacha(100), 0.9),
        ],
      );
    final f = Flow(textRecognizer: ocr, receiptParser: parser);
    addTearDown(f.dispose);
    final c = f.c;
    (await seedDemo(c)).orThrow();
    final living = f.bucket(BucketKind.living);
    final guiltFree = f.bucket(BucketKind.guiltFree);

    c.listen(scanControllerProvider, (_, _) {});
    await c.read(scanControllerProvider.notifier).capture(CaptureSource.camera);
    final id = (c.read(scanControllerProvider) as ScanRecognized).receiptId;

    final review = receiptReviewControllerProvider(id);
    final s = await f.next(review);
    expect(s.totalNeedsCheck, isFalse);
    expect(s.itemsMatch, isTrue);
    expect(
      await c
          .read(review.notifier)
          .save(
            category: Category.market,
            bucketId: living,
            lines: [
              TransactionLine(living, const Money.kwacha(200)),
              TransactionLine(guiltFree, const Money.kwacha(100)),
            ],
          ),
      isTrue,
    );
    await f.settle();

    final home = await f.next(homeControllerProvider) as HomeActive;
    expect(home.livingLeft, const Money.kwacha(2880));
    expect(home.guiltFreeLeft, const Money.kwacha(670));
  });

  test('6 Sunday check-in with a cash gap recorded as Untracked', () async {
    final clock = FakeClock(DateTime.utc(2026, 10, 25, 6));
    final f = Flow(clock: clock);
    addTearDown(f.dispose);
    final c = f.c;
    (await seedDemo(c)).orThrow();
    final living = f.bucket(BucketKind.living);

    // Last Sunday's first count: K 500 nobody logged, kept as cash in
    // hand (R-CASH-3).
    final checkIn = checkInControllerProvider;
    await f.next(checkIn);
    await c.read(checkIn.notifier).count(const Money.kwacha(500));
    expect(c.read(checkIn).value!.prompt, GapPrompt.receivedCash);
    expect(
      await c.read(checkIn.notifier).recordReceived(intoLiving: false),
      isTrue,
    );

    // During the week: K 120 of cash logged.
    clock.now_ = clock.now_.add(const Duration(days: 3));
    final log = logPaymentControllerProvider;
    c.listen(log, (_, _) {});
    expect(
      await c
          .read(log.notifier)
          .save(
            category: Category.food,
            bucketId: living,
            amount: const Money.kwacha(120),
          ),
      isTrue,
    );

    // This Sunday: an alert to sort first, then K 300 counted.
    clock.now_ = clock.now_.add(const Duration(days: 4));
    await f.ingest('TEST PAID K50.00 TO [CAFE] REF C1');
    c.invalidate(checkIn);
    var s = await f.next(checkIn);
    expect(s.steps, [CheckInStep.sort, CheckInStep.count, CheckInStep.summary]);
    expect(s.unsorted, 1);
    expect(s.expected, const Money.kwacha(380));
    final sort = await f.next(sortAlertsControllerProvider) as SortNext;
    expect(sort.alert.amount, const Money.kwacha(50));
    await c
        .read(sortAlertsControllerProvider.notifier)
        .file(category: Category.food, bucketId: living);
    await c.read(checkIn.notifier).nextStep();
    await c.read(checkIn.notifier).count(const Money.kwacha(300));
    s = c.read(checkIn).value!;
    expect(s.gap, const Money.kwacha(80));
    expect(s.prompt, GapPrompt.missingCash);
    expect(await c.read(checkIn.notifier).recordUntracked(), isTrue);
    expect(c.read(checkIn).value!.prompt, GapPrompt.none);

    await c.read(checkIn.notifier).nextStep();
    s = c.read(checkIn).value!;
    expect(s.step, CheckInStep.summary);
    expect(s.summary!.untrackedTotal, const Money.kwacha(80));
    // Logged spends; the Untracked K 80 is its own line.
    expect(s.summary!.spentByBucket[living], const Money.kwacha(170));
  });
}
