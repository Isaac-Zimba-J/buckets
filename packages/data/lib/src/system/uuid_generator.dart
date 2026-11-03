import 'package:buckets_core/buckets_core.dart';
import 'package:uuid/uuid.dart';

/// Random v4 UUIDs for entity IDs (AGENTS.md §3).
final class UuidGenerator implements IdGenerator {
  /// Creates the generator.
  const new();

  static const _uuid = Uuid();

  @override
  String newId() => _uuid.v4();
}
