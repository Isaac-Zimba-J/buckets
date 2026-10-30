# Architecture

Buckets is an offline-first Flutter app (Android first) built with Clean Architecture: a pure Dart core of business rules, wrapped by data adapters, driven by thin state controllers, rendered by a reusable component kit.

## 1. Layers at a glance

```
┌──────────────────────────────────────────────────────────────┐
│ app  (Flutter)                                               │
│   features/<feature>/presentation   screens, controllers     │
│   routing, DI composition root, l10n, android/ native code   │
└───────────────┬──────────────────────────┬───────────────────┘
                │ uses                     │ uses
┌───────────────▼─────────┐      ┌─────────▼──────────────────┐
│ ui_kit (Flutter)        │      │ data (Flutter allowed)     │
│ tokens, theme,          │      │ drift DB, DAOs, mappers,   │
│ components (no domain)  │      │ repository + port impls,   │
└───────────────┬─────────┘      │ platform adapters, fakes   │
                │                └─────────┬──────────────────┘
                │                          │ implements
                │                ┌─────────▼──────────────────┐
                │                │ domain (pure Dart)         │
                │                │ entities, value objects,   │
                │                │ policies/services,         │
                │                │ repository + port          │
                │                │ interfaces, use cases      │
                │                └─────────┬──────────────────┘
                │                          │
┌───────────────▼──────────────────────────▼───────────────────┐
│ core (pure Dart): Money, BasisPoints, Result, Failure,       │
│ Clock, IdGenerator, redact(), MoneyFormatter                 │
└──────────────────────────────────────────────────────────────┘
```

**Dependency rule:** arrows only point down. Nothing in `domain` knows that Flutter, SQLite or Android exist. The compiler enforces this because `core` and `domain` are separate pure-Dart packages whose `pubspec.yaml` does not list Flutter.

## 2. Repository layout

The repo is a Dart **pub workspace** managed with **Melos**.

```
buckets/
├── AGENTS.md  CONTRIBUTING.md  README.md
├── pubspec.yaml                  # workspace root (+ melos config)
├── analysis_options.yaml         # shared lints
├── tool/
│   └── gen_tokens.dart           # docs/design/tokens.json → ui_kit Dart tokens
├── docs/
│   ├── ARCHITECTURE.md  DOMAIN.md  PLAN.md  PROGRESS.md
│   ├── SCREENS.md  COMPONENTS.md  BOOTSTRAP.md  API_PLAN.md
│   ├── adr/                      # decision records
│   └── design/                   # tokens.json + design system docs (+ screen PNGs)
├── packages/
│   ├── core/                     # pure Dart
│   │   └── lib/src/{money,result,time,ids,format,logging}/
│   ├── domain/                   # pure Dart
│   │   ├── lib/src/
│   │   │   ├── accounts/   buckets/   income/   bills/   split/
│   │   │   ├── ledger/     payday/    proof/    alerts/  transactions/
│   │   │   ├── receipts/   goals/     planning/ checkin/ notifications/
│   │   │   ├── settings/   shared/
│   │   │   └── each feature folder contains:
│   │   │         entities/  value_objects/  policies/  ports/  use_cases/
│   │   └── test/ (mirrors lib, plus fixtures/)
│   ├── data/                     # Flutter package
│   │   ├── lib/src/
│   │   │   ├── db/               # drift database, tables, DAOs, migrations
│   │   │   ├── mappers/          # row ⇄ entity
│   │   │   ├── repositories/     # Drift*Repository implements domain ports
│   │   │   ├── platform/         # notifications, alert listener, OCR, image, lock
│   │   │   ├── system/           # SystemClock, UuidGenerator, settings store
│   │   │   └── fakes/            # InMemory* / Fake* for tests and dev
│   │   └── test/                 # contract tests, migration tests
│   └── ui_kit/                   # Flutter package, no domain imports
│       ├── lib/src/
│       │   ├── tokens/           # generated *.g.dart from tokens.json
│       │   ├── theme/            # ThemeData + ThemeExtensions
│       │   ├── foundation/       # MoneyText, spacing helpers, icons
│       │   └── components/       # Bk* widgets (see COMPONENTS.md)
│       ├── gallery/              # component gallery app (widgetbook or plain)
│       └── test/                 # widget + golden tests
└── app/                          # the Flutter application
    ├── lib/
    │   ├── main.dart
    │   ├── bootstrap/            # composition root: providers, overrides
    │   ├── routing/              # go_router config, guards
    │   ├── l10n/                 # app_en.arb
    │   └── features/<feature>/presentation/
    │       ├── controllers/      # Riverpod Notifiers + state classes
    │       ├── screens/          # one file per screen in SCREENS.md
    │       └── widgets/          # feature-only composites of ui_kit parts
    ├── android/                  # Kotlin: PaymentAlertListenerService
    ├── test/                     # controller + widget tests
    └── integration_test/         # end-to-end flows
```

