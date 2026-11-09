import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:flutter/widgets.dart';

/// The meaning of a banner or badge, and so its colours.
enum BkTone {
  /// Money in, proven transfers.
  positive,

  /// "Please check".
  warning,

  /// Overspent, failed proof. Errors only.
  danger,

  /// Neutral information.
  info,

  /// No signal (badges only).
  neutral;

  /// Text and icon colour.
  Color foreground(BuildContext context) {
    final c = context.bk.colors;
    return switch (this) {
      positive => c.positive,
      warning => c.warning,
      danger => c.danger,
      info => c.info,
      neutral => c.inkMuted,
    };
  }

  /// Background tint.
  Color tint(BuildContext context) {
    final c = context.bk.colors;
    return switch (this) {
      positive => c.positiveTint,
      warning => c.warningTint,
      danger => c.dangerTint,
      info => c.infoTint,
      neutral => c.surfaceSunken,
    };
  }

  /// The banner icon.
  BkIcons get icon => switch (this) {
    positive => BkIcons.check,
    warning || danger => BkIcons.warning,
    info || neutral => BkIcons.info,
  };
}
