import 'package:buckets_ui_kit/src/components/bk_icon_button.dart';
import 'package:buckets_ui_kit/src/components/bk_progress_bar.dart';
import 'package:buckets_ui_kit/src/components/bk_top_bar.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/widgets.dart';

/// The header of a multi-step flow: back button, the step label
/// ("2 of 5") centred and a thin progress bar beneath.
///
/// ```dart
/// BkFlowHeader(step: 2, total: 5, stepLabel: '2 of 5',
///     backLabel: 'Back', onBack: pop)
/// ```
class BkFlowHeader extends StatelessWidget {
  /// Creates the header; [stepLabel] is the text from the app.
  const BkFlowHeader({
    required this.step,
    required this.total,
    required this.stepLabel,
    required this.backLabel,
    this.onBack,
    super.key,
  });

  /// The current step, from 1.
  final int step;

  /// How many steps.
  final int total;

  /// The label, e.g. "2 of 5".
  final String stepLabel;

  /// The back button's accessible name.
  final String backLabel;

  /// Goes back; null hides the button (first step).
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final back = onBack;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BkTopBar(
          leading: back == null
              ? null
              : BkIconButton(
                  icon: BkIcons.back,
                  semanticLabel: backLabel,
                  onPressed: back,
                ),
          title: stepLabel,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: BkSpacing.s4),
          child: BkProgressBar(value: step / total, height: 4),
        ),
      ],
    );
  }
}
