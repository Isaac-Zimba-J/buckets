import 'package:buckets/features/setup/presentation/controllers/profile_controller.dart';
import 'package:buckets/features/setup/presentation/widgets/setup_header.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 01b About you: the local profile (name, greeting), step 1 of setup.
class ProfileScreen extends ConsumerWidget {
  /// Creates the screen; [fromMe] when opened from the Me tab.
  const ProfileScreen({this.fromMe = false, super.key});

  /// Opened from Me rather than setup.
  final bool fromMe;

  String _greetingLabel(AppLocalizations l, Greeting g) => switch (g) {
    Greeting.muliShani => l.greetingMuliShani,
    Greeting.mwaiseni => l.greetingMwaiseni,
    Greeting.hello => l.greetingHello,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final value = ref.watch(profileControllerProvider);
    final ctrl = ref.read(profileControllerProvider.notifier);

    Future<void> onContinue() async {
      if (await ctrl.save() && context.mounted) {
        context.go(fromMe ? Routes.me : Routes.setupIncome);
      }
    }

    return ScreenFrame(
      header: setupHeader(
        context,
        step: 1,
        fromMe: fromMe,
        title: l.profileTitle,
        onBack: () => context.go(fromMe ? Routes.me : Routes.welcome),
      ),
      actions: [
        BkButton.primary(
          label: fromMe ? l.save : l.continueLabel,
          onPressed: value.hasValue ? onContinue : null,
        ),
      ],
      children: [
        if (!fromMe) SetupTitle(l.profileTitle, intro: l.profileIntro),
        AsyncBody(
          value: value,
          onRetry: () => ref.invalidate(profileControllerProvider),
          data: (s) => _form(context, l, ctrl, s),
        ),
      ],
    );
  }

  Widget _form(
    BuildContext context,
    AppLocalizations l,
    ProfileController ctrl,
    ProfileFormState s,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      BkTextField(
        label: l.profileName,
        hint: l.profileNameHint,
        value: s.displayName,
        onChanged: ctrl.setName,
      ),
      const BkGap(BkSpacing.s5),
      Text(
        l.profileGreeting,
        style: context.bk.type.callout.copyWith(color: context.bk.colors.ink),
      ),
      const BkGap(BkSpacing.s2),
      BkSegmented<Greeting>(
        options: [
          for (final g in Greeting.values) BkSegment(g, _greetingLabel(l, g)),
        ],
        selected: s.greeting,
        onChanged: ctrl.setGreeting,
      ),
      const BkGap(BkSpacing.s5),
      BkListGroup(
        children: [
          BkListRow(
            title: l.profileTimeZone,
            subtitle: l.profileTimeZoneCaption,
            trailing: Text(
              s.timeZone,
              style: context.bk.type.callout.copyWith(
                color: context.bk.colors.inkMuted,
              ),
            ),
          ),
          BkListRow(
            title: l.profileCurrency,
            trailing: Text(
              l.profileCurrencyValue,
              style: context.bk.type.callout.copyWith(
                color: context.bk.colors.inkMuted,
              ),
            ),
          ),
        ],
      ),
      const BkGap(BkSpacing.s5),
      BkBanner(tone: BkTone.info, message: l.profileInfo),
    ],
  );
}
