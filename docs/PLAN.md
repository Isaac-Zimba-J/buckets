# Plan

The full roadmap from an empty repository to later versions. Every task has an ID used in branches, commits, PRs and `docs/PROGRESS.md`. Do tasks in order within a phase; "Needs" lists hard dependencies.

**The rule that shapes this plan:** all business logic, data and state for version 1 is built and tested before any screen or UI component. Phases 1–3 end with the **Logic complete gate**. Only after a human opens that gate do phases 4–5 (UI kit, screens) begin.

---

## Version 1 – Personal MVP (Android, offline, single user)

Goal: you can use the app for real on your own phone for two paydays: setup, payday alarm and proof, logging every payment, overspend handling, goals, planned buys and the Sunday check-in, matching the 23 screens of the design canvas.

### Phase 0 – Foundations

| ID | Task | Needs | Acceptance criteria |
| --- | --- | --- | --- |
| F-01 | Scaffold workspace | – | Pub workspace with `packages/core`, `packages/domain`, `packages/data`, `packages/ui_kit`, `app`; Melos scripts `analyze`, `format`, `test`, `gen`; `core`/`domain` have no Flutter dependency; `flutter run` shows a blank app. |
| F-02 | Lints, format, CI | F-01 | `very_good_analysis` everywhere; GitHub Actions runs format check, analyze, codegen-is-clean check, tests with coverage on PRs; badge in README. |
| F-03 | ADR set | F-01 | ADR-0001 architecture & layers, ADR-0002 Riverpod + go_router, ADR-0003 drift + append-only ledger, ADR-0004 no network in V1 – all `Accepted`. |
| F-04 | core primitives | F-01 | `Money` (int ngwee, +, −, compare, `kwacha()` ctor, no double), `BasisPoints`, `Result`/`Failure`, `Clock`, `IdGenerator`, `MoneyFormatter` & `DateFormatter` per WRITING.md, `redact()`. 100% test coverage. |
| F-05 | Token generator | F-01 | `dart run tool/gen_tokens.dart` reads `docs/design/tokens.json` and writes `ui_kit/lib/src/tokens/*.g.dart` (colors light/dark, type styles, spacing, radius, shadows). Generated files committed; CI fails if stale. **Tokens only, no widgets.** |

### Phase 1 – Domain (pure Dart, test-first)

| ID | Task | Needs | Acceptance criteria |
| --- | --- | --- | --- |
| D-01 | Entities & value objects | F-04 | All entities and value objects in DOMAIN.md §2–§16 as immutable classes with validation factories returning `Result`. R-ACC-*, R-BUCKET-1/5 tested. |
| D-02 | Ports | D-01 | Every repository and platform port interface from ARCHITECTURE §3, with dartdoc. No implementations here. |
| D-03 | SplitCalculator | D-01 | R-SPLIT-1…6 and R-BILL-1/3. Property tests: allocations always sum to amount split for random inputs. Canvas example 12,000/4,300 → 3,080/770/770/770/1,540/770. |
| D-04 | Ledger & BalanceCalculator | D-01 | R-LEDGER-1…5; reversal behaviour; pay-cycle boundaries (R-TIME-3); "K x a day". |
| D-05 | PaydayPlanner & payday lifecycle | D-03, D-04 | R-PAY-1…6; transfers only for buckets in other accounts; snooze rules incl. 21:00 and 18:00 edges; side-hustle holding. |
| D-06 | SmsParser framework | D-01 | R-PARSE-2…5 with a template engine and fixture loader. Provider templates are added in D-06a/b when fixtures exist. |
| D-06a | MTN MoMo templates | D-06, fixtures | Every MTN fixture parses to its `.expected.json`. |
| D-06b | Airtel Money templates | D-06, fixtures | Same for Airtel. |
| D-07 | ProofVerifier | D-05, D-06 | R-PROOF-1…5 with all four checks, `unknown` handling, partial/owed, self-reported, streak. |
| D-08 | Spending & Categorizer | D-04 | R-SPEND-1…5; MerchantRule normalization; fees as separate transactions; withdrawals move to Cash in hand. |
| D-09 | ReceiptTextParser | D-01 | R-RECEIPT-1/2 against OCR text fixtures (`fixtures/receipts/*.txt`); confidence flags. |
| D-10 | OverspendPolicy | D-04 | R-OVER-1…5, including protected buckets never offered and Guilt-free special case. |
| D-11 | GoalProjector | D-03, D-04 | R-GOAL-1…4. |
| D-12 | Planning & CoolingOffPolicy | D-04 | R-PLAN-1…3. |
| D-13 | CashReconciler & check-in | D-08 | R-CASH-1…3, R-CHECKIN-1. |
| D-14 | NotificationPolicy | D-05, D-12, D-13 | R-NOTIF-1…4 and the schedule table; deterministic output given a `Clock`. |
| D-15 | Use cases | D-02…D-14 | Every use case listed in `docs/SCREENS.md`, each with tests using in-memory fakes defined in the test folder. |

