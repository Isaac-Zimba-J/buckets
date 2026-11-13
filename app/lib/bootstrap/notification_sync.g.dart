// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_sync.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The app's [NotificationSync]; `BucketsApp` keeps it alive.

@ProviderFor(notificationSync)
final notificationSyncProvider = NotificationSyncProvider._();

/// The app's [NotificationSync]; `BucketsApp` keeps it alive.

final class NotificationSyncProvider
    extends
        $FunctionalProvider<
          NotificationSync,
          NotificationSync,
          NotificationSync
        >
    with $Provider<NotificationSync> {
  /// The app's [NotificationSync]; `BucketsApp` keeps it alive.
  NotificationSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationSyncProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationSyncHash();

  @$internal
  @override
  $ProviderElement<NotificationSync> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NotificationSync create(Ref ref) {
    return notificationSync(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationSync value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationSync>(value),
    );
  }
}

String _$notificationSyncHash() => r'7eefe34eaba0095c0b5f5b309921279d0998a817';
