import 'package:buckets/bootstrap/me_use_cases.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'about_controller.g.dart';

/// Screen 32 About: the app and device facts.
@riverpod
class AboutController extends _$AboutController {
  @override
  Future<AppInfo> build() async =>
      (await ref.read(getAppInfoProvider)()).orThrow();

  /// Opens the store listing.
  Future<void> openStoreListing() => ref.read(openStoreListingProvider)();
}
