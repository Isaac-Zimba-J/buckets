import 'dart:async';

import 'package:buckets/bootstrap/activity_use_cases.dart';
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
  final zone = await DeviceTimeZoneLoader.load();
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
  bool _splashDone = false;

  void _ingest() =>
      unawaited(ref.read(ingestPaymentAlertsProvider).call());

  @override
  void initState() {
    super.initState();
    ref.read(notificationSyncProvider);
    _ingest();
    _lifecycle = AppLifecycleListener(
      onResume: () {
        ref.read(notificationSyncProvider).refresh();
        _ingest();
      },
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
    builder: (context, child) => Stack(
      children: [
        AppLockGate(child: child!),
        if (!_splashDone)
          _SplashOverlay(
            onDone: () => setState(() => _splashDone = true),
          ),
      ],
    ),
  );
}

/// Full-screen animated splash shown once on cold start.
/// Fades in with a scale pop, holds briefly, then fades out.
class _SplashOverlay extends StatefulWidget {
  const _SplashOverlay({required this.onDone});

  final VoidCallback onDone;

  @override
  State<_SplashOverlay> createState() => _SplashOverlayState();
}

class _SplashOverlayState extends State<_SplashOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    // 0–20%: fade in, 20–64%: hold, 64–100%: fade out
    _opacity = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 1)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
      TweenSequenceItem(tween: ConstantTween<double>(1), weight: 44),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1, end: 0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 36,
      ),
    ]).animate(_ctrl);
    // Scale pops from 0.88 → 1.0 during the fade-in window only
    _scale = Tween<double>(begin: 0.88, end: 1).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0, 0.2, curve: Curves.easeOut),
      ),
    );
    _ctrl
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed && mounted) widget.onDone();
      })
      ..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (ctx, child) => Opacity(
        opacity: _opacity.value,
        child: Transform.scale(scale: _scale.value, child: child),
      ),
      child: SizedBox.expand(
        child: ColoredBox(
          color: bk.colors.bg,
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: BkSpacing.s8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BkSplitBar(
                      segments: [
                        (BkBucketColor.living, 4000),
                        (BkBucketColor.fun, 1000),
                        (BkBucketColor.emergency, 1000),
                        (BkBucketColor.short, 1000),
                        (BkBucketColor.long, 2000),
                        (BkBucketColor.goal, 1000),
                      ],
                    ),
                    const BkGap(BkSpacing.s5),
                    Text(
                      'Buckets',
                      style: bk.type.display.copyWith(color: bk.colors.ink),
                    ),
                    const BkGap(BkSpacing.s2),
                    Text(
                      'Give every kwacha a job.',
                      style: bk.type.callout.copyWith(
                        color: bk.colors.inkMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
