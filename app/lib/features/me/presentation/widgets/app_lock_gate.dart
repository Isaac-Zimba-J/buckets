import 'dart:async';

import 'package:buckets/features/me/presentation/controllers/app_lock_controller.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Covers the app with the lock screen while `AppLockController` says so,
/// and tells it when the app goes away and comes back.
class AppLockGate extends ConsumerStatefulWidget {
  /// Wraps [child], the routed app.
  const AppLockGate({required this.child, super.key});

  /// What the lock covers.
  final Widget child;

  @override
  ConsumerState<AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends ConsumerState<AppLockGate> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(
      onHide: () => ref.read(appLockControllerProvider.notifier).backgrounded(),
      onResume: () =>
          unawaited(ref.read(appLockControllerProvider.notifier).resumed()),
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locked = ref.watch(appLockControllerProvider).value ?? false;
    return Stack(
      children: [
        // Hidden from screen readers and taps while locked.
        ExcludeSemantics(
          excluding: locked,
          child: IgnorePointer(ignoring: locked, child: widget.child),
        ),
        if (locked) const Positioned.fill(child: _LockScreen()),
      ],
    );
  }
}

class _LockScreen extends ConsumerWidget {
  const _LockScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    return Material(
      color: bk.colors.bg,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(BkSpacing.s4),
          child: Column(
            children: [
              Expanded(
                child: BkEmptyState(
                  icon: BkIcons.lock,
                  title: l.lockTitle,
                  message: l.lockBody,
                ),
              ),
              BkButton.primary(
                label: l.lockUnlock,
                onPressed: () => unawaited(
                  ref.read(appLockControllerProvider.notifier).unlock(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
