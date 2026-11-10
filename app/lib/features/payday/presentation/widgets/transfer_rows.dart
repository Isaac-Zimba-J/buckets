import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/payday/presentation/controllers/payday_view_models.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// The payday checklist (screen 13): a row per transfer with its badge;
/// rows still open (pending or partial) open the proof.
class TransferRows extends ConsumerWidget {
  /// Creates the list.
  const TransferRows({required this.paydayId, required this.rows, super.key});

  /// The payday the rows belong to.
  final String paydayId;

  /// The transfers.
  final List<TransferRowVm> rows;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final zone = ref.watch(localTimeZoneProvider);
    return BkListGroup(
      children: [
        for (final r in rows)
          BkTransferRow(
            bucketLabel: r.bucketName,
            color: r.color.bk,
            amountText: money(r.owed ?? r.amount),
            destination: r.destination.isEmpty ? '' : l.paydayTo(r.destination),
            status: _status(r.status),
            statusLabel: switch (r.status) {
              TransferStatus.pending => l.paydayNeedsProof,
              TransferStatus.proven => switch (r.provenAt) {
                final at? => l.paydayProvenAt(
                  DateFormatter.time(wallTime(at, zone)),
                ),
                null => l.paydayProven,
              },
              TransferStatus.partial => l.paydayOwed(
                money(r.owed ?? Money.zero),
              ),
              TransferStatus.selfReported => l.paydaySelfReported,
            },
            onProve: _open(r)
                ? () => context.go(Routes.proof(paydayId, r.id))
                : null,
          ),
      ],
    );
  }

  static bool _open(TransferRowVm r) => switch (r.status) {
    TransferStatus.pending || TransferStatus.partial => true,
    TransferStatus.proven || TransferStatus.selfReported => false,
  };

  static BkTransferStatus _status(TransferStatus s) => switch (s) {
    TransferStatus.pending => BkTransferStatus.pending,
    TransferStatus.proven => BkTransferStatus.proven,
    TransferStatus.partial => BkTransferStatus.partial,
    TransferStatus.selfReported => BkTransferStatus.selfReported,
  };
}
