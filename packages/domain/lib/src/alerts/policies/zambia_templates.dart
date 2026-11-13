import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/alerts/value_objects/message_template.dart';
import 'package:buckets_domain/src/alerts/value_objects/parsed_message.dart';

// Amount group reused in every pattern: "30.00", "15,000.00", "10000".
const _a = r'[\d,]+(?:\.\d{1,2})?';

// TID/reference group: dots inside (e.g. "PP261028.2039.N00934"), no trailing
// dot captured.
const _tid = r'[^.\s]+(?:\.[^.\s]+)*';

// ─── Date parsers ────────────────────────────────────────────────────────────

/// DD/MM/YYYY (Airtel K-format received): midnight local → UTC.
DateTime? _airtelDate(String raw, Duration utcOffset) {
  final p = raw.split('/');
  if (p.length != 3) return null;
  final d = int.tryParse(p[0]);
  final m = int.tryParse(p[1]);
  final y = int.tryParse(p[2]);
  if (d == null || m == null || y == null) return null;
  return DateTime.utc(y, m, d).subtract(utcOffset);
}

/// "YYYY-MM-DD HH:mm:ss" or "YYYY-MM-DDTHH:mm:ss[.mmm]" (MTN local) → UTC.
/// Components are read as Zambia local time regardless of device timezone.
DateTime? _mtnDateTime(String raw, Duration utcOffset) {
  final dt = DateTime.tryParse(raw.trim().replaceFirst(' ', 'T'));
  if (dt == null) return null;
  return DateTime.utc(
    dt.year,
    dt.month,
    dt.day,
    dt.hour,
    dt.minute,
    dt.second,
  ).subtract(utcOffset);
}

// ─── Templates ───────────────────────────────────────────────────────────────

