import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/foundation/bk_semantics.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// A bottom sheet: `surface`, `radius-xl` top corners, `shadow-sheet`,
/// 36 × 5 grabber, title in title-2, actions at the bottom. Show it with
/// [showBkSheet].
///
/// The sheet lifts above the on-screen keyboard by itself: its surface
/// grows by the keyboard's height (`MediaQuery.viewInsets.bottom`), so a
/// focused field and the actions stay visible. A body that can grow taller
/// than the space left should be scrollable (e.g. a `SingleChildScrollView`).
class BkBottomSheet extends StatelessWidget {
  /// Creates the sheet.
  const BkBottomSheet({
    required this.title,
    required this.child,
    this.actions = const [],
    super.key,
  });

  /// The heading.
  final String title;

  /// The body.
  final Widget child;

  /// Buttons at the bottom, stacked.
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final c = bk.colors;
    final top = Radius.circular(bk.radius.xl);
    // Zero when the keyboard is closed, or when a Scaffold above already
    // resized for it (an inline sheet in a screen body).
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.vertical(top: top),
        boxShadow: bk.shadows.sheet,
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: keyboard),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              BkSpacing.s4,
              BkSpacing.s2,
              BkSpacing.s4,
              BkSpacing.s4,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 5,
                    decoration: BoxDecoration(
                      color: c.controlBorder,
                      borderRadius: BorderRadius.circular(bk.radius.full),
                    ),
                  ),
                ),
                const BkGap(BkSpacing.s4),
                BkHeading(
                  child: Text(
                    title,
                    style: bk.type.title2.copyWith(color: c.ink),
                  ),
                ),
                const BkGap(BkSpacing.s4),
                Flexible(child: child),
                for (final a in actions) ...[const BkGap(BkSpacing.s2), a],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Shows a [BkBottomSheet] over the `scrim`; completes with the value the
/// sheet pops.
Future<T?> showBkSheet<T>(
  BuildContext context, {
  required String title,
  required Widget child,
  List<Widget> actions = const [],
}) => showModalBottomSheet<T>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  backgroundColor: Colors.transparent,
  barrierColor: context.bk.colors.scrim,
  builder: (_) => BkBottomSheet(title: title, actions: actions, child: child),
);