## 3. The layers in detail

### core (pure Dart)

Shared primitives with no business meaning:

- `Money` – immutable, `int ngwee`, arithmetic, comparison, `Money.kwacha(1540)`, never `double`.
- `BasisPoints` – `int`, 0…10000, `applyTo(Money)` with floor rounding.
- `Result<T>` – sealed `Ok<T>` / `Err<T>(Failure)`. Use cases return `Result`, never throw for expected failures.
- `Failure` – sealed hierarchy: `ValidationFailure`, `NotFoundFailure`, `ConflictFailure`, `StorageFailure`, `PlatformFailure`, `PermissionFailure`, each with a machine `code` and safe `message`.
- `Clock` and `IdGenerator` interfaces (implemented in `data/system`).
- `MoneyFormatter`, `DateFormatter` following `docs/design/WRITING.md`.
- `redact(String)` for logs.

### domain (pure Dart)

Everything that decides anything about money, time or rules lives here.

- **Entities** – objects with identity: `Account`, `Bucket`, `IncomeSource`, `SplitProfile`, `Bill`, `LedgerEntry`, `Payday`, `Transfer`, `PaymentAlert`, `Transaction`, `MerchantRule`, `ReceiptDraft`, `Goal`, `PlannedPurchase`, `Wish`, `CheckIn`, `Settings`.
- **Value objects** – `Allocation`, `Category`, `MatchKey`, `ProofResult`, `CheckOutcome`, `DateWindow`, `QuietHours`.
- **Policies / services** – pure functions or stateless classes: `SplitCalculator`, `BalanceCalculator`, `PaydayPlanner`, `ProofVerifier`, `SmsParser` (with provider templates), `ReceiptTextParser`, `Categorizer`, `OverspendPolicy`, `GoalProjector`, `CoolingOffPolicy`, `CashReconciler`, `NotificationPolicy`.
- **Ports** – interfaces the domain needs from the outside world:
  - Repositories: `AccountRepository`, `BucketRepository`, `IncomeRepository`, `BillRepository`, `SplitProfileRepository`, `LedgerRepository`, `PaydayRepository`, `AlertRepository`, `TransactionRepository`, `MerchantRuleRepository`, `GoalRepository`, `PlanningRepository`, `CheckInRepository`, `SettingsRepository`.
  - Platform: `NotificationScheduler`, `PaymentAlertSource`, `TextRecognizer`, `ImageCapture`, `AppLock`, `PermissionGateway`.
- **Use cases** – one class per user intention, a single `call()` returning `Future<Result<T>>`. Examples: `CompleteSetup`, `SaveSplitProfile`, `StartPayday`, `ProveTransfer`, `RecordPartialTransfer`, `SnoozePaydayAlarm`, `IngestPaymentAlerts`, `CategorizeAlert`, `LogCashPayment`, `ScanReceipt`, `SaveReceipt`, `CoverOverspend`, `SplitSideHustleIncome`, `CountCash`, `AddWish`, `ResolveWish`, `ScheduleNotifications`. The full list per screen is in `docs/SCREENS.md`.

Use cases orchestrate; policies decide; ports fetch and store. A use case never contains arithmetic on money; it calls a policy.

### data (Flutter package)

Adapters that make ports real.

