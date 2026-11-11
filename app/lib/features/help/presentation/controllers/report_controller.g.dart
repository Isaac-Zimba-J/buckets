// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 31, live.

@ProviderFor(ReportController)
final reportControllerProvider = ReportControllerProvider._();

/// Screen 31, live.
final class ReportControllerProvider
    extends $NotifierProvider<ReportController, ReportState> {
  /// Screen 31, live.
  ReportControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportControllerHash();

  @$internal
  @override
  ReportController create() => ReportController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportState>(value),
    );
  }
}

String _$reportControllerHash() => r'06a59402a446e1794dbc83a33a8029a4bc897eac';

/// Screen 31, live.

abstract class _$ReportController extends $Notifier<ReportState> {
  ReportState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ReportState, ReportState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReportState, ReportState>,
              ReportState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
