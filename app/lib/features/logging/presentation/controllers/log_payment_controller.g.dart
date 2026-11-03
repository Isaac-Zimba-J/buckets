// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_payment_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 19 Log a payment.

@ProviderFor(LogPaymentController)
final logPaymentControllerProvider = LogPaymentControllerProvider._();

/// Screen 19 Log a payment.
final class LogPaymentControllerProvider
    extends $NotifierProvider<LogPaymentController, LogPaymentState> {
  /// Screen 19 Log a payment.
  LogPaymentControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logPaymentControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logPaymentControllerHash();

  @$internal
  @override
  LogPaymentController create() => LogPaymentController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LogPaymentState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LogPaymentState>(value),
    );
  }
}

String _$logPaymentControllerHash() =>
    r'8f4cb084361eff5b5697d3466ff3a4ff85ff32b0';

/// Screen 19 Log a payment.

abstract class _$LogPaymentController extends $Notifier<LogPaymentState> {
  LogPaymentState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<LogPaymentState, LogPaymentState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LogPaymentState, LogPaymentState>,
              LogPaymentState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
