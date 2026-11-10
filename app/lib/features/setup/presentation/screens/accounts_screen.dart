import 'package:buckets/features/setup/presentation/controllers/bucket_accounts_controller.dart';
import 'package:buckets/features/setup/presentation/widgets/account_picker_sheet.dart';
import 'package:buckets/features/setup/presentation/widgets/setup_header.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 05 Where buckets live.
class AccountsScreen extends ConsumerWidget {
  /// Creates the screen; [fromMe] when opened from the Me tab.
  const AccountsScreen({this.fromMe = false, super.key});

  /// Opened from Me rather than setup.
  final bool fromMe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final value = ref.watch(bucketAccountsControllerProvider);
    final someUnassigned = value.value?.someUnassigned ?? false;
    void next() => context.go(Routes.setupPermissions);
    return ScreenFrame(
      header: setupHeader(
        context,
        step: 4,
        fromMe: fromMe,
        title: l.accountsTitle,
        onBack: () => context.go(fromMe ? Routes.me : Routes.setupBills),
      ),
      actions: [
        if (!fromMe) ...[
          BkButton.primary(
            label: l.continueLabel,
            onPressed: someUnassigned ? null : next,
          ),
          if (someUnassigned)
            BkButton.text(label: l.accountsLater, onPressed: next),
        ],
      ],
      children: [
        if (!fromMe) SetupTitle(l.accountsTitle),
        BkBanner(tone: BkTone.info, message: l.accountsInfo),
        const BkGap(BkSpacing.s4),
        AsyncBody(
          value: value,
          onRetry: () => ref.invalidate(bucketAccountsControllerProvider),
          data: (s) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (s.errorCode case final code?) ...[
                BkBanner(tone: BkTone.danger, message: errorText(l, code)),
                const BkGap(BkSpacing.s3),
              ],
              BkListGroup(
                children: [
                  for (final b in s.buckets)
                    BkListRow(
                      leading: BkBucketDot(color: b.color.bk),
                      title: b.name,
                      trailing: b.warning || b.accountName == null
                          ? BkBadge(label: l.choose, tone: BkTone.warning)
                          : Text(
                              b.accountName!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.bk.type.body.copyWith(
                                color: context.bk.colors.inkMuted,
                              ),
                            ),
                      chevron: true,
                      onTap: () async {
                        final id = await pickAccount(
                          context,
                          title: l.accountsPick(b.name),
                          selected: b.accountId,
                        );
                        if (id != null) {
                          await ref
                              .read(bucketAccountsControllerProvider.notifier)
                              .assign(b.bucketId, id);
                        }
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
