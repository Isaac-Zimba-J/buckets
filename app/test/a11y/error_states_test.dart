import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/overrides.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets/routing/router_provider.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/setup/screens/screen_harness.dart';

/// Buckets that can't be read once [failing] is set.
final class BrokenBuckets implements BucketRepository {
  final _real = InMemoryBucketRepository();
  bool failing = false;

  static const _failure = StorageFailure('test', 'Buckets are unreadable.');

  @override
  Future<Result<List<Bucket>>> getAll() async =>
      failing ? const Err(_failure) : await _real.getAll();

  @override
  Future<Result<Bucket>> get(String id) async =>
      failing ? const Err(_failure) : await _real.get(id);

  @override
  Future<Result<void>> saveAll(List<Bucket> buckets) => _real.saveAll(buckets);

  @override
  Stream<List<Bucket>> watchAll() => failing
      ? Stream.error(const FailureException(_failure))
      : _real.watchAll();
}

/// S-09: screens that load data show the error banner with Try again
/// (PATTERNS: what happened, what to do) instead of a blank page.
void main() {
  testWidgets('every loading screen has an error state', (tester) async {
    final buckets = BrokenBuckets();
    final c = ProviderContainer(
      overrides: fakePortOverrides(buckets: buckets),
      retry: retryUnlessFailure,
    );
    addTearDown(c.dispose);
    (await seedDemo(c)).orThrow();
    (await c.read(completeSetupProvider)()).orThrow();
    final payday = (await c.read(paydayRepositoryProvider).getAll())
        .orThrow()
        .single;
    final living = (await buckets.getAll()).orThrow().firstWhere(
      (b) => b.kind == BucketKind.living,
    );
    buckets.failing = true;
    await pumpApp(tester, c);
    for (final (name, route) in [
      ('home', Routes.home),
      ('bucket', Routes.bucket(living.id)),
      ('plan', Routes.plan),
      ('payday', Routes.payday(payday.id)),
      ('done', Routes.paydayDone(payday.id)),
      ('check-in', Routes.checkIn),
      ('me accounts', Routes.meAccounts),
    ]) {
      c.read(routerProvider).go(route);
      await settleStreams(tester);
      expect(find.text(l.errLoad), findsOneWidget, reason: name);
      expect(find.text(l.tryAgain), findsOneWidget, reason: name);
    }
  });
}
