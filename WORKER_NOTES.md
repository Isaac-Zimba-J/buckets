# Worker notes

Repo-specific facts for implementation workers (Kilo coder/tester and the Sonnet worker). Keep it under 60 lines.

## Repo shape
Flutter pub workspace (Flutter 3.47.9 via fvm, melos 8.10.0). Android-only money app "Buckets".
- `packages/core` pure Dart (Money, Result, Clock). `packages/domain` pure Dart: entities, policies, use cases, ports.
- `packages/data` Flutter: drift DB, platform adapters (notifications, alert listener), in-memory fakes in `lib/src/fakes/`.
- `packages/ui_kit` design system (Bk* widgets). `app` Riverpod + go_router; providers in `app/lib/bootstrap/*.dart`.
- Native Android code: `app/android/app/src/main/kotlin/com/isaaczimba/buckets/`.
- Strings: `app/lib/l10n/app_en.arb` (generated `app_localizations*.dart` are committed).

## Checks (run from the repo root; run the ones matching the files you changed)
- Analyze: `dart analyze --fatal-infos <changed files or package dir>`
- Format: `dart format <changed files>`
- Pure Dart tests (core, domain): `dart test packages/domain/test/<file>_test.dart`
- Flutter tests (data, ui_kit, app): `flutter test packages/data/test/<file>_test.dart` or `flutter test app/test/<file>_test.dart`
- Codegen after changing a `@riverpod`/`@freezed`/drift file: `dart pub global run melos run gen`
- Strings after editing `app_en.arb`: `cd app && flutter gen-l10n`

## Rules that apply to code
- Layers: app -> ui_kit/domain/data/core; data -> domain/core; domain -> core. core/domain never import Flutter or plugins.
- Screens talk to controllers, controllers call use cases, use cases call ports. No business rule in widgets/controllers.
- Money is `Money` (int ngwee), never double. Time only from the `Clock` port; never `DateTime.now()`.
- Every port change must update its drift implementation AND its in-memory fake (`packages/data/lib/src/fakes/`).
- UI uses only ui_kit components/tokens; strings go in `app_en.arb`. Icon-only buttons need a semantic label.
- Files <= 300 lines, functions <= 40 lines. Public APIs in core/domain/ui_kit get dartdoc.
- Lints: very_good_analysis; no `// ignore:` without a reason. Never commit; Conventional Commits are done by the lead.
- Never log raw SMS/notification text (privacy).

## Gotchas (add a line whenever a worker repeats a mistake)
- Constructors use the new `new(...)` primary-constructor syntax seen in the repo; mirror the surrounding file.
- `.g.dart` / `.freezed.dart` files are generated: edit the source and run codegen, never hand-edit them.
