import 'package:flutter/widgets.dart';

/// The smallest touch target, in logical pixels (DESIGN_SYSTEM
/// accessibility rules).
const double bkMinTapTarget = 44;

/// Makes [child] at least [bkMinTapTarget] square, centred, so small
/// visuals still get a full-size hit area.
///
/// ```dart
/// BkTapTarget(child: BkIcon(BkIcons.close))
/// ```
class BkTapTarget extends StatelessWidget {
  /// Wraps [child].
  const BkTapTarget({required this.child, super.key});

  /// The visual inside the hit area.
  final Widget child;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: const BoxConstraints(
      minWidth: bkMinTapTarget,
      minHeight: bkMinTapTarget,
    ),
    child: Center(widthFactor: 1, heightFactor: 1, child: child),
  );
}

/// Marks [child] as a heading for screen readers.
///
/// ```dart
/// BkHeading(child: Text('Payday'))
/// ```
class BkHeading extends StatelessWidget {
  /// Wraps [child].
  const BkHeading({required this.child, super.key});

  /// The heading text.
  final Widget child;

  @override
  Widget build(BuildContext context) => Semantics(header: true, child: child);
}

/// Reads [label] instead of [child]'s own semantics, e.g. a money row
/// read as one sentence.
///
/// ```dart
/// BkSemanticLabel(label: 'Living, K 1,540 left', child: row)
/// ```
class BkSemanticLabel extends StatelessWidget {
  /// Wraps [child] with [label].
  const BkSemanticLabel({required this.label, required this.child, super.key});

  /// What screen readers say.
  final String label;

  /// The visual.
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      Semantics(label: label, excludeSemantics: true, child: child);
}
