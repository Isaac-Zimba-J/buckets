import 'package:equatable/equatable.dart';

/// What Data & privacy shows about on-device storage (SCREENS 27). All
/// counts are of local data; nothing leaves the device (R-PRIV-1).
final class StorageSummary with Equatable {
  /// Creates a storage summary.
  const new({
    required this.alertCount,
    required this.receiptCount,
    required this.databaseBytes,
  });

  /// How many stored payment alerts there are.
  final int alertCount;

  /// How many saved receipt images there are.
  final int receiptCount;

  /// The database file size, in bytes.
  final int databaseBytes;

  @override
  List<Object?> get props => [alertCount, receiptCount, databaseBytes];
}
