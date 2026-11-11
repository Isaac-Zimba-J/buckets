import 'package:buckets/routing/router_provider.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'screen_harness.dart';

void main() {
  testWidgets('first run: 01 → 06 lands on Home (S-01)', (tester) async {
    final c = fakeContainer();
    addTearDown(c.dispose);
    await pumpApp(tester, c);

    // 01 Welcome.
    expect(find.text(l.welcomeTitle), findsOneWidget);
    await tapOn(tester, find.text(l.welcomeStart));

    // 01b About you: name is optional; Continue moves on.
    expect(find.text(l.stepOf(1, 6)), findsOneWidget);
    expect(find.text(l.profileTitle), findsWidgets);
    await type(tester, l.profileName, 'Isaac');
    await tapOn(tester, find.text(l.continueLabel));

    // 02 Income: Continue needs an income; Save needs an account.
    expect(find.text(l.stepOf(2, 6)), findsOneWidget);
    expect(find.text(l.errNoIncome), findsOneWidget);
    expect(find.text(l.incomeNeedAccount), findsOneWidget);
    await tapOn(tester, find.text(l.incomeLandsIn));
    await tapOn(tester, find.text(l.accountAdd));
    await type(tester, l.accountName, '[MOMO]');
    await type(tester, l.accountMatchKey, '0977');
    await tapOn(tester, find.text(l.accountSpending));
    await tapOn(tester, find.widgetWithText(BkButton, l.save));
    expect(find.text('[MOMO]'), findsOneWidget);
    await type(tester, l.incomeName, 'Salary');
    await typeAmount(tester, '12000');
    await type(tester, l.incomePayday, '25');
    await tapOn(tester, find.text(l.incomeSave));
    expect(find.text(l.incomePaydayOn(25)), findsOneWidget);
    await tapOn(tester, find.text(l.continueLabel));

    // 03 Bills: empty, then one bill and the total.
    expect(find.text(l.billsEmptyTitle), findsOneWidget);
    await tapOn(tester, find.widgetWithText(BkButton, l.billsAdd));
    await type(tester, l.billName, 'Rent');
    await typeAmount(tester, '2500');
    await type(tester, l.billDueDay, '1');
    await tapOn(tester, find.widgetWithText(BkButton, l.save));
    expect(find.text('Rent'), findsOneWidget);
    expect(find.text(l.billsTotal), findsOneWidget);
    await tapOn(tester, find.text(l.continueLabel));

    // 04 Split: the default split adds up.
    expect(find.text(l.splitTotalOk(100)), findsOneWidget);
    await tapOn(tester, find.text(l.continueLabel));

    // 05 Accounts: everything says Choose until placed.
    expect(find.text(l.choose), findsWidgets);
    await tapOn(tester, find.text('Living'));
    await tapOn(tester, find.widgetWithText(BkRadioCard, '[MOMO]'));
    await tapOn(tester, find.text(l.accountsLater));

    // 06 Alarms & alerts → Home.
    expect(find.text(l.permNotifications), findsOneWidget);
    await tapOn(tester, find.text(l.permsFinish));
    expect(c.read(routerProvider).state.uri.path, Routes.home);
  });
}
