import 'package:buckets/bootstrap/notification_sync.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/me/presentation/widgets/app_lock_gate.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/router_provider.dart';
import 'package:buckets_data/buckets_data.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final zone = await DeviceTimeZone.load();
  runApp(
    ProviderScope(
      overrides: [localTimeZoneProvider.overrideWithValue(zone)],
      retry: retryUnlessFailure,
      child: const BucketsApp(),
    ),
  );
}

/// Root widget: Buckets themes, English strings, the router. Keeps the
/// notification schedule in sync, and refreshes it on resume.
class BucketsApp extends ConsumerStatefulWidget {
  /// Creates the root widget.
  const new({super.key});

  @override
  ConsumerState<BucketsApp> createState() => _BucketsAppState();
}

class _BucketsAppState extends ConsumerState<BucketsApp> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    ref.read(notificationSyncProvider);
    _lifecycle = AppLifecycleListener(
      onResume: () => ref.read(notificationSyncProvider).refresh(),
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    onGenerateTitle: (context) => AppLocalizations.of(context).appName,
    theme: BucketsTheme.light,
    darkTheme: BucketsTheme.dark,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    routerConfig: ref.watch(routerProvider),
    builder: (context, child) => AppLockGate(child: child!),
  );
}
