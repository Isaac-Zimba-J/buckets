/// Sample pages showing every ui_kit component in every state. Used by the
/// gallery app and the golden tests; not part of the main barrel, so the
/// app never ships them (ADR-0005).
library;

import 'package:buckets_ui_kit/src/gallery/actions_page.dart';
import 'package:buckets_ui_kit/src/gallery/bills_page.dart';
import 'package:buckets_ui_kit/src/gallery/containers_page.dart';
import 'package:buckets_ui_kit/src/gallery/feedback_page.dart';
import 'package:buckets_ui_kit/src/gallery/foundation_page.dart';
import 'package:buckets_ui_kit/src/gallery/inputs_page.dart';
import 'package:buckets_ui_kit/src/gallery/money_widgets_page.dart';
import 'package:buckets_ui_kit/src/gallery/navigation_page.dart';
import 'package:buckets_ui_kit/src/gallery/tokens_page.dart';
import 'package:flutter/widgets.dart';

export 'src/gallery/actions_page.dart';
export 'src/gallery/bills_page.dart';
export 'src/gallery/containers_page.dart';
export 'src/gallery/feedback_page.dart';
export 'src/gallery/foundation_page.dart';
export 'src/gallery/inputs_page.dart';
export 'src/gallery/money_widgets_page.dart';
export 'src/gallery/navigation_page.dart';
export 'src/gallery/tokens_page.dart';

/// Every gallery page with its title, in reading order.
const List<(String, Widget)> galleryPages = [
  ('Tokens', TokensPage()),
  ('Foundation', FoundationPage()),
  ('Actions', ActionsPage()),
  ('Inputs', InputsPage()),
  ('Containers', ContainersPage()),
  ('Feedback', FeedbackPage()),
  ('Money widgets', MoneyWidgetsPage()),
  ('Navigation', NavigationPage()),
  ('Bills and fees', BillsPage()),
];
