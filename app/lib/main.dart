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
  StreamSubscription<void>? _queuedSubscription;

  void _ingest() => unawaited(ref.read(ingestPaymentAlertsProvider).call());

  @override
  void initState() {
    super.initState();
    ref.read(notificationSyncProvider);
    _ingest();
    _queuedSubscription = ref
        .read(androidAlertSourceProvider)
        .queued
        .listen((_) => _ingest());
    _lifecycle = AppLifecycleListener(
      onResume: () {
        ref.read(notificationSyncProvider).refresh();
        _ingest();
      },
    );
  }

  @override
  void dispose() {
    unawaited(_queuedSubscription?.cancel());
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

  // Letter intervals — each is ~30 ms longer than the previous so each
  // zooms in slightly slower left → right.
  static const _intervals = [
    (0.06, 0.148), // B
    (0.148, 0.252), // u
    (0.252, 0.368), // c
    (0.368, 0.496), // k
    (0.496, 0.636), // e
    (0.636, 0.788), // t
    (0.788, 0.952), // s
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    unawaited(
      _ctrl.forward().whenComplete(() {
        if (!mounted) return;
        setState(() => _fadingOut = true);
        unawaited(
          Future.delayed(const Duration(milliseconds: 500), () {
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

  // Letter scale: zoom from 0 → 1 with a gentle overshoot.
  Animation<double> _letterScale(int i) =>
      Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _ctrl,
          curve: Interval(
            _intervals[i].$1,
            _intervals[i].$2,
            curve: Curves.easeOutBack,
          ),
        ),
      );

  Animation<double> _letterFade(int i) =>
      Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _ctrl,
          curve: Interval(_intervals[i].$1, _intervals[i].$1 + 0.05),
        ),
      );

  // Icon grows from 0.72× to 1× while the letters are revealing.
  late final Animation<double> _iconGrow = Tween<double>(begin: 0.72, end: 1)
      .animate(
        CurvedAnimation(
          parent: _ctrl,
          curve: const Interval(0.06, 0.952, curve: Curves.easeOut),
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
          duration: const Duration(milliseconds: 500),
          child: Container(
            color: _bg,
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (_, _) => FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon — slides in smoothly, then grows as letters reveal
                    FadeTransition(
                      opacity: Tween<double>(begin: 0, end: 1).animate(
                        CurvedAnimation(
                          parent: _ctrl,
                          curve: const Interval(0, 0.07),
                        ),
                      ),
                      child: ScaleTransition(
                        scale: _iconGrow,
                        child: SlideTransition(
                          position:
                              Tween<Offset>(
                                begin: const Offset(-0.4, 0),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: _ctrl,
                                  curve: const Interval(
                                    0,
                                    0.35,
                                    curve: Curves.easeOutCubic,
                                  ),
                                ),
                              ),
                          child: ClipRect(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              widthFactor: 0.44,
                              child: Image.asset(
                                'assets/images/logo.png',
                                height: 140,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // "Buckets" — letters zoom in one by one, each slower
                    for (int i = 0; i < _letters.length; i++)
                      ScaleTransition(
                        scale: _letterScale(i),
                        child: FadeTransition(
                          opacity: _letterFade(i),
                          child: Text(
                            _letters[i],
                            style: const TextStyle(
                              fontFamily: 'Geist',
                              fontSize: 38,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