### Phase 2 – Data

| ID | Task | Needs | Acceptance criteria |
| --- | --- | --- | --- |
| DA-01 | Database schema v1 | D-02 | drift tables for all aggregates; ledger table with no update/delete path; indices on (bucket_id, occurred_at), (reference). |
| DA-02 | Mappers & DAOs | DA-01 | Round-trip tests entity → row → entity for every aggregate. |
| DA-03 | Repository impls + contract tests | DA-02 | One shared contract suite per port; `InMemory*` and `Drift*` both pass it; `watch*` streams emit on change. |
| DA-04 | Fakes package surface | DA-03 | All fakes exported from `data/fakes.dart` for app tests and demo mode. |
| DA-05 | First-run seed | DA-03 | Default buckets (R-BUCKET-1), categories, Cash in hand account, default settings; idempotent. |
| DA-06 | System adapters | F-04 | `SystemClock` (Africa/Lusaka default), `UuidGenerator`, settings store. |
| DA-07 | Local notifications adapter | D-14 | Channels per notification ID; schedules what the policy outputs; deep-link payloads; permission request flow; tested with a fake plugin wrapper. |
| DA-08 | Android alert listener | D-06 | Kotlin `NotificationListenerService` with package allow-list, native queue, MethodChannel `drain()`; `AndroidPaymentAlertSource` implements the port; manual test checklist in PR. |
| DA-09 | OCR & image adapters | D-09 | `MlKitTextRecognizer`, `ImagePickerCapture`; return plain text to domain. |
| DA-10 | App lock adapter | – | `LocalAuthAppLock` behind `AppLock` port. |
| DA-11 | Migration test harness | DA-01 | Schema dump committed; migration test pattern ready for v2. |

### Phase 3 – Application (state, no screens)

| ID | Task | Needs | Acceptance criteria |
| --- | --- | --- | --- |
| AP-01 | Composition root | DA-* | Riverpod providers for every port and use case; overrides for tests and demo mode (fakes + seed data matching the canvas). |
| AP-02 | Screen controllers | AP-01, D-15 | One controller + freezed state per screen in `docs/SCREENS.md`, covering every listed state; view models only, no entities leak. Tests for every state transition. |
| AP-03 | Routing & guards | AP-02 | go_router routes and deep links from SCREENS.md; setup guard; notification payload → route. Tested with a router test (no real screens: placeholder widgets). |
| AP-04 | Flow tests without UI | AP-02 | Controller-level scripted flows: (1) setup → first payday → prove 3, fail 1 then partial → complete; (2) alert ingested → sorted with rule → next alert auto-filled; (3) Living overspent → cover from Guilt-free; (4) receipt split across buckets; (5) side hustle hold until month end; (6) Sunday check-in with cash gap. |

### 🚧 Logic complete gate

Opened by a human in `docs/PROGRESS.md` when F-*, D-*, DA-*, AP-* are ✅, coverage targets are met, and open questions are resolved. No UI-* or S-* work before this.

### Phase 4 – UI kit (components)

| ID | Task | Needs | Acceptance criteria |
| --- | --- | --- | --- |
| UI-01 | Theme | Gate, F-05 | `BucketsTheme.light/dark`, ThemeExtensions for colors, type, spacing, radius, shadows; `context.bk` accessor; golden of a token sheet. |
| UI-02 | Foundation | UI-01 | `BkMoneyText`, `BkIcon` set (outline, 1.75 stroke), `BkGap`, semantics helpers. |
| UI-03 | Actions & inputs | UI-02 | Buttons (primary, secondary, text, destructive, icon), FAB, chip, chip group, segmented control, text field, amount field, toggle row, checkbox row, radio card, row picker. |
| UI-04 | Containers & feedback | UI-02 | Card, hero card, list group, list row, banner, toast, badge, bottom sheet, skeleton, empty state. |
| UI-05 | Money widgets | UI-02 | Bucket dot, split bar, bucket tile, progress bar, progress ring, transfer row, proof check row, step list. |
| UI-06 | Navigation | UI-02 | Top bar, flow header (step + progress), tab bar. |
| UI-07 | Gallery & goldens | UI-03…06 | Gallery app showing every component in every state, light and dark; golden tests for all. |

