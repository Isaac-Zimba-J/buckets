import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/alerts/value_objects/message_template.dart';
import 'package:buckets_domain/src/alerts/value_objects/parsed_message.dart';

/// MTN MoMo message templates based only on redacted owner-provided fixtures.
final List<MessageTemplate> mtnMessageTemplates = [
  MessageTemplate(
    source: AlertSource.mtnMomo,
    name: 'mtn-received-sender-at-time',
    direction: MessageDirection.incoming,
    pattern: RegExp(
      r"^Y'ello\. You have received ZMW (?<amount>[\d,.]+) from "
      '(?<counterparty>.+?) on your mobile money account at '
      r'(?<date>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\. Message from sender: \. '
      r'Financial Transaction ID: (?<reference>\d+)\. Dial \*115# to view balance\. '
      r'Thank you for using Momo from MTN\.$',
    ),
    parseDate: parseMtnDate,
  ),
  MessageTemplate(
    source: AlertSource.mtnMomo,
    name: 'mtn-purchase',
    direction: MessageDirection.outgoing,
    pattern: RegExp(
      r"^Y'ello\. Payment of ZMW (?<amount>[\d,.]+) to "
      '(?<counterparty>.+?) successful at '
      r'(?<date>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\..*?'
      r'Your new balance: (?<balance>[\d,.]+) ZMW\.Financial Transaction ID: '
      r'(?<reference>\d+)\..*$',
    ),
    parseDate: parseMtnDate,
  ),
  MessageTemplate(
    source: AlertSource.mtnMomo,
    name: 'mtn-received-at-time',
    direction: MessageDirection.incoming,
    pattern: RegExp(
      r"^Y'ello\. You have received ZMW (?<amount>[\d,.]+) ZMW from "
      '(?<counterparty>.+?) at '
      r'(?<date>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\. '
      r'Dial \*115# to view balance\. Thank you for using Momo from MTN\.$',
    ),
    parseDate: parseMtnDate,
  ),
];

/// Parses the fixture's MTN wall-clock timestamp into a UTC instant.
DateTime? parseMtnDate(String raw, Duration utcOffset) {
  final match = RegExp(r'^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})$')
      .firstMatch(raw);
  if (match == null) return null;
  final parts = [for (var i = 1; i <= 6; i++) int.parse(match[i]!)];
  final [year, month, day, hour, minute, second] = parts;
  final wall = DateTime.utc(year, month, day, hour, minute, second);
  if (wall.year != year ||
      wall.month != month ||
      wall.day != day ||
      wall.hour != hour ||
      wall.minute != minute ||
      wall.second != second) {
    return null;
  }
  return wall.subtract(utcOffset);
}
