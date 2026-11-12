import 'package:equatable/equatable.dart';

/// What a step's action does (SCREENS 30). The app wires each kind to the
/// matching port (SystemSettingsOpener for the system shortcuts).
enum HelpStepActionKind {
  /// No action beyond reading the step.
  none,

  /// Open Android's notification-access settings.
  openNotificationAccess,

  /// Open the app's battery-optimisation settings.
  openBatterySettings,
}

/// One step inside a help article (SCREENS 30: numbered 1/2/3 cards).
final class HelpStep with Equatable {
  /// Creates a step.
  const new({
    required this.title,
    required this.body,
    this.actionKind = HelpStepActionKind.none,
    this.actionLabel,
  });

  /// Short heading, e.g. "Notification access is off".
  final String title;

  /// Explanation under the heading.
  final String body;

  /// What the button at the end does; `none` draws no button.
  final HelpStepActionKind actionKind;

  /// Label for the button, e.g. "Open settings".
  final String? actionLabel;

  @override
  List<Object?> get props => [title, body, actionKind, actionLabel];
}
