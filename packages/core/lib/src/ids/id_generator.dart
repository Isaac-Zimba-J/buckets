/// The only source of new entity IDs (AGENTS.md §3).
///
/// Implemented by `UuidGenerator` in `data`; tests use a sequential fake.
abstract interface class IdGenerator {
  /// A new, unique ID.
  String newId();
}
