import 'package:buckets/features/home/presentation/screens/bucket_detail_screen.dart';
import 'package:buckets/features/home/presentation/screens/goals_screen.dart';
import 'package:buckets/features/home/presentation/screens/home_screen.dart';
import 'package:buckets/features/home/presentation/screens/plan_screen.dart';
import 'package:buckets/features/logging/presentation/screens/check_in_screen.dart';
import 'package:buckets/features/logging/presentation/screens/log_payment_screen.dart';
import 'package:buckets/features/logging/presentation/screens/receipt_review_screen.dart';
import 'package:buckets/features/logging/presentation/screens/scan_screen.dart';
import 'package:buckets/features/logging/presentation/screens/sort_sheet_screen.dart';
import 'package:buckets/features/payday/presentation/screens/income_received_screen.dart';
import 'package:buckets/features/payday/presentation/screens/payday_done_screen.dart';
import 'package:buckets/features/payday/presentation/screens/payday_screen.dart';
import 'package:buckets/features/payday/presentation/screens/proof_screen.dart';
import 'package:buckets/features/setup/presentation/screens/accounts_screen.dart';
import 'package:buckets/features/setup/presentation/screens/bills_screen.dart';
import 'package:buckets/features/setup/presentation/screens/income_screen.dart';
import 'package:buckets/features/setup/presentation/screens/permissions_screen.dart';
import 'package:buckets/features/setup/presentation/screens/split_screen.dart';
import 'package:buckets/features/setup/presentation/screens/welcome_screen.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';

/// The real screen for each route; screens not built yet show an empty
/// page until their S-* task.
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
    _ => const _NotBuiltYet(),
  };
}

class _NotBuiltYet extends StatelessWidget {
  const _NotBuiltYet();

  @override
  Widget build(BuildContext context) =>
      Scaffold(backgroundColor: context.bk.colors.bg);
}
