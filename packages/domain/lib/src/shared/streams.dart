import 'dart:async';

/// Emits whenever any of [streams] emits, then recomputes with [read].
/// Lets live screens (Home, bucket detail) refresh from several
/// repositories without another dependency.
Stream<T> recomputeOn<T>(
  List<Stream<Object?>> streams,
  Future<T> Function() read,
) {
  late final StreamController<void> changes;
  final subs = <StreamSubscription<Object?>>[];
  changes = StreamController<void>(
    onListen: () {
      for (final s in streams) {
        subs.add(s.listen((_) => changes.add(null), onError: changes.addError));
      }
    },
    // Not awaited: an idle `async*` source may never finish cancelling, and
    // `Stream.first` waits for the cancel to complete.
    onCancel: () {
      for (final s in subs) {
        unawaited(s.cancel());
      }
    },
  );
  return changes.stream.asyncMap((_) => read());
}