- **Database:** drift on SQLite, one database file, schema version tracked, every migration has a test. Tables mirror aggregates; the ledger table is append-only (no UPDATE/DELETE statements exist in its DAO).
- **Mappers:** pure functions row ⇄ entity. No logic beyond conversion.
- **Repositories:** `Drift*Repository` implementing domain ports, returning `Result`, translating exceptions to `StorageFailure`.
- **Platform adapters:**
  - `LocalNotificationScheduler` – flutter_local_notifications + timezone; channels per notification type from `docs/design/PATTERNS.md`.
  - `AndroidPaymentAlertSource` – MethodChannel/EventChannel to the Kotlin listener (see §6).
  - `MlKitTextRecognizer` – google_mlkit_text_recognition, on-device only.
  - `ImagePickerCapture` – image_picker for camera/gallery.
  - `LocalAuthAppLock` – local_auth.
- **System:** `SystemClock`, `UuidGenerator`, `SharedPreferencesSettingsStore` (for tiny flags only; real data lives in drift).
- **Fakes:** an in-memory implementation of every port. Used by domain-adjacent tests, controller tests and a "demo mode" build.

### ui_kit (Flutter package)

The component system: tokens generated from `docs/design/tokens.json`, a `ThemeData` with `ThemeExtension`s, and `Bk*` components. It knows nothing about buckets as entities; it knows how to draw "a dot of this colour next to this label". Full spec in `docs/COMPONENTS.md`.

### app (Flutter application)

- **Composition root** (`bootstrap/`): creates the database, wires every port to its implementation in Riverpod providers, and exposes overrides for tests and demo mode.
- **Controllers:** one Riverpod `Notifier`/`AsyncNotifier` per screen. They hold a screen state class (`freezed`, with explicit `loading / empty / ready / error` variants where relevant), call use cases, and expose intent methods (`onProvePressed()`). No money logic.
- **Screens:** stateless widgets that read a controller and compose `ui_kit` components. One file per screen ID in `docs/SCREENS.md`.
- **Routing:** go_router with guards: no setup → `/welcome`; an open payday with pending transfers → Home shows the alarm banner and the payday route is reachable from notifications.

## 4. Data flow example: proving a transfer

```
ProofScreen ──onPaste(text)──▶ ProofController
   ProofController ──▶ ProveTransfer(paydayId, transferId, text)
      ProveTransfer:
        1. PaydayRepository.get(paydayId)            → Payday + Transfer
        2. AccountRepository.get(transfer.accountId) → match keys
        3. SmsParser.parse(text)                     → ParsedMessage
        4. LedgerRepository.isReferenceUsed(ref)     → bool
        5. ProofVerifier.verify(...)                 → ProofResult (4 checks)
        6. if passed: PaydayRepository.markProven(...) + LedgerRepository.append(transferProven entry)
        7. NotificationPolicy → NotificationScheduler.cancel/reschedule alarm
      returns Result<ProofResult>
   ProofController maps ProofResult → ProofState.passed / .failed(checks)
ProofScreen renders BkCheckRow × 4, primary button enabled/disabled
```

## 5. State management

- Riverpod with code generation (`riverpod_annotation` + `riverpod_generator`).
- Provider kinds: `@riverpod` functions for ports/use cases (keepAlive for DB and ports), `@riverpod class XController extends _$XController` for screens.
- Screen state classes are `freezed` sealed unions. Never expose entities directly to widgets; map to small view models (`BucketTileVm`, `TransferRowVm`) in the controller.
- Streams: repositories expose `watch*()` streams (drift watch queries) so Home updates live after a payment is logged.

## 6. Android payment alert listener (native)

Reading SMS directly is restricted on Google Play, so V1 reads **notifications** posted by the MTN MoMo and Airtel Money apps / SMS app using `NotificationListenerService`.

1. Kotlin `PaymentAlertListenerService` (in `app/android`) filters notifications by package name allow-list and keyword hints. It never inspects other apps.
2. Matching notifications are written to a small native queue (Room or plain SQLite file owned by the service) with timestamp, source package and text. The service then posts our own local notification ("K 185 to [MERCHANT] – tap to file") built from a minimal parse, or a generic "New payment – tap to file" if parsing natively is not possible.
3. When the app starts or resumes, `AndroidPaymentAlertSource.drain()` pulls the queue over a MethodChannel; `IngestPaymentAlerts` parses with the domain `SmsParser`, de-duplicates by provider reference, stores `PaymentAlert`s and runs merchant rules.
4. Fallback paths (always available): paste SMS text, and Android share-to-app (V1.1).

