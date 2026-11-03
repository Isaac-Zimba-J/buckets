import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'welcome_controller.g.dart';

/// Screen 01 Welcome: ready only. True once setup is complete, which the
/// router uses to skip setup.
@riverpod
class WelcomeController extends _$WelcomeController {
  @override
  Future<bool> build() async =>
      (await ref.watch(getSetupStatusProvider)()).orThrow();
}
