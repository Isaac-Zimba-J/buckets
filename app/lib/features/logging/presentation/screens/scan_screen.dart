import 'package:buckets/features/logging/presentation/controllers/scan_controller.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 20 Scan receipt: take or pick a photo, read it on the phone,
/// then review it (screen 21).
class ScanScreen extends ConsumerWidget {
  /// Creates the screen.
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final s = ref.watch(scanControllerProvider);
    final notifier = ref.read(scanControllerProvider.notifier);
    ref.listen(scanControllerProvider, (_, next) {
      if (next case ScanRecognized(:final receiptId)) {
        context.go(Routes.receipt(receiptId));
      }
    });
    final busy = s is ScanProcessing;
    return Scaffold(
      backgroundColor: bk.colors.hero,
      body: SafeArea(
        child: Column(
          children: [
            BkTopBar(
              leading: BkIconButton(
                icon: BkIcons.close,
                semanticLabel: l.close,
                variant: BkIconButtonVariant.onDark,
                onPressed: () => context.go(Routes.log),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(BkSpacing.s4),
                child: Center(
                  child: switch (s) {
                    ScanProcessing() => const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BkSkeleton(height: 28, width: 200),
                        BkGap(BkSpacing.s3),
                        BkSkeleton(height: 16),
                        BkGap(BkSpacing.s2),
                        BkSkeleton(height: 16),
                      ],
                    ),
                    ScanNoText() => BkBanner(
                      tone: BkTone.danger,
                      message: l.scanNoText,
                    ),
                    ScanPermissionDenied() => BkBanner(
                      tone: BkTone.warning,
                      message: l.scanNoCamera,
                    ),
                    _ => Text(
                      l.scanHint,
                      textAlign: TextAlign.center,
                      style: bk.type.body.copyWith(color: bk.colors.onHero),
                    ),
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(BkSpacing.s5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BkIconButton(
                    icon: BkIcons.plan,
                    semanticLabel: l.scanGallery,
                    variant: BkIconButtonVariant.onDark,
                    onPressed: busy
                        ? null
                        : () => notifier.capture(CaptureSource.gallery),
                  ),
                  if (s is ScanNoText)
                    BkButton.text(
                      label: l.scanRetake,
                      onPressed: notifier.retake,
                    )
                  else
                    BkFab(
                      semanticLabel: l.scanShutter,
                      onPressed: busy
                          ? () {}
                          : () => notifier.capture(CaptureSource.camera),
                    ),
                  const SizedBox.square(dimension: bkMinTapTarget),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
