import 'package:buckets/features/me/presentation/controllers/rules_controller.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 28 Auto-filing rules: the categories (R-CAT-1/2). Merchant-rule
/// editing follows when the repository gains watch/delete.
class RulesScreen extends ConsumerWidget {
  /// Creates the screen.
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final value = ref.watch(rulesControllerProvider);
    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.back,
          semanticLabel: l.back,
          onPressed: () => context.go(Routes.me),
        ),
        title: l.meRules,
      ),
      children: [
        AsyncBody(
          value: value,
          onRetry: () => ref.invalidate(rulesControllerProvider),
          data: (s) => _Body(state: s),
        ),
      ],
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.state});

  final RulesState state;

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final l = AppLocalizations.of(context);
    var name = '';
    await showBkSheet<void>(
      context,
      title: l.rulesAddCategory,
      child: BkTextField(
        label: l.rulesCategoryName,
        value: '',
        onChanged: (v) => name = v,
      ),
      actions: [
        Builder(
          builder: (sheet) => BkButton.primary(
            label: l.save,
            onPressed: () async {
              final ok = await ref
                  .read(rulesControllerProvider.notifier)
                  .add(name);
              if (sheet.mounted) Navigator.of(sheet).pop();
              if (!ok && context.mounted) {
                showBkToast(context, message: l.rulesDuplicate);
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final active = state.categories.where((c) => !c.archived).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Section(l.rulesCategories),
        Wrap(
          spacing: BkSpacing.s2,
          runSpacing: BkSpacing.s2,
          children: [
            for (final c in active)
              BkChip(label: c.name, selected: false, onTap: null),
            BkChip(
              label: '+ ${l.rulesAdd}',
              selected: false,
              onTap: () => _add(context, ref),
            ),
          ],
        ),
        const BkGap(BkSpacing.s5),
        BkBanner(tone: BkTone.info, message: l.rulesEmpty),
        const BkGap(BkSpacing.s8),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(this.title);
  final String title;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: BkSpacing.s3, bottom: BkSpacing.s2),
    child: BkHeading(
      child: Text(
        title.toUpperCase(),
        style: context.bk.type.overline.copyWith(
          color: context.bk.colors.inkMuted,
        ),
      ),
    ),
  );
}
