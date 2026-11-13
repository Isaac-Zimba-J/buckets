import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 01 Welcome.
class WelcomeScreen extends ConsumerStatefulWidget {
  /// Creates the screen.
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  bool _starting = false;
  late final AnimationController _anim;

  // Each element fades + rises in; delays are fractions of the 700 ms duration.
  late final Animation<double> _heroOpacity;
  late final Animation<Offset> _heroSlide;
  late final Animation<double> _titleOpacity;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _bodyOpacity;
  late final Animation<double> _buttonOpacity;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _heroOpacity = _fade(0, 0.5);
    _heroSlide = _rise(0, 0.5);
    _titleOpacity = _fade(0.15, 0.65);
    _titleSlide = _rise(0.15, 0.65);
    _bodyOpacity = _fade(0.3, 0.8);
    _buttonOpacity = _fade(0.45, 1);
    _anim.forward();
  }

  Animation<double> _fade(double start, double end) => CurvedAnimation(
    parent: _anim,
    curve: Interval(start, end, curve: Curves.easeOut),
  );

  Animation<Offset> _rise(double start, double end) =>
      Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _anim,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    setState(() => _starting = true);
    final result = await ref.read(firstRunSeedProvider)();
    if (!mounted) return;
    setState(() => _starting = false);
    switch (result) {
      case Ok():
        context.go(Routes.setupProfile);
      case Err():
        showBkToast(context, message: AppLocalizations.of(context).errGeneric);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    return Scaffold(
      backgroundColor: bk.colors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(BkSpacing.s4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              FadeTransition(
                opacity: _heroOpacity,
                child: SlideTransition(
                  position: _heroSlide,
                  child: const BkHeroCard(
                    child: BkSplitBar(
                      segments: [
                        (BkBucketColor.living, 4000),
                        (BkBucketColor.fun, 1000),
                        (BkBucketColor.emergency, 1000),
                        (BkBucketColor.short, 1000),
                        (BkBucketColor.long, 2000),
                        (BkBucketColor.goal, 1000),
                      ],
                    ),
                  ),
                ),
              ),
              const BkGap(BkSpacing.s6),
              FadeTransition(
                opacity: _titleOpacity,
                child: SlideTransition(
                  position: _titleSlide,
                  child: BkHeading(
                    child: Text(
                      l.welcomeTitle,
                      style: bk.type.display.copyWith(color: bk.colors.ink),
                    ),
                  ),
                ),
              ),
              const BkGap(BkSpacing.s3),
              FadeTransition(
                opacity: _bodyOpacity,
                child: Text(
                  l.welcomeBody,
                  style: bk.type.body.copyWith(color: bk.colors.inkMuted),
                ),
              ),
              const Spacer(),
              FadeTransition(
                opacity: _buttonOpacity,
                child: BkButton.primary(
                  label: l.welcomeStart,
                  loading: _starting,
                  onPressed: _start,
                ),
              ),
              const BkGap(BkSpacing.s3),
              FadeTransition(
                opacity: _buttonOpacity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BkIcon(BkIcons.lock, size: 16, color: bk.colors.inkMuted),
                    const BkGap(BkSpacing.s1),
                    Flexible(
                      child: Text(
                        l.welcomePrivacy,
                        textAlign: TextAlign.center,
                        style: bk.type.caption.copyWith(
                          color: bk.colors.inkMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
