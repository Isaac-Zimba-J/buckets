// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_article_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 30, live; keyed by article id.

@ProviderFor(HelpArticleController)
final helpArticleControllerProvider = HelpArticleControllerFamily._();

/// Screen 30, live; keyed by article id.
final class HelpArticleControllerProvider
    extends $AsyncNotifierProvider<HelpArticleController, HelpArticleState> {
  /// Screen 30, live; keyed by article id.
  HelpArticleControllerProvider._({
    required HelpArticleControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'helpArticleControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$helpArticleControllerHash();

  @override
  String toString() {
    return r'helpArticleControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  HelpArticleController create() => HelpArticleController();

  @override
  bool operator ==(Object other) {
    return other is HelpArticleControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$helpArticleControllerHash() =>
    r'919a65e56269c0f0f98d1c46bc26ae6eb3732a53';

/// Screen 30, live; keyed by article id.

final class HelpArticleControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          HelpArticleController,
          AsyncValue<HelpArticleState>,
          HelpArticleState,
          FutureOr<HelpArticleState>,
          String
        > {
  HelpArticleControllerFamily._()
    : super(
        retry: null,
        name: r'helpArticleControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Screen 30, live; keyed by article id.

  HelpArticleControllerProvider call(String articleId) =>
      HelpArticleControllerProvider._(argument: articleId, from: this);

  @override
  String toString() => r'helpArticleControllerProvider';
}

/// Screen 30, live; keyed by article id.

abstract class _$HelpArticleController
    extends $AsyncNotifier<HelpArticleState> {
  late final _$args = ref.$arg as String;
  String get articleId => _$args;

  FutureOr<HelpArticleState> build(String articleId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<HelpArticleState>, HelpArticleState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HelpArticleState>, HelpArticleState>,
              AsyncValue<HelpArticleState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
