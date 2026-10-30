# Bootstrap: creating everything now

Step-by-step instructions to go from this documentation pack to a working, empty repository ready for task F-01 onward. A human can follow this, or hand it to an agent as task F-01/F-02 (the agent must still follow `AGENTS.md`).

Package versions are deliberately not pinned in this document. When adding a package, check pub.dev for the current stable version, then pin that exact version in `pubspec.yaml`.

## 1. Tools

- Flutter **stable** channel, with a Dart SDK that supports pub workspaces (Dart 3.6 or newer). Check with `flutter --version`.
- Android Studio (or command-line tools) with an Android SDK and one emulator, plus a real Android phone for testing alerts and alarms.
- Git and a GitHub (or GitLab) repository.
- Melos: `dart pub global activate melos` (use a version that supports pub workspaces; read its README).

## 2. Create the repository

```bash
mkdir buckets && cd buckets
git init
# copy this documentation pack in: AGENTS.md, CONTRIBUTING.md, README.md, docs/
```

## 3. Create the packages

```bash
# pure Dart packages (no Flutter)
dart create -t package packages/core
dart create -t package packages/domain

# Flutter packages
flutter create -t package packages/data
flutter create -t package packages/ui_kit

# the app (Android only for V1). Replace the org with your own reverse domain.
flutter create --org zm.example --project-name buckets --platforms android app
```

Then, in each package's `pubspec.yaml`:

- Rename to `buckets_core`, `buckets_domain`, `buckets_data`, `buckets_ui_kit` (the app stays `buckets`).
- Add `resolution: workspace`.
- Add `publish_to: none`.
- Set the same `environment.sdk` constraint as the root.

Path dependencies between members:

| Package | depends on |
| --- | --- |
| buckets_core | – |
| buckets_domain | buckets_core |
| buckets_data | buckets_domain, buckets_core |
| buckets_ui_kit | buckets_core |
| buckets (app) | buckets_core, buckets_domain, buckets_data, buckets_ui_kit |

```yaml
# example in packages/domain/pubspec.yaml
dependencies:
  buckets_core:
    path: ../core
```

## 4. Workspace root

Create `buckets/pubspec.yaml`:

```yaml
name: buckets_workspace
publish_to: none
environment:
  sdk: ^3.6.0   # match your installed Dart SDK

workspace:
  - app
  - packages/core
  - packages/domain
  - packages/data
  - packages/ui_kit

dev_dependencies:
  melos: <pin current version>

melos:
  scripts:
    format: dart format --set-exit-if-changed .
    analyze:
      run: dart analyze --fatal-infos .
    gen:
      run: dart run build_runner build --delete-conflicting-outputs
      exec:
        concurrency: 1
      packageFilters:
        dependsOn: build_runner
    tokens: dart run tool/gen_tokens.dart
    test:dart:
      run: dart test --coverage=coverage
      exec:
        concurrency: 1
      packageFilters:
        flutter: false
        dirExists: test
    test:flutter:
      run: flutter test --coverage
      exec:
        concurrency: 1
      packageFilters:
        flutter: true
        dirExists: test
    test: melos run test:dart && melos run test:flutter
```

The exact Melos config keys depend on the Melos version; follow its documentation if anything here differs. Then:

```bash
dart pub get     # from the root: resolves the whole workspace
melos run analyze
```

## 5. Shared lints

Root `analysis_options.yaml`:

```yaml
include: package:very_good_analysis/analysis_options.yaml
analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
  language:
    strict-casts: true
    strict-inference: true
    strict-raw-types: true
```

Add `very_good_analysis` as a dev dependency in each member and have each member's `analysis_options.yaml` include the root file.

## 6. Dependencies per package (approved list: ARCHITECTURE §9)

```bash
cd packages/core     && dart pub add meta intl && dart pub add --dev test very_good_analysis
cd ../domain         && dart pub add meta collection freezed_annotation && dart pub add --dev test mocktail build_runner freezed very_good_analysis
cd ../data           && dart pub add drift drift_flutter flutter_local_notifications timezone flutter_timezone google_mlkit_text_recognition image_picker local_auth shared_preferences uuid && dart pub add --dev drift_dev build_runner mocktail very_good_analysis
cd ../ui_kit         && flutter pub add --dev very_good_analysis   # golden lib added by ADR in UI-07
cd ../../app         && flutter pub add flutter_riverpod riverpod_annotation go_router freezed_annotation intl && flutter pub add flutter_localizations --sdk=flutter && flutter pub add --dev riverpod_generator build_runner freezed mocktail very_good_analysis && flutter pub add --dev integration_test --sdk=flutter
```

If `drift_flutter` is not suitable for your drift version, use `sqlite3_flutter_libs` + `path_provider` as drift's docs describe, and note it in ADR-0003.

## 7. Folders to create now (empty, with a `.gitkeep` or a placeholder file)

```
packages/core/lib/src/{money,result,time,ids,format,logging}/
packages/domain/lib/src/{accounts,buckets,income,bills,split,ledger,payday,proof,alerts,transactions,receipts,goals,planning,checkin,notifications,settings,shared}/
packages/domain/test/fixtures/{sms/mtn,sms/airtel,sms/bank,receipts}/
packages/data/lib/src/{db,mappers,repositories,platform,system,fakes}/
packages/ui_kit/lib/src/{tokens,theme,foundation,components}/
packages/ui_kit/assets/fonts/          # Geist + Geist Mono .ttf (OFL licence file included)
app/lib/{bootstrap,routing,l10n,features}/
docs/design/screens/                    # export the 23 canvas frames as PNG here
tool/
```

## 8. Everyday commands

```bash
dart pub get              # root, after any pubspec change
melos run gen             # code generation (freezed, drift, riverpod)
melos run tokens          # after docs/design/tokens.json changes
melos run format
melos run analyze
melos run test
cd app && flutter run     # on device/emulator
```

A task is not done until format, analyze and test are all clean (AGENTS.md §10).

## 9. Continuous integration

`.github/workflows/ci.yml` (adapt versions):

```yaml
name: ci
on: [pull_request, push]
jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          channel: stable
          cache: true
      - run: dart pub global activate melos
      - run: dart pub get
      - run: melos run gen
      - run: git diff --exit-code   # generated code and tokens must be committed and current
      - run: melos run format
      - run: melos run analyze
      - run: melos run test
```

## 10. Hand-off to the agent

Order of the first sessions (one task per session):

1. F-01 Scaffold (sections 2–7 above)
2. F-02 Lints & CI (sections 5, 9)
3. F-03 ADRs 0001–0004
4. F-04 core primitives
5. F-05 token generator
6. D-01 … onward, following `docs/PLAN.md`

Start each session with the prompt in `CONTRIBUTING.md` §5.

Before D-06a/b, put the redacted SMS fixtures in place (`docs/DOMAIN.md` §17). Before DA-08, answer Open question 2 in `docs/PROGRESS.md` (the Android package names to listen to).
