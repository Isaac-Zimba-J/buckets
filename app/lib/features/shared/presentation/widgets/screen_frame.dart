import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';

/// The page every screen sits in: `bg`, a header, scrolling content and
/// optional pinned bottom actions that stay above the keyboard.
class ScreenFrame extends StatelessWidget {
  /// Creates the frame.
  const ScreenFrame({
    required this.header,
    required this.children,
    this.actions = const [],
    super.key,
  });

  /// A `BkTopBar` or `BkFlowHeader`.
  final Widget header;

  /// The scrolling content.
  final List<Widget> children;

  /// Pinned buttons at the bottom.
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.bk.colors.bg,
    body: SafeArea(
      bottom: actions.isEmpty,
      child: Column(
        children: [
          header,
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(BkSpacing.s4),
              children: children,
            ),
          ),
        ],
      ),
    ),
    // `bottomNavigationBar` so floating toasts sit above the actions; the
    // keyboard height is added under them, because the Scaffold only
    // resizes its body for the keyboard and would leave them covered.
    bottomNavigationBar: actions.isEmpty
        ? null
        : Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: BkBottomActions(children: actions),
          ),
  );
}
