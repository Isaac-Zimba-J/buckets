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

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  bool _starting = false;

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
              const BkHeroCard(
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
              const BkGap(BkSpacing.s6),
              BkHeading(
                child: Text(
                  l.welcomeTitle,
                  style: bk.type.display.copyWith(color: bk.colors.ink),
                ),
              ),
              const BkGap(BkSpacing.s3),
              Text(
                l.welcomeBody,
                style: bk.type.body.copyWith(color: bk.colors.inkMuted),
              ),
              const Spacer(),
              BkButton.primary(
                label: l.welcomeStart,
                loading: _starting,
                onPressed: _start,
              ),
              const BkGap(BkSpacing.s3),
              Row(
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
            ],
          ),
        ),
      ),
    );
  }
}
