import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/alerts/value_objects/parsed_message.dart';

/// Parses a provider's date text into a UTC instant, or null if it can't.
typedef DateParser = DateTime? Function(String raw, Duration utcOffset);

/// One provider message format (R-PARSE-1): a regex with named groups,
/// written only from redacted fixtures.
///
/// Recognised groups: `amount`, `fee`, `counterparty`, `reference`, `date`
/// (read with [parseDate]) and `balance`. Undeclared fields stay null.
final class MessageTemplate {
  /// Creates a template.
  const MessageTemplate({
    required this.source,
    required this.name,
    required this.direction,
    required this.pattern,
    this.parseDate,
  });

  /// The provider whose messages it reads.
  final AlertSource source;

  /// A short name for tests and debugging, e.g. `mtn-paid-merchant`.
  final String name;

  /// Which way money goes in messages it matches.
  final MessageDirection direction;

  /// Matched against the trimmed message text.
  final RegExp pattern;

  /// Reads the `date` group; required if the pattern declares one.
  final DateParser? parseDate;
}
