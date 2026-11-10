import 'dart:async';

/// Emits [combine] of the latest values of [a] and [b] once both have
/// emitted, and again whenever either does.
Stream<R> combineLatest2<A, B, R>(
  Stream<A> a,
  Stream<B> b,
  R Function(A a, B b) combine,
) {
  late final StreamController<R> out;
  StreamSubscription<A>? subA;
  StreamSubscription<B>? subB;
  (bool, A?) lastA = (false, null);
  (bool, B?) lastB = (false, null);
  void emit() {
    if (lastA.$1 && lastB.$1) out.add(combine(lastA.$2 as A, lastB.$2 as B));
  }

  out = StreamController<R>(
    onListen: () {
      subA = a.listen((v) {
        lastA = (true, v);
        emit();
      }, onError: out.addError);
      subB = b.listen((v) {
        lastB = (true, v);
        emit();
      }, onError: out.addError);
    },
    onCancel: () {
      unawaited(subA?.cancel());
      unawaited(subB?.cancel());
    },
  );
  return out.stream;
}

/// [combineLatest2] for three streams.
Stream<R> combineLatest3<A, B, C, R>(
  Stream<A> a,
  Stream<B> b,
  Stream<C> c,
  R Function(A a, B b, C c) combine,
) => combineLatest2(
  combineLatest2<A, B, (A, B)>(a, b, (a, b) => (a, b)),
  c,
  (ab, c) => combine(ab.$1, ab.$2, c),
);
