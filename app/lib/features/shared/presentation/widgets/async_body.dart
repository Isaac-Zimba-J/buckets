import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shows an `AsyncValue`: skeleton rows while loading, an error banner
/// with "Try again", or [data] (PATTERNS states).
class AsyncBody<T> extends StatelessWidget {
  /// Creates the body.
  const AsyncBody({
    required this.value,
    required this.data,
    required this.onRetry,
    super.key,
  });

  /// The controller's state.
  final AsyncValue<T> value;

  /// Builds the loaded content.
  final Widget Function(T value) data;

  /// Rebuilds the controller.
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return switch (value) {
      AsyncData(:final value) => data(value),
      AsyncError() => Padding(
        padding: const EdgeInsets.all(BkSpacing.s4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BkBanner(tone: BkTone.danger, message: l.errLoad),
            const BkGap(BkSpacing.s3),
            BkButton.secondary(label: l.tryAgain, onPressed: onRetry),
          ],
        ),
      ),
      _ => const Padding(
        padding: EdgeInsets.all(BkSpacing.s4),
        child: Column(
          children: [
            BkSkeleton(height: 56),
            BkGap(BkSpacing.s3),
            BkSkeleton(height: 56),
            BkGap(BkSpacing.s3),
            BkSkeleton(height: 56),
          ],
        ),
      ),
    };
  }
}