/// All Zambian mobile-money SMS templates, tried in order.
///
/// Written against redacted fixtures in
/// `packages/domain/test/fixtures/sms/`.
List<MessageTemplate> zambiaTemplates() => [
  // ── Airtel Money ──────────────────────────────────────────────────────────

  // "AIRTEL: You have received K15,000.00 from COMPANY LTD on 13/11/2026.
  //  Your new balance is K15,000.00. Ref: ART20261113001234"
  MessageTemplate(
    source: AlertSource.airtelMoney,
    name: 'airtel-received-k',
    direction: MessageDirection.incoming,
    pattern: RegExp(
      '^AIRTEL: You have received K(?<amount>$_a) from (?<counterparty>.+?)'
      r' on (?<date>\d{2}/\d{2}/\d{4})'
      r'\. Your new balance is K'
      '(?<balance>$_a)'
      r'\. Ref: (?<reference>\S+)$',
    ),
    parseDate: _airtelDate,
  ),

  // "You have received ZMW 30.00 from 097700000 Test Sender.Dial *115# ..."
  MessageTemplate(
    source: AlertSource.airtelMoney,
    name: 'airtel-received-p2p',
    direction: MessageDirection.incoming,
    pattern: RegExp(
      '^You have received ZMW (?<amount>$_a)'
      r' from \d+ (?<counterparty>[^.]+)'
      r'\.Dial \*115# to check your new Bal\. TID: '
      '(?<reference>$_tid)'
      r'\.',
    ),
  ),

  // "Money received ZMW 500.00 from 00000 TEST BUSINESS. Dial *115# ..."
  MessageTemplate(
    source: AlertSource.airtelMoney,
    name: 'airtel-received-business',
    direction: MessageDirection.incoming,
    pattern: RegExp(
      '^Money received ZMW (?<amount>$_a)'
      r' from \d+ (?<counterparty>[^.]+)'
      r'\. Dial \*115# to check balance\..*TID: '
      '(?<reference>$_tid)'
      r'$',
    ),
  ),

  // "You have withdrawn ZMW 500.00 from 00000 TEST AGENT. Bal is ZMW 1000.00.
  //  TID: CO261029.0940.Z37531."
  MessageTemplate(
    source: AlertSource.airtelMoney,
    name: 'airtel-withdrawal',
    direction: MessageDirection.outgoing,
    isWithdrawal: true,
    pattern: RegExp(
      '^You have withdrawn ZMW (?<amount>$_a)'
      r' from \d+ (?<counterparty>[^.]+)'
      r'\. Bal is ZMW '
      '(?<balance>$_a)'
      r'\. TID: '
      '(?<reference>$_tid)'
      r'\.',
    ),
  ),

  // "Txn. ID : LP261028.2111.F48853. Payment to TEST MERCHANT of ZMW 10.00
  //  is successful. Your Airtel Money balance is ZMW 100.00"
  MessageTemplate(
    source: AlertSource.airtelMoney,
    name: 'airtel-payment',
    direction: MessageDirection.outgoing,
    pattern: RegExp(
      r'^Txn\. ID : '
      '(?<reference>$_tid)'
      r'\. Payment to (?<counterparty>.+?) of ZMW '
      '(?<amount>$_a)'
      r' is successful\. Your Airtel Money balance is ZMW '
      '(?<balance>$_a)'
      r'$',
    ),
  ),

  // ── MTN MoMo ─────────────────────────────────────────────────────────────

  // "Y'ello. Payment of ZMW 10.00 to Test Merchant successful at
  //  2026-10-23 00:02:39.Message:- <embedded>. Your new balance: 100.00
  //  ZMW.Financial Transaction ID: 10887260323."
  MessageTemplate(
    source: AlertSource.mtnMomo,
    name: 'mtn-payment',
    direction: MessageDirection.outgoing,
    pattern: RegExp(
      "^Y'ello\\. Payment of ZMW (?<amount>$_a)"
      ' to (?<counterparty>.+?) successful at'
      r' (?<date>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})'
      r'\.Message:- .*?Your new balance: '
      '(?<balance>$_a)'
      r' ZMW\.Financial Transaction ID: (?<reference>\d+)\.',
      dotAll: true,
    ),
    parseDate: _mtnDateTime,
  ),

  // "Yello.You have received ZMW 500.00 from Test Sender  on your mobile
  //  money account at 2026-11-12 17:49:52. Message from sender: .
  //  Financial Transaction ID: 11088118256. ..."
  MessageTemplate(
    source: AlertSource.mtnMomo,
    name: 'mtn-received-simple',
    direction: MessageDirection.incoming,
    pattern: RegExp(
      '^Yello\\.You have received ZMW (?<amount>$_a)'
      r' from (?<counterparty>.+?)\s+on your mobile money account at'
      r' (?<date>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})'
      r'\. Message from sender: .*?Financial Transaction ID: (?<reference>\d+)\.',
      dotAll: true,
    ),
    parseDate: _mtnDateTime,
  ),

  // "Yello.You have received ZMW 500.00 from Test Business - Test Person
  //  (XXXXXXX0919) on your mobile money account at
  //  2026-11-12T17:49:52.264. Message from sender: MP... Financial
  //  Transaction ID: 11088118256."
  MessageTemplate(
    source: AlertSource.mtnMomo,
    name: 'mtn-received-with-sender',
    direction: MessageDirection.incoming,
    pattern: RegExp(
      '^Yello\\.You have received ZMW (?<amount>$_a)'
      r' from (?<counterparty>[^-\n]+?) - .+? on your mobile money account at'
      r' (?<date>\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?)'
      r'\. Message from sender: .+?Financial Transaction ID: (?<reference>\d+)\.',
    ),
    parseDate: _mtnDateTime,
  ),

  // "Y'ello. You have received ZMW 500.00 ZMW from Test Sender at
  //  2026-10-29 20:23:42. ..."
  MessageTemplate(
    source: AlertSource.mtnMomo,
    name: 'mtn-received-old',
    direction: MessageDirection.incoming,
    pattern: RegExp(
      "^Y'ello\\. You have received ZMW (?<amount>$_a)"
      ' ZMW from (?<counterparty>.+?) at'
      r' (?<date>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\.',
    ),
    parseDate: _mtnDateTime,
  ),

  // "You have withdrawn 350.00 ZMW from your mobile money account at  on
  //  2026-10-26 09:36:49. Your new balance:48.41 ZMW.
  //  Financial Transaction Id: 10917985317."
  MessageTemplate(
    source: AlertSource.mtnMomo,
    name: 'mtn-withdrawal',
    direction: MessageDirection.outgoing,
    isWithdrawal: true,
    pattern: RegExp(
      '^You have withdrawn (?<amount>$_a)'
      r' ZMW from your mobile money account at\s+on'
      r' (?<date>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})'
      r'\. Your new balance:(?<balance>' '$_a'
      r') ZMW\. Financial Transaction Id: (?<reference>\d+)\.',
    ),
    parseDate: _mtnDateTime,
  ),
];
