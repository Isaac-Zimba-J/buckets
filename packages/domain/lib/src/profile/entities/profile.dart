import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// How the user is greeted (R-PROFILE-1). Each value carries the word it
/// shows; the Zambian greetings come first.
enum Greeting {
  /// Bemba "how are you".
  muliShani('Muli shani'),

  /// Nyanja "welcome".
  mwaiseni('Mwaiseni'),

  /// Plain English.
  hello('Hello');

  new(this.word);

  /// The greeting word shown to the user.
  final String word;
}

/// The local, on-device profile (DOMAIN §16, R-PROFILE-1). No email, phone
/// number or password; currency is fixed to kwacha and is not stored here.
final class Profile with Equatable {
  const new _({
    required this.displayName,
    required this.greeting,
    required this.timeZone,
    required this.createdAt,
  });

  /// The longest a [displayName] may be (R-PROFILE-1).
  static const maxNameLength = 30;

  /// Validates and creates a profile. [displayName] is optional; a blank
  /// name is stored as `null` so greetings fall back to the word alone
  /// (R-PROFILE-2).
  static Result<Profile> create({
    required DateTime createdAt,
    String? displayName,
    Greeting greeting = Greeting.muliShani,
    String timeZone = 'Africa/Lusaka',
  }) {
    final name = displayName?.trim() ?? '';
    return validated(
      [
        requireText(timeZone, 'timeZone'),
        requireUtc(createdAt, 'createdAt'),
        if (name.isNotEmpty)
          requireMaxLength(name, maxNameLength, 'displayName'),
      ],
      () => Profile._(
        displayName: name.isEmpty ? null : name,
        greeting: greeting,
        timeZone: timeZone.trim(),
        createdAt: createdAt,
      ),
    );
  }

  /// A validated copy with the given fields replaced. Pass an empty
  /// [displayName] to clear the name.
  Result<Profile> copyWith({
    String? displayName,
    Greeting? greeting,
    String? timeZone,
    DateTime? createdAt,
  }) => create(
    displayName: displayName ?? this.displayName,
    greeting: greeting ?? this.greeting,
    timeZone: timeZone ?? this.timeZone,
    createdAt: createdAt ?? this.createdAt,
  );

  /// The chosen name, or `null` when none was given.
  final String? displayName;

  /// The greeting style.
  final Greeting greeting;

  /// IANA time zone used for payday alarms and quiet hours (R-TIME-1).
  final String timeZone;

  /// When the profile was created, in UTC (R-TIME-1).
  final DateTime createdAt;

  /// The greeting line (R-PROFILE-2): the word with the name, or the word
  /// alone when there is no name.
  String get greetingLine =>
      displayName == null ? greeting.word : '${greeting.word}, $displayName';

  /// The avatar letter (R-PROFILE-3): the first letter of the name in upper
  /// case, or `null` when there is no name (the UI then shows a neutral
  /// icon).
  String? get avatarInitial => displayName?.substring(0, 1).toUpperCase();

  @override
  List<Object?> get props => [displayName, greeting, timeZone, createdAt];
}