### Phase 5 – Screens (layer by layer, in flow order)

Each S task wires existing controllers to `ui_kit` components. Screen numbers match the design canvas and `docs/SCREENS.md`.

| ID | Screens | Needs | Acceptance criteria |
| --- | --- | --- | --- |
| S-01 | 01–06 Setup | UI-07, AP-03 | Full first-run flow works on device; split error state; accounts and permissions; lands on 07. |
| S-02 | 07–08 Home (empty, normal) | S-01 | Live balances from streams; sort card; FAB; tab bar. |
| S-03 | 18–21 Logging | S-02 | Sort sheet from alert, log cash, scan (camera/gallery), receipt review with warning state; balances update. |
| S-04 | 12–16 Payday loop | S-03 | Real notifications deep-link correctly; payday checklist; proof passed and failed; partial; complete screen; Home unlock note. |
| S-05 | 17 Side hustle | S-04 | Split now and hold-until-month-end paths. |
| S-06 | 09 Overspent | S-02 | Options ordered per R-OVER-2; cover writes a move. |
| S-07 | 10–11 Goals & Plan | S-02 | Goal ETAs, wishes with timers, planned buys check-off. |
| S-08 | 22 Check-in | S-03 | Three steps, cash gap handling. |
| S-09 | 23 States everywhere | S-01…S-08 | Every screen shows its empty/loading/error states; accessibility pass (TalkBack labels, 44 px targets, text scale 1.3). |
| S-10 | Me tab | S-01 | Income list, buckets & accounts, settings, app lock toggle (simple list screens built from ui_kit). |

### Phase 6 – Release V1

| ID | Task | Needs | Acceptance criteria |
| --- | --- | --- | --- |
| R-01 | Android permissions & policy review | S-04 | Notification permission, notification-access, exact alarm / full-screen intent behaviour checked against current Android & Play docs; graceful fallbacks; documented in an ADR. |
| R-02 | Low-end device pass | S-09 | Cold start < 2 s and smooth scrolling on a 2 GB RAM Android 10 device; APK size noted. |
| R-03 | Dogfood build | R-01 | Signed release APK installed on the owner's phone; 2 real paydays logged; bug list triaged. |

---

## Version 1.1 – Polish from real use

- Share-to-app: share an SMS into Buckets for proof or logging.
- Screenshot proof via OCR (R-PROOF-6).
- Starting balances and `WithdrawFromProtected` (deliberate flow with a 24-hour wait).
- Encrypted backup export / import file (user-held; no server).
- Dark theme in the app (tokens already exist).
- Bills calendar view and "mark bill paid" from a bill alert.
- Fixture expansion for more message types; bank SMS templates.

## Version 2 – Deeper money habits

- Optional separate wallet for Guilt-free (adds a payday transfer).
- Chilimba (rotating savings group) tracker: contributions, payout month, reminders.
- Debt tracker: loans, repayments as fixed bills, payoff projection.
- Net worth: assets (accounts, investments, land) minus debts, monthly snapshot.
- Monthly report: savings rate, spend by category, untracked cash trend.
- Family support bucket with planned recurring support.
- iOS build (manual entry, paste and share only; no alert reading).
- More languages for UI (Bemba, Nyanja) if contributors provide translations.

## Version 3 – Optional account & cloud (requires `docs/API_PLAN.md`)

- Optional account with phone-number sign-in.
- End-to-end-encrypted sync and backup across devices.
- Opt-in, anonymous insights programme with explicit consent screens.
- On-device models: smarter categorization, split suggestions based on your own history.

## Version 4 – Learning from patterns (consented, aggregated)

- Models trained on consented, anonymized aggregates (see API_PLAN.md §6): benchmark "people like you save x%", overspend early warnings, goal feasibility.
- Partner integrations only where official APIs exist and terms allow.
- Shared budgets for couples/households.

Each version starts with a planning pass that adds its own phase/task tables here in the same format, following the same logic-before-UI rule.
