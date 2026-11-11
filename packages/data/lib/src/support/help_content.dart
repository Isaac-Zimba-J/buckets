import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';

HelpArticle _article({
  required String id,
  required String title,
  required String body,
  List<String> keywords = const [],
}) => switch (HelpArticle.create(
  id: id,
  title: title,
  body: body,
  keywords: keywords,
)) {
  Ok(:final value) => value,
  Err(:final failure) => throw StateError('Bad help article $id: $failure'),
};

/// The bundled help articles (SCREENS 29–30). Written per WRITING.md and
/// shipped with the app; nothing is fetched over the network (R-PRIV-1).
final List<HelpArticle> helpArticles = [
  _article(
    id: 'how-payday-works',
    title: 'How payday works',
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
    keywords: ['privacy', 'data', 'offline', 'network', 'delete', 'backup'],
    body: '''
Buckets works fully offline and makes no network calls. Your messages,
balances, accounts and receipts never leave the phone.

Raw payment-alert text is kept for 90 days so Buckets can re-read it, then
deleted; the amounts you sorted stay. You can clear that text early, or
delete everything, under Me → Data & privacy.
''',
  ),
];
