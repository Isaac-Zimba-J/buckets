import 'dart:async';

import 'package:buckets/features/payday/presentation/controllers/payday_controller.dart';
import 'package:buckets/features/payday/presentation/controllers/proof_controller.dart';
import 'package:buckets/features/payday/presentation/widgets/proof_checks.dart';
import 'package:buckets/features/setup/presentation/widgets/setup_header.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screens 14–15 Prove transfer: paste the confirmation SMS, see the four
/// checks; on a failure, paste another, save part, or mark it as saved.
class ProofScreen extends ConsumerStatefulWidget {
  /// Creates the screen for one transfer of a payday.
  const ProofScreen({
    required this.paydayId,
    required this.transferId,
    super.key,
  });

  /// The payday.
  final String paydayId;

  /// The transfer to prove.
  final String transferId;

  @override
  ConsumerState<ProofScreen> createState() => _ProofScreenState();
}

class _ProofScreenState extends ConsumerState<ProofScreen> {
  String _text = '';

  ProofControllerProvider get _provider =>
      proofControllerProvider(widget.paydayId, widget.transferId);

  void _back() => context.go(Routes.payday(widget.paydayId));

  Future<void> _paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text;
    if (text != null && mounted) setState(() => _text = text);
  }

  void _tryAnother() {
    ref.read(_provider.notifier).reset();
    setState(() => _text = '');
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    ref.listen(_provider, (_, next) {
      if (next is ProofSaved) _back();
    });
    final s = ref.watch(_provider);
    final row = ref
        .watch(paydayControllerProvider(widget.paydayId))
        .value
        ?.transfers
        .where((t) => t.id == widget.transferId)
        .firstOrNull;
    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.back,
          semanticLabel: l.back,
          onPressed: _back,
        ),
        title: row == null
            ? null
            : '${row.bucketName} · ${money(row.owed ?? row.amount)}',
      ),
      actions: _actions(l, s),
      children: [
        SetupTitle(l.proofTitle, intro: l.proofBody),
        if (s case ProofFailed(:final checks, :final read)) ...[
          proofFailBanner(l, checks, read),
          const BkGap(BkSpacing.s4),
        ],
        BkSmsField(
          label: l.proofField,
          pasteLabel: l.proofPaste,
          hint: l.proofHint,
          value: _text,
          error: s is ProofFailed,
          onChanged: (v) => setState(() => _text = v),
          onPaste: s is ProofPassed ? null : () => unawaited(_paste()),
        ),
        if (s
            case ProofPassed(:final checks, :final read) ||
                ProofFailed(:final checks, :final read)) ...[
          const BkGap(BkSpacing.s4),
          ProofChecks(checks: checks, read: read),
        ],
      ],
    );
  }

  List<Widget> _actions(AppLocalizations l, ProofState s) {
    final notifier = ref.read(_provider.notifier);
    final markSaved = BkButton.text(
      label: l.proofMarkSaved,
      onPressed: () => unawaited(notifier.markSelfReported()),
    );
    return switch (s) {
      ProofPassed() => [BkButton.primary(label: l.done, onPressed: _back)],
      ProofFailed(:final canSavePartial, :final parsed, :final owed) => [
        BkButton.primary(label: l.proofTryAnother, onPressed: _tryAnother),
        if (canSavePartial && parsed != null && owed != null) ...[
          BkButton.text(
            label: l.proofSavePartial(money(parsed), money(owed)),
            onPressed: () => unawaited(notifier.savePartial()),
          ),
          _Caption(l.proofPartialNote(money(owed))),
        ],
        markSaved,
      ],
      ProofIdle() || ProofChecking() || ProofSaved() => [
        BkButton.primary(
          label: l.proofCheck,
          loading: s is ProofChecking,
          onPressed: _text.trim().isEmpty
              ? null
              : () => unawaited(notifier.check(_text)),
          disabledReason: _text.trim().isEmpty ? l.proofEmpty : null,
        ),
        markSaved,
        _Caption(l.proofSelfReportedNote),
      ],
    };
  }
}

class _Caption extends StatelessWidget {
  const _Caption(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    textAlign: TextAlign.center,
    style: context.bk.type.caption.copyWith(color: context.bk.colors.inkMuted),
  );
}
