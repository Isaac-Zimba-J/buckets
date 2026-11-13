import 'package:buckets/features/bills/presentation/screens/bill_history_screen.dart';
import 'package:buckets/features/bills/presentation/screens/bill_pay_screen.dart';
import 'package:buckets/features/bills/presentation/screens/bills_cycle_screen.dart';
import 'package:buckets/features/bills/presentation/screens/fee_rates_screen.dart';
import 'package:buckets/features/bills/presentation/screens/fees_screen.dart';
import 'package:buckets/features/help/presentation/screens/help_article_screen.dart';
import 'package:buckets/features/help/presentation/screens/help_screen.dart';
import 'package:buckets/features/help/presentation/screens/report_screen.dart';
import 'package:buckets/features/home/presentation/screens/bucket_detail_screen.dart';
import 'package:buckets/features/home/presentation/screens/goals_screen.dart';
import 'package:buckets/features/home/presentation/screens/home_screen.dart';
import 'package:buckets/features/home/presentation/screens/plan_screen.dart';
import 'package:buckets/features/home/presentation/screens/spend_history_screen.dart';
import 'package:buckets/features/logging/presentation/screens/check_in_screen.dart';
import 'package:buckets/features/logging/presentation/screens/log_payment_screen.dart';
import 'package:buckets/features/logging/presentation/screens/receipt_review_screen.dart';
import 'package:buckets/features/logging/presentation/screens/scan_screen.dart';
import 'package:buckets/features/logging/presentation/screens/sort_sheet_screen.dart';
import 'package:buckets/features/me/presentation/screens/about_screen.dart';
import 'package:buckets/features/me/presentation/screens/data_privacy_screen.dart';
import 'package:buckets/features/me/presentation/screens/me_screen.dart';
import 'package:buckets/features/me/presentation/screens/rules_screen.dart';
import 'package:buckets/features/me/presentation/screens/security_screen.dart';
import 'package:buckets/features/me/presentation/screens/settings_screen.dart';
import 'package:buckets/features/payday/presentation/screens/income_received_screen.dart';
import 'package:buckets/features/payday/presentation/screens/payday_done_screen.dart';
import 'package:buckets/features/payday/presentation/screens/payday_screen.dart';
import 'package:buckets/features/payday/presentation/screens/proof_screen.dart';
import 'package:buckets/features/setup/presentation/screens/accounts_screen.dart';
import 'package:buckets/features/setup/presentation/screens/bills_screen.dart';
import 'package:buckets/features/setup/presentation/screens/income_screen.dart';
import 'package:buckets/features/setup/presentation/screens/permissions_screen.dart';
import 'package:buckets/features/setup/presentation/screens/profile_screen.dart';
import 'package:buckets/features/setup/presentation/screens/split_screen.dart';
import 'package:buckets/features/setup/presentation/screens/welcome_screen.dart';
import 'package:buckets/routing/routes.dart';
import 'package:flutter/material.dart';

/// The real screen for each route.
Widget appScreen(AppScreen screen, Map<String, String> params) {
  final fromMe = params['from'] == 'me';
  return switch (screen) {
    AppScreen.welcome => const WelcomeScreen(),
    AppScreen.income => IncomeScreen(fromMe: fromMe),
    AppScreen.bills => BillsScreen(fromMe: fromMe),
    AppScreen.split => SplitScreen(
      incomeId: params['incomeId']!,
      fromMe: fromMe,
    ),
    AppScreen.accounts => AccountsScreen(fromMe: fromMe),
    AppScreen.permissions => PermissionsScreen(fromMe: fromMe),
    AppScreen.home => const HomeScreen(),
    AppScreen.me => const MeScreen(),
    AppScreen.goals => const GoalsScreen(),
    AppScreen.plan => PlanScreen(
      initialTab: params['tab'] == 'wishes' ? PlanTab.wishes : PlanTab.toBuy,
    ),
    AppScreen.bucket => BucketDetailScreen(bucketId: params['bucketId']!),
    AppScreen.sort => const SortSheetScreen(),
    AppScreen.log => const LogPaymentScreen(),
    AppScreen.checkIn => const CheckInScreen(),
    AppScreen.scan => const ScanScreen(),
    AppScreen.receipt => ReceiptReviewScreen(receiptId: params['draftId']!),
    AppScreen.payday => PaydayScreen(paydayId: params['paydayId']!),
    AppScreen.proof => ProofScreen(
      paydayId: params['paydayId']!,
      transferId: params['transferId']!,
    ),
    AppScreen.paydayDone => PaydayDoneScreen(paydayId: params['paydayId']!),
    AppScreen.incomeReceived => IncomeReceivedScreen(
      alertId: params['alertId']!,
    ),
    // Profile, settings and help screens arrive in S-01b / S-10b / S-11;
    // their routes and controllers (AP-02b/AP-03b) are ready.
    AppScreen.profile => ProfileScreen(fromMe: fromMe),
    AppScreen.settings => const SettingsScreen(),
    AppScreen.security => const SecurityScreen(),
    AppScreen.dataPrivacy => const DataPrivacyScreen(),
    AppScreen.rules => const RulesScreen(),
    AppScreen.help => const HelpScreen(),
    AppScreen.helpArticle => HelpArticleScreen(articleId: params['articleId']!),
    AppScreen.report => const ReportScreen(),
    AppScreen.about => const AboutScreen(),
    AppScreen.billsCycle => const BillsCycleScreen(),
    AppScreen.billPay => BillPayScreen(billId: params['billId']!),
    AppScreen.billHistory => BillHistoryScreen(billId: params['billId']!),
    AppScreen.fees => const FeesScreen(),
    AppScreen.feeRates => const FeeRatesScreen(),
    AppScreen.spendHistory => const SpendHistoryScreen(),
  };
}
