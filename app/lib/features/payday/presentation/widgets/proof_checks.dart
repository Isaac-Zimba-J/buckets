import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/payday/presentation/controllers/payday_view_models.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The four proof checks in a card (screens 14–15): a heading with how
/// many passed, then a row per check with what the message said.
class ProofChecks extends ConsumerWidget {
  /// Creates the card.
  const ProofChecks({required this.checks, required this.read, super.key});

  /// The checks, in display order.
  final List<CheckRowVm> checks;

  /// What the message said.
  final ProofReadVm read;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final passed = checks.where((c) => c.passed).length;
    final all = passed == checks.length;
    return BkCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BkHeading(
            child: Text(
              all ? l.proofAllPassed : l.proofSomePassed(passed),
              style: bk.type.overline.copyWith(
                color: all ? bk.colors.positive : bk.colors.inkMuted,
              ),
            ),
          ),
          const BkGap(BkSpacing.s2),
          for (final c in checks)
            BkProofCheckRow(
              label: _label(l, c.check),
              value: _value(context, ref, c),
              result: c.passed
                  ? BkCheckResult.passed
                  : c.unknown
                  ? BkCheckResult.unknown
                  : BkCheckResult.failed,
            ),
        ],
      ),
    );
  }

  static String _label(AppLocalizations l, ProofCheck check) => switch (check) {
    ProofCheck.amount => l.proofCheckAmount,
    ProofCheck.account => l.proofCheckAccount,
    ProofCheck.date => l.proofCheckDate,
    ProofCheck.reference => l.proofCheckReference,
  };

  String _value(BuildContext context, WidgetRef ref, CheckRowVm c) {
    final l = AppLocalizations.of(context);
    if (c.unknown) return l.proofNotFound;
    return switch (c.check) {
      ProofCheck.amount => switch (read.amount) {
        final a? when c.passed => money(a, showNgwee: true),
        final a? => l.proofAmountMismatch(money(a), money(read.due)),
        null => l.proofNotFound,
      },
      ProofCheck.account => read.counterparty ?? l.proofNotFound,
      ProofCheck.date => switch (read.occurredAt) {
        final at? => _when(ref, at),
        null => l.proofNotFound,
      },
      ProofCheck.reference =>
        c.passed ? l.proofReferenceNew : l.proofReferenceUsed,
    };
  }

  static String _when(WidgetRef ref, DateTime at) {
    final zone = ref.read(localTimeZoneProvider);
    final today = wallTime(ref.read(clockProvider).now(), zone);
    final w = wallTime(at, zone);
    return '${DateFormatter.date(w, today: today)} · ${DateFormatter.time(w)}';
  }
}

/// The danger banner for a failed proof: the first check that failed, in
/// display order, says what to do (R-PROOF-2).
BkBanner proofFailBanner(
  AppLocalizations l,
  List<CheckRowVm> checks,
  ProofReadVm read,
) {
  final failed = checks.firstWhere((c) => !c.passed);
  final parsed = money(read.amount ?? Money.zero);
  final due = money(read.due);
  final (title, message) = failed.unknown
      ? (l.proofFailUnknownTitle, l.proofFailUnknown)
      : switch (failed.reason) {
          'amountTooLow' => (
            l.proofFailAmountLowTitle,
            l.proofFailAmountLow(parsed, due),
          ),
          'amountTooHigh' => (
            l.proofFailAmountHighTitle,
            l.proofFailAmountHigh(parsed, due),
          ),
          'accountMismatch' => (l.proofFailAccountTitle, l.proofFailAccount),
          'notTodayOrYesterday' => (l.proofFailDateTitle, l.proofFailDate),
          'beforePayday' => (
            l.proofFailBeforePaydayTitle,
            l.proofFailBeforePayday,
          ),
          'referenceUsed' => (l.proofFailReferenceTitle, l.proofFailReference),
          _ => (l.proofFailUnknownTitle, l.proofFailUnknown),
        };
  return BkBanner(tone: BkTone.danger, title: title, message: message);
}