This keeps all real parsing logic in Dart `domain` and testable, with no background Dart isolate in V1. Review Google Play's current policy on notification access before release (task R-01).

## 7. Notifications and the payday alarm

- `NotificationPolicy` (domain) decides **what** to schedule and when: payday alarm and its 30-minute repeats, quiet hours, ≤ 1 non-alarm per hour, bill reminders, Sunday check-in, cooling-off end, bucket-low.
- `LocalNotificationScheduler` (data) does the **how**: exact alarms where allowed, high-importance channel for the payday alarm, deep-link payloads that go_router understands.
- Android 13+ needs the notification permission; exact alarms and full-screen intents have extra restrictions on newer Android versions. The design must degrade gracefully to repeating high-priority notifications. Verify against current Android and Play documentation in R-01.

## 8. Errors, logging and security

- Expected problems are `Result.err(Failure)`; exceptions are only for programmer errors.
- Controllers map failures to user copy from `docs/design/WRITING.md` (what happened + what to do).
- Logging via a tiny `Logger` in `core` that is silent in release and always passes text through `redact()`.
- Optional app lock with `local_auth` (PIN/biometric) on launch and resume after 1 minute.
- The database lives in app-private storage. Backups (V1.1) are an encrypted export file the user saves themselves.

## 9. Approved dependencies

Pin exact versions after checking pub.dev. Anything not here needs an ADR.

| Package | Where | Why |
| --- | --- | --- |
| `meta`, `collection`, `equatable` (or `freezed`) | core, domain | annotations, collections, value equality |
| `freezed`, `freezed_annotation`, `json_annotation`, `json_serializable`, `build_runner` | domain, data, app | immutable models, unions |
| `test`, `mocktail` | core, domain | tests |
| `drift`, `drift_flutter` (or `sqlite3_flutter_libs` + `path_provider`), `drift_dev` | data | SQLite persistence |
| `flutter_local_notifications`, `timezone`, `flutter_timezone` | data | local notifications |
| `google_mlkit_text_recognition` | data | on-device OCR |
| `image_picker` | data | camera / gallery |
| `local_auth` | data | app lock |
| `shared_preferences` | data | tiny flags only |
| `uuid` | data | IDs |
| `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator` | app | state + DI |
| `go_router` | app | navigation + deep links |
| `intl`, `flutter_localizations` | core (intl only), app | formatting, l10n |
| `very_good_analysis` | all | lints |
| `widgetbook` (optional) | ui_kit/gallery | component gallery |
| `alchemist` or `golden_toolkit` successor (choose one via ADR) | ui_kit | golden tests |
| `melos` | dev | workspace scripts |

## 10. Testing strategy

| Layer | Kind | Tooling | Gate |
| --- | --- | --- | --- |
| core, domain | unit, property-style edge cases | `test` | ≥ 95% lines |
| data | contract tests shared by fake + drift impl, migration tests | `flutter_test`, drift test utils | all ports |
| app controllers | state tests with fakes | `flutter_test`, Riverpod `ProviderContainer` | every state |
| ui_kit | widget + golden (light/dark) | `flutter_test`, golden lib | every component |
| screens | widget tests per state | `flutter_test` | every state in SCREENS.md |
| flows | end-to-end on emulator with fakes for platform ports | `integration_test` | AP-04, S-* |

CI (GitHub Actions) runs format, analyze, codegen check, all tests and coverage on every PR.

## 11. Conventions

- Feature folder names are the same in `domain/lib/src/<feature>` and `app/lib/features/<feature>`.
- A use case file contains exactly one public class.
- Database table names are plural snake_case (`ledger_entries`); entities are singular PascalCase.
- Routes are kebab-case and declared once in `app/lib/routing/routes.dart`.
- Deep-link payloads: `buckets://payday/<id>`, `buckets://alert/<id>`, `buckets://checkin`, `buckets://plan/wish/<id>`.
