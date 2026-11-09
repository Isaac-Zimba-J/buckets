import 'package:buckets/bootstrap/ports.dart';
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

/// Root widget: Buckets themes, English strings, the router.
class BucketsApp extends ConsumerWidget {
  /// Creates the root widget.
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
    onGenerateTitle: (context) => AppLocalizations.of(context).appName,
    theme: BucketsTheme.light,
    darkTheme: BucketsTheme.dark,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    routerConfig: ref.watch(routerProvider),
  );
}
