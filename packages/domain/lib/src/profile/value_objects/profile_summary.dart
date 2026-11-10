import 'package:buckets_domain/src/profile/entities/profile.dart';
import 'package:equatable/equatable.dart';

/// The profile view shown on the Me tab (SCREENS 24): who the user is.
///
/// The "proven paydays" and setup counts on that screen need dedicated
/// repository query methods and are a separate follow-up (D-15c).
final class ProfileSummary with Equatable {
  /// Creates a profile summary for the Me tab.
  const new({
    required this.displayName,
    required this.greeting,
    required this.avatarInitial,
  });

  /// Builds the summary from a [profile], or the defaults when none is set.
  factory ProfileSummary.of(Profile? profile) => ProfileSummary(
    displayName: profile?.displayName,
    greeting: profile?.greeting ?? Greeting.muliShani,
    avatarInitial: profile?.avatarInitial,
  );

  /// The chosen name, or `null`.
  final String? displayName;

  /// The greeting style.
  final Greeting greeting;

  /// The avatar letter, or `null` for a neutral icon (R-PROFILE-3).
  final String? avatarInitial;

  @override
  List<Object?> get props => [displayName, greeting, avatarInitial];
}
