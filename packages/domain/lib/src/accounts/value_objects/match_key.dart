import 'package:buckets_core/buckets_core.dart';
import 'package:equatable/equatable.dart';

final _spaces = RegExp(r'\s+');

/// Text that identifies an account in confirmation messages, such as the
/// last 4 digits or the registered name (DOMAIN §2).
final class MatchKey with Equatable {
  const new _(this.value);

  /// Normalizes and validates [raw] (R-ACC-3).
  static Result<MatchKey> create(String raw) {
    final value = normalize(raw);
    return value.length < minLength
        ? const Err(
            ValidationFailure(
              'matchKey.tooShort',
              'A match key needs at least 3 characters.',
            ),
          )
        : Ok(MatchKey._(value));
  }

  /// The shortest allowed key, after normalizing.
  static const minLength = 3;

  /// Lower-cases [text] and collapses runs of whitespace (R-ACC-3).
  static String normalize(String text) =>
      text.trim().replaceAll(_spaces, ' ').toLowerCase();

  /// The normalized key.
  final String value;

  /// Whether this key appears in [text], compared per R-ACC-3.
  bool isFoundIn(String text) => normalize(text).contains(value);

  @override
  List<Object?> get props => [value];
}
