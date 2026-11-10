import 'package:buckets/features/home/presentation/screens/home_screen.dart';
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
    _ => const _NotBuiltYet(),
  };
}

class _NotBuiltYet extends StatelessWidget {
  const _NotBuiltYet();

  @override
  Widget build(BuildContext context) =>
      Scaffold(backgroundColor: context.bk.colors.bg);
}
