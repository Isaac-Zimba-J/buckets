import 'package:buckets_ui_kit/src/components/row_text.dart';
import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icon.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/widgets.dart';

/// Where a step stands.
enum BkStepState {
  /// Finished.
  done,

  /// The current step.
  active,

  /// Still to come.
  todo,
}

/// One step of a [BkStepList].
class BkStep {
  /// Creates the step.
  const BkStep(this.title, this.state, {this.subtitle});

  /// The step name.
  final String title;

  /// An optional muted line.
  final String? subtitle;

  /// Where it stands.
  final BkStepState state;
}

/// Numbered steps joined by a line: the check-in, setup progress.
///
/// ```dart
/// BkStepList(steps: [BkStep('Sort payments', BkStepState.done),
///     BkStep('Count cash', BkStepState.active)])
/// ```
class BkStepList extends StatelessWidget {
  /// Creates the list.
  const BkStepList({required this.steps, super.key});

  /// The steps, in order.
  final List<BkStep> steps;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      for (final (i, step) in steps.indexed)
        _StepRow(step: step, number: i + 1, last: i == steps.length - 1),
    ],
  );
}

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.step,
    required this.number,
    required this.last,
  });

  final BkStep step;
  final int number;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final c = bk.colors;
    final done = step.state == BkStepState.done;
    final active = step.state == BkStepState.active;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: done ? c.action : c.surface,
                  border: done
                      ? null
                      : Border.all(
                          color: active ? c.ink : c.controlBorder,
                          width: active ? 2 : 1.5,
                        ),
                ),
                child: Center(
                  child: done
                      ? BkIcon(BkIcons.check, size: 16, color: c.onAction)
                      : Text(
                          '$number',
                          style: bk.type.caption.copyWith(
                            color: active ? c.ink : c.inkMuted,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              if (!last)
                Expanded(
                  child: Container(width: 2, color: done ? c.action : c.line),
                ),
            ],
          ),
          const BkGap(BkSpacing.s3),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: BkSpacing.s1,
                bottom: last ? 0 : BkSpacing.s5,
              ),
              child: Semantics(
                selected: active,
                child: RowText(title: step.title, subtitle: step.subtitle),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
