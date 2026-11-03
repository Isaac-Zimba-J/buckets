// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_review_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 21 for [receiptId].

@ProviderFor(ReceiptReviewController)
final receiptReviewControllerProvider = ReceiptReviewControllerFamily._();

/// Screen 21 for [receiptId].
final class ReceiptReviewControllerProvider
    extends
        $AsyncNotifierProvider<ReceiptReviewController, ReceiptReviewState> {
  /// Screen 21 for [receiptId].
  ReceiptReviewControllerProvider._({
    required ReceiptReviewControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'receiptReviewControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$receiptReviewControllerHash();

  @override
  String toString() {
    return r'receiptReviewControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ReceiptReviewController create() => ReceiptReviewController();

  @override
  bool operator ==(Object other) {
    return other is ReceiptReviewControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$receiptReviewControllerHash() =>
    r'd7722c35f5289dd95fee63e2749122c7ca2ed86e';

/// Screen 21 for [receiptId].

final class ReceiptReviewControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ReceiptReviewController,
          AsyncValue<ReceiptReviewState>,
          ReceiptReviewState,
          FutureOr<ReceiptReviewState>,
          String
        > {
  ReceiptReviewControllerFamily._()
    : super(
        retry: null,
        name: r'receiptReviewControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Screen 21 for [receiptId].

  ReceiptReviewControllerProvider call(String receiptId) =>
      ReceiptReviewControllerProvider._(argument: receiptId, from: this);

  @override
  String toString() => r'receiptReviewControllerProvider';
}

/// Screen 21 for [receiptId].

abstract class _$ReceiptReviewController
    extends $AsyncNotifier<ReceiptReviewState> {
  late final _$args = ref.$arg as String;
  String get receiptId => _$args;

  FutureOr<ReceiptReviewState> build(String receiptId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ReceiptReviewState>, ReceiptReviewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ReceiptReviewState>, ReceiptReviewState>,
              AsyncValue<ReceiptReviewState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
