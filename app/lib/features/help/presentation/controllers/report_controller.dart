import 'package:buckets/bootstrap/app_config.dart';
import 'package:buckets/bootstrap/me_use_cases.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_controller.freezed.dart';
part 'report_controller.g.dart';

/// Screen 31 Report a problem. The app opens the email app; it sends nothing
/// itself (R-SUPPORT-1). App info is attached only on request (R-SUPPORT-2).
@freezed
abstract class ReportState with _$ReportState {
  /// The form; [sent] after the email app opened, [errorCode] on failure.
  const factory ReportState({
    @Default(ProblemCategory.somethingWrong) ProblemCategory category,
    @Default('') String text,
    @Default(false) bool includeAppInfo,
    @Default(false) bool sending,
    @Default(false) bool sent,
    String? errorCode,
  }) = _ReportState;
}

/// Screen 31, live.
@riverpod
class ReportController extends _$ReportController {
  @override
  ReportState build() => const ReportState();

  /// Sets the report category.
  void setCategory(ProblemCategory category) =>
      state = state.copyWith(category: category);

  /// Sets the report text.
  void setText(String text) => state = state.copyWith(text: text);

  /// Whether to attach app info (R-SUPPORT-2).
  void setIncludeAppInfo({required bool include}) =>
      state = state.copyWith(includeAppInfo: include);

  /// Builds the report and opens the email app; true when it opened.
  Future<bool> send() async {
    state = state.copyWith(sending: true, errorCode: null);
    final report = await ref.read(buildProblemReportProvider)(
      category: state.category,
      text: state.text,
      includeAppInfo: state.includeAppInfo,
    );
    switch (report) {
      case Err(:final failure):
        state = state.copyWith(sending: false, errorCode: failure.code);
        return false;
      case Ok(:final value):
        final opened = await ref.read(openEmailComposerProvider)(
          value,
          to: AppConfig.supportEmail,
        );
        switch (opened) {
          case Ok():
            state = state.copyWith(sending: false, sent: true);
            return true;
          case Err(:final failure):
            state = state.copyWith(sending: false, errorCode: failure.code);
            return false;
        }
    }
  }
}
