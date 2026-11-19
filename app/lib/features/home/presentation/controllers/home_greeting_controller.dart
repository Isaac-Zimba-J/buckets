import 'package:buckets/bootstrap/me_use_cases.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_greeting_controller.g.dart';

/// The chosen greeting and name for the Home header, live.
@riverpod
Stream<ProfileSummary> homeGreeting(Ref ref) =>
    ref.watch(watchProfileSummaryProvider)();
