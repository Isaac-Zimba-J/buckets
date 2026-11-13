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

  void _ingest() => unawaited(ref.read(ingestPaymentAlertsProvider).call());

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
    builder: (context, child) =>
        _SplashOverlay(child: AppLockGate(child: child!)),
  );
}

class _SplashOverlay extends StatefulWidget {
  const _SplashOverlay({required this.child});
  final Widget child;
  @override
  State<_SplashOverlay> createState() => _SplashOverlayState();
}

class _SplashOverlayState extends State<_SplashOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  bool _fadingOut = false;
  bool _dismissed = false;

  static const _bg = Color(0xFF0C0E0D);
  static const _letters = ['B', 'u', 'c', 'k', 'e', 't', 's'];

  // Each letter's [start, end] within the 0–1 animation; duration grows by
  // ~30ms per letter so each zooms in a bit slower than the previous.
  static const _intervals = [
    (0.06, 0.145), // B  ~212ms
    (0.145, 0.244), // u  ~248ms
    (0.244, 0.355), // c  ~278ms
    (0.355, 0.479), // k  ~310ms
    (0.479, 0.615), // e  ~340ms
    (0.615, 0.763), // t  ~370ms
    (0.763, 0.927), // s  ~410ms
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    unawaited(
      _ctrl.forward().whenComplete(() {
        if (!mounted) return;
        setState(() => _fadingOut = true);
        unawaited(
          Future.delayed(const Duration(milliseconds: 400), () {
            if (mounted) setState(() => _dismissed = true);
          }),
        );
      }),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Animation<double> _scale(int i) => Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: _ctrl,
      curve: Interval(
        _intervals[i].$1,
        _intervals[i].$2,
        curve: Curves.easeOutBack,
      ),
    ),
  );

  Animation<double> _fade(int i) => Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: _ctrl,
      curve: Interval(_intervals[i].$1, _intervals[i].$1 + 0.04),
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (_dismissed) return widget.child;
    return Stack(
      children: [
        widget.child,
        AnimatedOpacity(
          opacity: _fadingOut ? 0 : 1,
          duration: const Duration(milliseconds: 400),
          child: Container(
            color: _bg,
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (_, _) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon: slides in fast then decelerates with a spring
                  FadeTransition(
                    opacity: Tween<double>(begin: 0, end: 1).animate(
                      CurvedAnimation(
                        parent: _ctrl,
                        curve: const Interval(0, 0.08),
                      ),
                    ),
                    child: SlideTransition(
                      position:
                          Tween<Offset>(
                            begin: const Offset(-0.5, 0),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: _ctrl,
                              curve: const Interval(
                                0,
                                0.4,
                                curve: Curves.elasticOut,
                              ),
                            ),
                          ),
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.42,
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 56,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // "Buckets" — each letter zooms in slower than the last
                  for (int i = 0; i < _letters.length; i++)
                    ScaleTransition(
                      scale: _scale(i),
                      child: FadeTransition(
                        opacity: _fade(i),
                        child: Text(
                          _letters[i],
                          style: const TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
