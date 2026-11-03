import 'package:shared_preferences/shared_preferences.dart';

/// Remembers once-only notifications already handed to the system, such as
/// N-LOW (once per cycle). A tiny flag store (ARCHITECTURE §9).
abstract interface class SentLog {
  /// Whether [id] was sent before.
  Future<bool> wasSent(String id);

  /// Records [id] as sent.
  Future<void> markSent(String id);
}

/// [SentLog] in shared preferences; keeps the latest [limit] IDs.
final class PrefsSentLog implements SentLog {
  /// Creates the log.
  new({SharedPreferencesAsync? prefs, this.limit = 50})
    : _prefs = prefs ?? SharedPreferencesAsync();

  /// How many IDs to keep.
  final int limit;

  final SharedPreferencesAsync _prefs;

  static const _key = 'notifications.sent';

  @override
  Future<bool> wasSent(String id) async =>
      (await _prefs.getStringList(_key) ?? const []).contains(id);

  @override
  Future<void> markSent(String id) async {
    final ids = [...?await _prefs.getStringList(_key), id];
    await _prefs.setStringList(
      _key,
      ids.length > limit ? ids.sublist(ids.length - limit) : ids,
    );
  }
}

/// [SentLog] in memory, for tests and demo mode.
final class MemorySentLog implements SentLog {
  /// Creates the log.
  new();

  final _ids = <String>{};

  @override
  Future<bool> wasSent(String id) async => _ids.contains(id);

  @override
  Future<void> markSent(String id) async => _ids.add(id);
}
