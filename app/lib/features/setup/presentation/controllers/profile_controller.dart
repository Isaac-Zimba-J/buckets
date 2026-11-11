import 'package:buckets/bootstrap/me_use_cases.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_controller.freezed.dart';
part 'profile_controller.g.dart';

/// "About you" (01b) and the profile edit from Me. An empty name is allowed;
/// greetings then fall back to the word alone (R-PROFILE-2).
@freezed
abstract class ProfileFormState with _$ProfileFormState {
  /// The editable fields plus save status.
  const factory ProfileFormState({
    required String displayName,
    required Greeting greeting,
    required String timeZone,
    @Default(false) bool saving,
    String? errorCode,
  }) = _ProfileFormState;
}

/// The profile form, live.
@riverpod
class ProfileController extends _$ProfileController {
  @override
  Future<ProfileFormState> build() async {
    final profile = (await ref.read(profileRepositoryProvider).get()).orThrow();
    final zone =
        profile?.timeZone ??
        switch (await ref.read(getDeviceTimeZoneProvider)()) {
          Ok(:final value) => value,
          Err() => 'Africa/Lusaka',
        };
    return ProfileFormState(
      displayName: profile?.displayName ?? '',
      greeting: profile?.greeting ?? Greeting.muliShani,
      timeZone: zone,
    );
  }

  /// Updates the name field.
  void setName(String name) {
    final current = state.value;
    if (current != null) state = AsyncData(current.copyWith(displayName: name));
  }

  /// Updates the greeting style.
  void setGreeting(Greeting greeting) {
    final current = state.value;
    if (current != null) {
      state = AsyncData(current.copyWith(greeting: greeting));
    }
  }

  /// Validates and saves; true on success.
  Future<bool> save() async {
    final current = state.value;
    if (current == null) return false;
    state = AsyncData(current.copyWith(saving: true, errorCode: null));
    final result = await ref.read(saveProfileProvider)(
      now: ref.read(clockProvider).now(),
      displayName: current.displayName,
      greeting: current.greeting,
      timeZone: current.timeZone,
    );
    switch (result) {
      case Ok():
        state = AsyncData(current.copyWith(saving: false));
        return true;
      case Err(:final failure):
        state = AsyncData(
          current.copyWith(saving: false, errorCode: failure.code),
        );
        return false;
    }
  }
}
