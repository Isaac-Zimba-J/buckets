import 'package:shared_preferences/shared_preferences.dart';

/// Remembers notification IDs already handed to the system, so re-plans never
/// re-show them. A tiny flag store (ARCHITECTURE §9).
abstract interface class SentLog {
  /// All IDs that were ever sent.
  Future<Set<String>> load();

  /// Records [ids] as sent (idempotent, append-only).
  Future<void> add(Iterable<String> ids);
}

/// [SentLog] in shared preferences; keeps the latest [limit] IDs.
final class PrefsSentLog implements SentLog {
  /// Creates the log. [limit] defaults to 500.
  new({SharedPreferencesAsync? prefs, this.limit = 500})
    : _prefs = prefs ?? SharedPreferencesAsync();

  /// How many IDs to keep.
  final int limit;

  final SharedPreferencesAsync _prefs;

  static const _key = 'notifications.sent';

  @override
  Future<Set<String>> load() async =>
      (await _prefs.getStringList(_key) ?? const []).toSet();

  @override
  Future<void> add(Iterable<String> ids) async {
    final current = await _prefs.getStringList(_key) ?? const [];
    final set = current.toSet();
    ids.forEach(set.add);
    final all = set.toList();
    await _prefs.setStringList(
      _key,
      all.length > limit ? all.sublist(all.length - limit) : all,
    );
  }
}

/// [SentLog] in memory, for tests and demo mode.
final class MemorySentLog implements SentLog {
  /// Creates the log.
  new();

  final _ids = <String>{};

  @override
  Future<Set<String>> load() async => _ids.toSet();

  @override
  Future<void> add(Iterable<String> ids) async => _ids.addAll(ids);
}
