import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';

HelpArticle _article({
  required String id,
  required String title,
  required String body,
  List<String> keywords = const [],
  List<HelpStep> steps = const [],
  bool isCommonQuestion = false,
  String? topic,
}) => switch (HelpArticle.create(
  id: id,
  title: title,
  body: body,
  keywords: keywords,
  steps: steps,
  isCommonQuestion: isCommonQuestion,
  topic: topic,
)) {
  Ok(:final value) => value,
  Err(:final failure) => throw StateError('Bad help article $id: $failure'),
};

/// Topic groups shown as topic cards on SCREENS 29.
abstract final class HelpTopics {
  /// Getting started.
  static const gettingStarted = 'Getting started';

  /// Payday and proof flow.
  static const paydayAndProof = 'Payday & proof';

  /// MoMo and Airtel alerts.
  static const momoAndAirtelAlerts = 'MoMo & Airtel alerts';

  /// Receipts and cash.
  static const receiptsAndCash = 'Receipts & cash';

  /// Buckets and splits.
  static const bucketsAndSplits = 'Buckets & splits';

  /// Privacy and safety.
  static const privacyAndSafety = 'Privacy & safety';
}

/// The bundled help articles (SCREENS 29–30). Written per WRITING.md and
/// shipped with the app; nothing is fetched over the network (R-PRIV-1).
final List<HelpArticle> helpArticles = [
  _article(
    id: 'how-payday-works',
    title: 'How payday works',
    topic: HelpTopics.paydayAndProof,
    keywords: ['payday', 'split', 'salary', 'transfer', 'savings'],
    body: '''
When your pay lands, Buckets splits it the way you set up: some for Living,
some for bills, some for your goals and savings.

For money that sits in another account — your savings or a goal wallet — you
make the transfer yourself, then paste the confirmation so Buckets can check
it really moved. Once every transfer is proven, payday is done and your
Living money unlocks for the cycle.
''',
  ),
  _article(
    id: 'proving-a-transfer',
    title: 'Proving a transfer',
    topic: HelpTopics.paydayAndProof,
    keywords: ['prove', 'proof', 'transfer', 'paste', 'confirmation'],
    body: '''
After you move money to savings, paste the confirmation message. Buckets
checks four things: the amount, where it went, that it is recent, and that
you have not used the same message before.

If a check does not pass, you can save part of it and owe the rest, try
another message, or mark it as self-reported. Nothing leaves your phone.
''',
  ),
  _article(
    id: 'sorting-payments',
    title: 'Sorting your payments',
    topic: HelpTopics.momoAndAirtelAlerts,
    keywords: ['sort', 'alert', 'category', 'file', 'spend', 'rule'],
    body: '''
When you pay for something, Buckets reads the payment alert and asks which
bucket it came from and what it was for. Tap to sort it.

Tick "Always file this" and Buckets remembers the merchant, so next time it
files the payment for you. You can change those rules any time under Me →
Auto-filing rules.
''',
  ),
  _article(
    id: 'scanning-receipts',
    title: 'Scanning a receipt',
    topic: HelpTopics.receiptsAndCash,
    keywords: ['receipt', 'scan', 'camera', 'ocr', 'photo'],
    body: '''
Snap a photo of a receipt and Buckets reads the total and the items on the
phone. Check the total, split the items across buckets if you need to, and
save.

The reading happens on your phone. The photo stays on your phone too.
''',
  ),
  _article(
    id: 'app-lock',
    title: 'Locking the app',
    topic: HelpTopics.privacyAndSafety,
    keywords: ['lock', 'pin', 'fingerprint', 'security', 'privacy'],
    body: '''
Turn on App lock under Me → Security and Buckets asks for your phone's own
screen lock — your PIN, pattern or fingerprint — when you open it.

Buckets keeps no separate PIN. If your phone has no screen lock, set one
first, then turn App lock on.
''',
  ),
  _article(
    id: 'your-data',
    title: 'Your data stays on your phone',
    topic: HelpTopics.privacyAndSafety,
    keywords: ['privacy', 'data', 'offline', 'network', 'delete', 'backup'],
    body: '''
Buckets works fully offline and makes no network calls. Your messages,
balances, accounts and receipts never leave the phone.

Raw payment-alert text is kept for 90 days so Buckets can re-read it, then
deleted; the amounts you sorted stay. You can clear that text early, or
delete everything, under Me → Data & privacy.
''',
  ),

  // Common questions (shown in a list on screen 29).
  _article(
    id: 'why-payments-not-showing',
    title: "Why aren't my MoMo payments showing?",
    topic: HelpTopics.momoAndAirtelAlerts,
    isCommonQuestion: true,
    keywords: ['alert', 'momo', 'airtel', 'notifications', 'battery'],
    body:
        "Buckets reads payment alerts as they arrive. If they stop, it's "
        'usually one of these.',
    steps: const [
      HelpStep(
        title: 'Notification access is off',
        body: 'Buckets needs it to see MoMo and Airtel alerts.',
        actionKind: HelpStepActionKind.openNotificationAccess,
        actionLabel: 'Open settings',
      ),
      HelpStep(
        title: 'Alerts are muted on your phone',
        body:
            'Make sure notifications for the MoMo, Airtel and SMS apps are '
            'allowed.',
      ),
      HelpStep(
        title: 'Battery saver closed Buckets',
        body:
            "Some phones stop apps in the background. Set Buckets' battery "
            'use to Unrestricted.',
        actionKind: HelpStepActionKind.openBatterySettings,
        actionLabel: 'Open settings',
      ),
    ],
  ),
  _article(
    id: 'proof-keeps-failing',
    title: 'My proof keeps failing',
    topic: HelpTopics.paydayAndProof,
    isCommonQuestion: true,
    keywords: ['proof', 'fails', 'payday', 'transfer'],
    body:
        'Buckets checks four things in the confirmation message. The common '
        'misses are:',
    steps: const [
      HelpStep(
        title: 'Wrong amount or account',
        body:
            'The message has to show the amount and name that match the '
            'transfer.',
      ),
      HelpStep(
        title: 'The message is older than 24 hours',
        body:
            "Send a fresh transfer or paste today's confirmation. Old "
            "messages don't count.",
      ),
      HelpStep(
        title: 'You already used that message',
        body:
            'Each proof message can only count once. Make a new transfer, '
            'then paste its message.',
      ),
    ],
  ),
  _article(
    id: 'change-split-mid-month',
    title: 'Can I change my split mid-month?',
    topic: HelpTopics.bucketsAndSplits,
    isCommonQuestion: true,
    keywords: ['split', 'change', 'edit', 'month'],
    body:
        'Yes. Open Me → Split, change the shares to new percentages adding '
        'up to 100, and save. Your next payday uses the new split; the '
        'money already allocated this cycle stays put.',
  ),
];
