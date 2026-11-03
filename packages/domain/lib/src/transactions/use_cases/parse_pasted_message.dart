import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/policies/sms_parser.dart';
import 'package:buckets_domain/src/alerts/value_objects/parsed_message.dart';
import 'package:buckets_domain/src/shared/ports/local_time_zone.dart';

/// Reads a pasted payment message (screen 19, paste tab).
final class ParsePastedMessage {
  /// Creates the use case.
  const ParsePastedMessage(this._parser, this._clock, this._zone);

  final SmsParser _parser;
  final Clock _clock;
  final LocalTimeZone _zone;

  /// What could be read; never fails (R-PARSE-2).
  ParsedMessage call(String text) =>
      _parser.parse(text, utcOffset: _zone.offsetAt(_clock.now()));
}
