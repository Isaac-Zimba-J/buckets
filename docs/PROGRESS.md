# Progress

Updated by whoever finishes work (agent or human) as the last step of every task. Agents follow AGENTS.md §11: change only your task's row, the "Last updated" line, and Open questions / Blockers.

**Last updated:** 13 Nov 2026 – S-13 in review.

Status: ⬜ todo · 🟡 in progress · 🔵 in review · ✅ done · ⛔ blocked

## Summary

| Phase | Done | Total |
| --- | --- | --- |
| Phase 0 – Foundations | 5 | 5 |
| Phase 1 – Domain | 22 | 33 |
| Phase 2 – Data | 15 | 18 |
| Phase 3 – Application | 7 | 10 |
| Phase 4 – UI kit | 8 | 9 |
| Phase 5 – Screens | 13 | 17 |
| Phase 6 – Release V1 | 0 | 3 |
| Docs | 1 | 3 |


## Docs

| ID | Task | Status | Owner | Date | PR | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| DOC-01 | Add profile, settings and help scope | ✅ done | agent | 10 Nov 2026 | [#61](https://github.com/Isaac-Zimba-J/buckets/pull/61) [#62](https://github.com/Isaac-Zimba-J/buckets/pull/62) | Screens 01b, 24–32 into DOMAIN, SCREENS, PLAN, ARCHITECTURE, COMPONENTS; follow-up rows D-01b, D-02b, D-16b, D-15b, DA-01b, DA-03b, AP-02b, AP-03b, UI-04b, S-01b, S-10b. |
| DOC-02 | Move, starting balance & remove bucket scope | 🔵 in review | agent | 11 Nov 2026 | – | Owner feedback from phone run. R-BUCKET-2 amended, R-BUCKET-6, R-LEDGER-6, R-MOVE-1/2 added; screen 09 + Home 07 updated; D-17, AP-04b, S-12 added; starting balances + protected moves pulled from V1.1 into V1. |
| DOC-03 | Bills tracking and transaction fees | 🔵 in review | agent | 12 Nov 2026 | – | Bills bucket, bill occurrences, R-BILL-5…10, R-FEE-1…7, screens 33–37; follow-ups below. |

## Phase 0 – Foundations

| ID | Task | Status | Owner | Date | PR | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| F-01 | Scaffold workspace | ✅ done | agent | 30 Oct 2026 | [#1](https://github.com/Isaac-Zimba-J/buckets/pull/1) | Pub workspace + Melos 8.10.0; `test` pinned 1.31.0 (flutter_test pins test_api). Plugin deps deferred to the tasks that use them. Debug APK builds; not yet run on a device. |
| F-02 | Lints, format, CI | ✅ done | agent | 30 Oct 2026 | [#2](https://github.com/Isaac-Zimba-J/buckets/pull/2) | very_good_analysis 10.3.0 (11.x needs Dart 3.13), one root analysis_options.yaml. CI pinned to Flutter 3.44.9. Token staleness check joins CI in F-05. |
| F-03 | ADR set | ✅ done | agent | 30 Oct 2026 | [#3](https://github.com/Isaac-Zimba-J/buckets/pull/3) | ADR-0001…0004 Accepted, written from ARCHITECTURE/AGENTS. |
| F-04 | core primitives | ✅ done | agent | 30 Oct 2026 | [#4](https://github.com/Isaac-Zimba-J/buckets/pull/4) | 100% line coverage (86/86). `redact()` masks letters → x, digits → #. Logger deferred to first use. |
| F-05 | Token generator | ✅ done | agent | 30 Oct 2026 | [#5](https://github.com/Isaac-Zimba-J/buckets/pull/5) | 5 generated files, tokens exported from ui_kit, CI fails on stale tokens (verified). No widgets. |

## Phase 1 – Domain

| ID | Task | Status | Owner | Date | PR | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| D-01 | Entities & value objects | ✅ done | agent | 1 Nov 2026 | [#7](https://github.com/Isaac-Zimba-J/buckets/pull/7) | 80 tests, 99.8% line coverage. equatable 3.0.0. Assumptions in Open questions 6–9. Needs follow-up for DOC-01 → D-01b. Needs follow-up for bills/fees → D-01c. |
| D-02 | Ports | ✅ done | agent | 1 Nov 2026 | [#8](https://github.com/Isaac-Zimba-J/buckets/pull/8) | 14 repository + 6 platform ports. Proof-reference check on PaydayRepository (DOMAIN R-LEDGER-4 over ARCHITECTURE §4). Needs follow-up for DOC-01 → D-02b. Needs follow-up for bills/fees → D-02d. |
| D-03 | SplitCalculator | ✅ done | agent | 1 Nov 2026 | [#9](https://github.com/Isaac-Zimba-J/buckets/pull/9) | Split, defaults, bill reservations. 2,000-run property test. New setting goalShareFallback (R-SPLIT-4a). Needs follow-up for bills/fees → D-03b. |
| D-04 | Ledger & BalanceCalculator | ✅ done | agent | 1 Nov 2026 | [#10](https://github.com/Isaac-Zimba-J/buckets/pull/10) | Balances, cycle spend, per-day, moves, reversals, pay cycles (LocalDate). Stacked on D-03. |
| D-05 | PaydayPlanner & payday lifecycle | ✅ done | agent | 1 Nov 2026 | [#11](https://github.com/Isaac-Zimba-J/buckets/pull/11) | Start, transfers, completion, snooze edges, unlock, hold release. Bill money reserved in paying bucket (R-BILL-2a). Stacked on D-04. Needs follow-up for bills/fees → D-05b. |
| D-06 | SmsParser framework | ✅ done | agent | 1 Nov 2026 | [#12](https://github.com/Isaac-Zimba-J/buckets/pull/12) | Template engine, amount parsing, duplicates, income suggestion, fixture loader. Provider suites skipped: needs fixtures. |
| D-06a | MTN MoMo templates | ⛔ blocked | – | – | – | Blocked until fixtures exist (DOMAIN §17) |
| D-06b | Airtel Money templates | ⛔ blocked | – | – | – | Blocked until fixtures exist (DOMAIN §17) |
| D-07 | ProofVerifier | ✅ done | agent | 1 Nov 2026 | [#13](https://github.com/Isaac-Zimba-J/buckets/pull/13) | Four checks, partial/owed, self-reported, streak. Transfer now keeps a list of proof refs. |
| D-08 | Spending & Categorizer | ✅ done | agent | 1 Nov 2026 | [#14](https://github.com/Isaac-Zimba-J/buckets/pull/14) | Spend entries per bucket, fees, withdrawals, merchant rules, Guilt-free quiet rule. Needs follow-up for bills/fees → D-08b. |
| D-09 | ReceiptTextParser | ✅ done | agent | 1 Nov 2026 | [#15](https://github.com/Isaac-Zimba-J/buckets/pull/15) | Review rules done (R-RECEIPT-2). Parser is a port: blocked on receipt fixtures (Open question 10). |
| D-10 | OverspendPolicy | ✅ done | agent | 1 Nov 2026 | [#16](https://github.com/Isaac-Zimba-J/buckets/pull/16) | Cover options/order, moves, carry-over via tagged adjustments, 2-of-3 tip, Guilt-free case. |
| D-11 | GoalProjector | ✅ done | agent | 1 Nov 2026 | [#17](https://github.com/Isaac-Zimba-J/buckets/pull/17) | Contribution, ETA, emergency target K 22,140, celebrate once. |
| D-12 | Planning & CoolingOffPolicy | ✅ done | agent | 1 Nov 2026 | [#18](https://github.com/Isaac-Zimba-J/buckets/pull/18) | Wish suggestion, cooling-off, approve after timer, planned done + difference. |
| D-13 | CashReconciler & check-in | ✅ done | agent | 1 Nov 2026 | [#19](https://github.com/Isaac-Zimba-J/buckets/pull/19) | Expected cash, Untracked/received adjustments, steps, gap prompt, week summary. |
| D-14 | NotificationPolicy | ✅ done | agent | 1 Nov 2026 | [#20](https://github.com/Isaac-Zimba-J/buckets/pull/20) | Full schedule table, quiet hours, 1/hour spacing with alert merging, deep links. Open question 11. |
| D-15 | Use cases | ✅ done | agent | 1 Nov 2026 | [#21](https://github.com/Isaac-Zimba-J/buckets/pull/21) | a #21, b #22, c #23 merged; d (home, goals, plan, check-in, notifications) in review. ~55 use cases with in-memory fakes. Needs follow-up for DOC-01 → D-15b. |
| D-16 | Profile, security & settings rules | ✅ done | agent | 10 Nov 2026 | [#64](https://github.com/Isaac-Zimba-J/buckets/pull/64) | `CategoryRules` (R-CAT-1 archive/delete guards, R-CAT-2 uniqueness); `ProblemReport`/`AppInfo`/`ProblemReportBuilder` (R-SUPPORT-1/2, app-info whitelist); `DataPrivacyRules.confirmsDelete` (R-PRIV-4). R-PROFILE/R-SEC-4 live on the D-01b entities; R-SEC-2 clock wiring is D-16b. |
| D-01b | Profile & help entities (DOC-01 follow-up) | ✅ done | agent | 10 Nov 2026 | [#63](https://github.com/Isaac-Zimba-J/buckets/pull/63) | `Profile` (+`Greeting`), `HelpArticle`, `LockTimeout`; `Category` rename/archive + 24-char limit; `Settings` gains lockTimeout, hideAmounts, billReminders. TDD, domain analyze clean, data & app suites green. |
| D-02b | Profile, help & support ports (DOC-01 follow-up) | ✅ done | agent | 10 Nov 2026 | [#65](https://github.com/Isaac-Zimba-J/buckets/pull/65) | `ProfileRepository`, `HelpContentRepository`, `EmailComposer`, `SystemSettingsOpener`, and `AppInfoReader` (added for About/R-SUPPORT-2; ARCHITECTURE §3 updated). Interfaces only; fakes land with D-15b. |
| D-02c | Category, device-zone & storage ports (DOC-01 follow-up) | ✅ done | agent | 11 Nov 2026 | [#68](https://github.com/Isaac-Zimba-J/buckets/pull/68) | `CategoryRepository` (name-keyed), `DeviceTimeZone`, `StorageManager`/`StorageSummary`, `DataWiper`. Merchant-rule watch/delete + income watch extend existing ports, so they ship with their Drift impls in DA-03b. |
| D-16b | Configurable lock timeout (DOC-01 follow-up) | ✅ done | agent | 11 Nov 2026 | [#66](https://github.com/Isaac-Zimba-J/buckets/pull/66) (closed; landed in b4f58f3) | `AppLockPolicy.shouldLock` takes a `LockTimeout` (default oneMinute); immediately/1 min/5 min boundaries tested with a fake clock. App `AppLockController` passes `settings.lockTimeout`. |
| D-15b | Use cases for 01b and 24–32 (DOC-01 follow-up) | ✅ done | agent | 11 Nov 2026 | [#67](https://github.com/Isaac-Zimba-J/buckets/pull/67) | SaveProfile, WatchProfileSummary, WatchSettings, SetLockTimeout/SetHideAmounts/SetBillReminders, ClearAlertHistory, ListHelpArticles/SearchHelp/GetHelpArticle/RecordArticleFeedback, BuildProblemReport/OpenEmailComposer, GetAppInfo/OpenStoreListing/OpenBatterySettings — all tested with fakes. Use cases needing new ports split to D-15c. |
| D-15c | Use cases over the D-02c ports (DOC-01 follow-up) | ✅ done | agent | 11 Nov 2026 | [#69](https://github.com/Isaac-Zimba-J/buckets/pull/69) | GetDeviceTimeZone, WatchCategories/AddCategory/RenameCategory/ArchiveCategory (R-CAT-1/2), GetStorageSummary, DeleteAllData (R-PRIV-4). Merchant-rule mgmt + WatchSetupCounts need existing-port extensions and ship in DA-03b. Tested with fakes. |
| D-17 | Move, starting balance & remove bucket | 🔵 in review | agent | 11 Nov 2026 | #83 | `MovePolicy` + `MoveBetweenBuckets` (cap, never <0, MoveNeedsConfirm), `SetStartingBalance` (marked adjustment, correction by reversal), `ArchiveBucket` (default refused, overspent/transfer blocked, move-out, split handover). Bucket `archive()`/`isRemovable`. 22 tests. |
| D-18 | Merchant rule editing (watch/delete) | 🔵 in review | agent | 12 Nov 2026 | – | MerchantRuleRepository gains getAll/watchAll/delete; WatchMerchantRules, DeleteMerchantRule use cases. Screen 28 shows saved rules with a delete button. |
| D-01c | Bill & fee entities (DOC-03) | 🔵 in review | agent | 12 Nov 2026 | – | `BucketKind.bills`, `BillOccurrence` (+`BillStatus`), `FeeBand`/`FeeTariff` (+`FeeType`, `FeeBandSource`); 10 tests; Bills bucket is not removable. |
| D-02d | Bill & fee ports (DOC-03) | 🔵 in review | agent | 13 Nov 2026 | – | BillOccurrenceRepository (getAll/getForCycle/getForBill/save/watchAll) and FeeTariffRepository (getAll/find/save/watchAll); interfaces only, fakes with D-21/DA-15. |
| D-19 | Bills cycle & occurrences (DOC-03) | 🔵 in review | agent | 13 Nov 2026 | – | BillOccurrences policy: dueIn (monthly day clamped to short months, non-monthly only in its cycle, start inclusive/end exclusive), forCycle (idempotent), isOverdue, isLate (local day), suggest (payee hint, ±25%), stats (last 6 average, last 5 on-time). 12 tests. |
| D-03b | Split bills into the Bills bucket (DOC-03) | 🔵 in review | agent | 13 Nov 2026 | – | No code change: `SplitCalculator.amountToSplit` already subtracts the bill total; the 12,000 / 4,300 split is unchanged and now pinned by a D-05b test. |
| D-05b | Payday writes Bills allocations (DOC-03) | 🔵 in review | agent | 13 Nov 2026 | – | PaydayPlanner.start allocates every bill reservation (tagged by bill) into the Bills bucket and never creates a transfer for it; falls back to the bill's own bucket until the seed exists (DA-05b). Also closes D-03b: SplitCalculator needed no change. 4 tests, 502 domain tests pass. |
| D-20 | Fee rates & FeePolicy (DOC-03) | 🔵 in review | agent | 13 Nov 2026 | – | FeePolicy: bandFor/estimate (inclusive ends; uncovered = unknown, K 0 band = real no fee), resolve (message > estimate > missing), learn (fills gaps with a learned one-amount band, counts matching observations, asks before changing a differing band), accept. FeeSource enum. 10 tests. |
| D-08b | Fees as linked transactions (DOC-03) | 🔵 in review | agent | 13 Nov 2026 | – | Transaction gains feeType, provider, feeSource, parentTransactionId (R-FEE-1); a missing-source fee may be K 0 (R-FEE-2); fee details only on Fees transactions. SpendingPolicy.feeTransaction links to its payment, the cash-out fee to its withdrawal. Not persisted until DA-14. 516 domain tests. |
| D-21 | Use cases for 33–37 and Payday fees (DOC-03) | 🔵 in review | agent | 13 Nov 2026 | – | EnsureBillOccurrences, GetBillsCycle/WatchBillsCycle, MarkBillPaid (spend from Bills, fee charged to Living, fee message>estimate>missing, advances a termly due date), WatchBillHistory, GetBillStats, EstimateFee, LearnFee, SaveFeeBand, DeleteFeeBand, ResolveFeeChange, WatchFeeTariffs, GetFeesSummary/WatchFeesSummary, ListMissingFees, EstimatePaydayFees, RecordTransferFee (hooked into ProveTransfer, best effort). SaveBill defaults to the Bills bucket (R-BILL-5). SpendWriter.writeAll. 531 domain tests. |

## Phase 2 – Data

| ID | Task | Status | Owner | Date | PR | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| DA-01 | Database schema v1 | ✅ done | agent | 3 Nov 2026 | [#25](https://github.com/Isaac-Zimba-J/buckets/pull/25) | 24 tables, append-only ledger triggers, indices; Flutter 3.47.9. Needs follow-up for DOC-01 → DA-01b. Needs follow-up for bills/fees → DA-14. |
| DA-02 | Mappers & DAOs | ✅ done | agent | 3 Nov 2026 | [#26](https://github.com/Isaac-Zimba-J/buckets/pull/26) | Mappers, DAOs, round-trip test per aggregate. |
| DA-03 | Repository impls + contract tests | ✅ done | agent | 3 Nov 2026 | [#28](https://github.com/Isaac-Zimba-J/buckets/pull/28) | Drift* for every port; contract suites run against InMemory* and Drift*. Needs follow-up for DOC-01 → DA-03b. Needs follow-up for bills/fees → DA-15. |
| DA-04 | Fakes package surface | ✅ done | agent | 3 Nov 2026 | [#28](https://github.com/Isaac-Zimba-J/buckets/pull/28) | Shipped with DA-03: `package:buckets_data/fakes.dart`. |
| DA-05 | First-run seed | ✅ done | agent | 3 Nov 2026 | [#29](https://github.com/Isaac-Zimba-J/buckets/pull/29) | Cash in hand, default buckets, default settings; idempotent. Needs follow-up for bills/fees → DA-05b. |
| DA-06 | System adapters | ✅ done | agent | 3 Nov 2026 | [#27](https://github.com/Isaac-Zimba-J/buckets/pull/27) | SystemClock, UuidGenerator, ZoneTimeZone (with links), DeviceTimeZone. |
| DA-07 | Local notifications adapter | ✅ done | agent | 4 Nov 2026 | [#31](https://github.com/Isaac-Zimba-J/buckets/pull/31) | Channel per kind, stable IDs, exact alarms with inexact fallback, deep-link payloads, sent log for N-LOW, permission gateway; Android setup done; building. |
| DA-08 | Android alert listener | ✅ done (allow-list waits on Open question 2) | agent | 4 Nov 2026 | [#31](https://github.com/Isaac-Zimba-J/buckets/pull/31) | Kotlin NotificationListenerService + queue + MethodChannel; AndroidPaymentAlertSource. Allow-list empty until Open question 2. |
| DA-09 | OCR & image adapters | ✅ done | agent | 4 Nov 2026 | [#31](https://github.com/Isaac-Zimba-J/buckets/pull/31) | ML Kit bundled Latin model (offline); image_picker copies into app-private receipts/. |
| DA-10 | App lock adapter | ✅ done | agent | 4 Nov 2026 | [#31](https://github.com/Isaac-Zimba-J/buckets/pull/31) | local_auth behind a seam; FlutterFragmentActivity, USE_BIOMETRIC, AppCompat theme; APK builds. |
| DA-11 | Migration test harness | ✅ done | agent | 3 Nov 2026 | [#30](https://github.com/Isaac-Zimba-J/buckets/pull/30) | v1 schema dump committed; verifier tests; `melos run schema` regenerates. |
| DA-12 | Email composer, settings & app-info adapters | ✅ done | agent | 11 Nov 2026 | [#72](https://github.com/Isaac-Zimba-J/buckets/pull/72) | Native MethodChannel (`/support`): PlatformEmailComposer (ACTION_SENDTO), PlatformSystemSettingsOpener (notif access / battery / store), PlatformAppInfoReader (four whitelisted facts), PlatformDeviceTimeZone (flutter_timezone). Kotlin in MainActivity; Dart adapters tested with a mock channel. No new packages. Renamed the old data `DeviceTimeZone` helper to `DeviceTimeZoneLoader` (name clash with the port). Native code needs device testing (checklist in PR). |
| DA-01b | Schema v2 (DOC-01 follow-up) | ✅ done | agent | 11 Nov 2026 | [#70](https://github.com/Isaac-Zimba-J/buckets/pull/70) | `profiles`, `categories`, `help_feedback` tables; settings gains lock_timeout/hide_amounts/bill_reminders (withDefault). schemaVersion 2 + onUpgrade; v2 schema dumped; migrateAndValidate(2) test. Codegen committed. |
| DA-03b | Repositories for new ports (DOC-01 follow-up) | ✅ done | agent | 11 Nov 2026 | [#71](https://github.com/Isaac-Zimba-J/buckets/pull/71) | DriftProfileRepository, DriftCategoryRepository (rename rewrites transactions/merchant_rules); settings mapper reads/writes lock_timeout/hide_amounts/bill_reminders; `Category.fromStored`; FirstRunSeed seeds default categories; InMemory fakes + contract tests. HelpContentRepository, StorageManager/DataWiper impls and merchant/income extensions still to come. |
| DA-03c | Help content, storage & data-wipe impls (DOC-01 follow-up) | ✅ done | agent | 11 Nov 2026 | [#73](https://github.com/Isaac-Zimba-J/buckets/pull/73) | BundledHelpContentRepository (6 bundled articles, feedback in help_feedback) and DriftStorageManager (alert/receipt counts, db size). DataWiper impl still to do (ledger triggers block row-delete; needs a file-level wipe + device test). |
| DA-13 | DataWiper (Delete all data) | 🔵 in review | agent | 11 Nov 2026 | – | DriftDataWiper empties every table (keeps schema + ledger triggers), cancels notifications (replaceAll []), deletes receipt images; DeleteAllData wired; screen 27 Delete-all → typed-DELETE confirm → wipe → Welcome. |
| DA-14 | Schema v3: bill occurrences, fee tariffs, fee fields (DOC-03) | 🔵 in review | agent | 13 Nov 2026 | – | bill_occurrences (unique per bill per cycle), fee_tariffs, fee_bands tables; fee_type/provider/fee_source/parent_transaction_id on transactions (mapper round-trips them). Additive v2 -> v3 migration; v1 -> v3 and v2 -> v3 verified; schema v3 dumped. Existing bill money is not moved (DOMAIN R-BILL-2a and PLAN corrected). |
| DA-05b | Seed the Bills bucket (DOC-03) | 🔵 in review | agent | 13 Nov 2026 | – | Bills bucket seeded for new and existing installs (R-BUCKET-7); hidden from Home tiles and the Choose screen; demo/test Living figures updated. D-03b closed: SplitCalculator needs no change. |
| DA-15 | Bill & fee repositories (DOC-03) | 🔵 in review | agent | 13 Nov 2026 | – | DriftBillOccurrenceRepository and DriftFeeTariffRepository (header + band rows; watchAll reads both tables so an empty tariff still emits), BillFeeMappers (dates as yyyy-MM-dd), InMemory fakes exported from fakes.dart; one contract suite (14 tests) passes on both. |

## Phase 3 – Application

| ID | Task | Status | Owner | Date | PR | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| AP-01 | Composition root | ✅ done | agent | 4 Nov 2026 | [#32](https://github.com/Isaac-Zimba-J/buckets/pull/32) | Riverpod providers for every port (drift + adapters) and all 68 use cases; fake overrides; demo seed = canvas. |
| AP-02 | Screen controllers | ✅ done | agent | 4 Nov 2026 | #33 #34 #35 #36 | 19 controllers for screens 01–22 in 4 PRs: a setup, b home/goals/plan, c payday, d logging/check-in. Needs follow-up for DOC-01 → AP-02b. Needs follow-up for bills/fees → AP-05. |
| AP-03 | Routing & guards | ✅ done | agent | 4 Nov 2026 | #37 | go_router 18.1.2; every SCREENS.md route plus /me/*; setup guard; buckets:// links and notification taps (incl. cold start) → routes; `/alert/:id` resolves to 17 (incoming) or 18. `buckets://plan/bills` → /me/bills (Plan has no bills tab). 19 router tests on placeholder screens. Needs follow-up for DOC-01 → AP-03b. Needs follow-up for bills/fees → AP-06. |
| AP-04 | Flow tests without UI | ✅ done | agent | 4 Nov 2026 | #38 | The six PLAN flows on controllers and fakes (`app/test/flows/`). Adds `IncomeReceivedController.salaryLanded()` for DOMAIN §5 (a), a confirmed salary alert starting the payday, which no controller exposed. See Open question 12. |
| AP-01b | Composition root for the new ports (DOC-01 follow-up) | ✅ done | agent | 11 Nov 2026 | [#74](https://github.com/Isaac-Zimba-J/buckets/pull/74) | ports.dart providers for ProfileRepository, CategoryRepository, HelpContentRepository, StorageManager, DeviceTimeZone, EmailComposer, SystemSettingsOpener, AppInfoReader; me_use_cases.dart (22 use-case providers); firstRunSeed seeds categories; fakes (fake_support.dart) + overrides. |
| AP-02b | Controllers for 01b and 24–32 (DOC-01 follow-up) | ✅ done | agent | 11 Nov 2026 | [#75](https://github.com/Isaac-Zimba-J/buckets/pull/75) | ProfileController (01b) + Settings/Security/DataPrivacy/Rules/About and Help/HelpArticle/Report controllers, each freezed state + tests. Delete-all waits on DataWiper; merchant-rule editing on the port extensions. Support email via AppConfig placeholder (Open Q13). |
| AP-03b | Routes for 01b and 24–32 (DOC-01 follow-up) | ✅ done | agent | 11 Nov 2026 | [#76](https://github.com/Isaac-Zimba-J/buckets/pull/76) | Routes /setup/profile, /me/profile, /me/settings(/security,/data), /me/rules, /me/about, /help, /help/report, /help/:articleId; AppScreen values + router tests. Screens are placeholders until S-01b/S-10b/S-11; Welcome→01b nav lands in S-01b. |
| AP-04b | Controllers for move, starting balance & remove | 🔵 in review | agent | 11 Nov 2026 | #84 | `BucketDetailController` gains `move` (MoveMade/MoveConfirmNeeded/MoveFailed), `setStartingBalance`, `remove`; `BucketActionsVm` (isRemovable, available, destinations) on both states. Providers added. 4 controller tests. |
| AP-05 | Controllers 33–37 and Payday fees (DOC-03) | 🔵 in review | agent | 13 Nov 2026 | – | Providers for the bill/fee ports and use cases; controllers for screens 33–37; Payday carries per-transfer fee estimates; ProveTransfer records fees. Occurrences are ensured when screen 33 opens. Learned-change prompt (37) has no stored pending state, so the controller only exposes resolve. |
| AP-06 | Routes & bill notification links (DOC-03) | 🔵 in review | agent | 13 Nov 2026 | – | Routes for 33–37, buckets://plan/bills → /plan/bills and …/:billId/pay, N-BILL-DUE-TODAY and N-BILL-OVERDUE (3 reminders), occurrences ensured before each schedule. Screens are an empty Scaffold until S-13. |

## 🚧 Logic complete gate

| Gate | Status | Opened by | Date |
| --- | --- | --- | --- |
| All F, D, DA, AP tasks ✅, coverage met, open questions resolved | ✅ open | Isaac Zimba | 9 Nov 2026 |

No UI-* or S-* task may start while this gate is closed. Only a human changes this row.

## Phase 4 – UI kit

| ID | Task | Status | Owner | Date | PR | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| UI-01 | Theme | ✅ done | agent | 9 Nov 2026 | #39 | `BucketsTheme.light/dark`; ThemeExtensions for colors, type, spacing, radius, shadows; `context.bk`; light and dark token-sheet goldens. 11 ui_kit tests. |
| UI-02 | Foundation | ✅ done | agent | 9 Nov 2026 | #40 | `BkMoneyText` (MoneyFormatter, xl/l/m, sign, ngwee); `BkIcon` + 15-glyph `BkIcons` set drawn on a 24 grid with a 1.75 stroke (no icon package is approved), filled variant for tab icons; `BkGap`; `BkTapTarget` (44 px), `BkHeading`, `BkSemanticLabel`; light/dark goldens. Geist fonts bundled in #41. |
| UI-03 | Actions & inputs | ✅ done | agent | 9 Nov 2026 | #42 #43 #52 | a actions (`BkButton` ×4 with icon/loading/disabled reason, `BkIconButton`, `BkFab`); b inputs (`BkTextField`, `BkAmountField` + `bkParseKwacha`, `BkSegmented`, `BkChip`/`BkChipGroup`, `BkToggleRow`, `BkCheckRow`, `BkRadioCard`, `BkRowPicker`, `BkBucketColor`); c (10 Nov) for the payday loop: `BkSmsField`, `BkButton.accent`, `BkHeroStat`, `paste` and `streak` glyphs. |
| UI-04 | Containers & feedback | ✅ done | agent | 9 Nov 2026 | #44 | `BkCard`, `BkHeroCard`, `BkListGroup`/`BkListRow`, `BkBanner` (danger is a live region), `BkToast` + `showBkToast` (3 s, Undo), `BkBadge`, `BkBottomSheet` + `showBkSheet`, `BkSkeleton` (static), `BkEmptyState`, `BkBottomActions`; `BkTone` shared by banners and badges. Needs follow-up for DOC-01 → UI-04b. |
| UI-05 | Money widgets | ✅ done | agent | 9 Nov 2026 | #45 | `BkBucketDot`, `BkSplitBar` (bp widths, 3px gaps), `BkBucketTile`, `BkProgressBar` (+ on hero), `BkProgressRing`, `BkTransferRow` (pending/proven/partial/selfReported), `BkProofCheckRow` (passed/failed/unknown), `BkStepList`. Status texts come from the app (no copy in ui_kit). |
| UI-06 | Navigation | ✅ done | agent | 9 Nov 2026 | #46 | `BkTopBar` (leading/title/trailing, centred), `BkFlowHeader` (step label + 4px progress, back hidden on step 1), `BkGreetingHeader` (unread dot), `BkTabBar` (76 tall, filled active icon, selected semantics). |
| UI-07 | Gallery & goldens | ✅ done | agent | 10 Nov 2026 | #47 | Plain gallery app `packages/ui_kit/gallery` (light/dark/system) over shared pages in `package:buckets_ui_kit/gallery.dart`; goldens render the same 8 pages in both themes; ADR-0005 (no widgetbook, no alchemist, 3% cross-platform tolerance). |
| UI-04b | New containers (DOC-01 follow-up) | ✅ done | agent | 11 Nov 2026 | [#77](https://github.com/Isaac-Zimba-J/buckets/pull/77) | `BkConfirmDialog` (typed-confirmation gate), `BkAvatar`, `BkSearchField`, `BkSettingsRow`; widget tests + light/dark containers golden regenerated; added to the gallery. |
| UI-08 | Bill & fee components (DOC-03) | 🔵 in review | agent | 13 Nov 2026 | – | BkBillRow, BkMonthGrid, BkProviderBar with widget tests and light/dark goldens; gallery page added. BkProviderBar takes a BkBucketColor (token) instead of a raw colour. |

## Phase 5 – Screens

| ID | Task | Status | Owner | Date | PR | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| S-01 | 01–06 Setup | ✅ done | agent | 10 Nov 2026 | #48 | Welcome → Income (add account inline) → Bills (sheet, termly date) → Split (share sheet, 110% and bills-exceed states) → Accounts (Choose badges, set later) → Alarms (blocked → Open settings) → Home. Same screens from Me with a top bar. Flow test + state tests. Needs follow-up for DOC-01 → S-01b. |
| S-02 | 07–08 Home (empty, normal) | ✅ done | agent | 10 Nov 2026 | #49 | 07 countdown hero + tiles; 08 Living left / per day / Guilt-free hero, payday banner (→ 13), lock note, payments-to-sort row and bell (→ 18), 3-column tiles (→ 09), recent list, FAB (→ 19); live from streams. Tab bar shell (`TabScaffold`) for Home/Goals/Plan/Me. |
| S-03 | 18–21 Logging | ✅ done | agent | 10 Nov 2026 | #50 | 18 sort sheet (rule pre-fill, always-file, skip, all sorted); 19 log cash / paste (validation, wish banner, toast); 20 scan (processing, no text + retake, camera denied); 21 receipt review (unsure total → fix, items off/match); balances update. |
| S-04 | 12–16 Payday loop | ✅ done | agent | 10 Nov 2026 | #53 | 13 hero (left of total, progress), rows with destination and Proven HH:MM / owed / Self-reported badges, lock note, snooze until HH:MM (none left, after 21:00); 14 paste from clipboard, 4 checks with values; 15 banner per failed check, partial (save K x, owe K y), try another, mark as saved; 16 hero summary, streak and goal tiles. Notifications now scheduled (`NotificationSync`: start, data changes, resume) and N-PAYDAY opens 13. `ScreenFrame` actions moved into the body so they stay above the keyboard. Domain: `PaydayPlanner.snoozeAlarmAt`. Real SMS still can't pass proof until D-06a/b fixtures. Needs follow-up for bills/fees → S-04b. |
| S-05 | 17 Side hustle | ✅ done | agent | 10 Nov 2026 | #54 | Source badge, from, +amount; side hustle segmented (+ Something else) with its split bar and rows (preview via PreviewSplit); Split it → 13; Hold until month end → release date; Leave it out → Home + toast; salary suggestion banner (Start payday / it's side hustle money); missing amount → enter it; no hustle → empty state → Income. |
| S-06 | 09 Overspent | ✅ done | agent | 10 Nov 2026 | #55 | Normal: left to spend + this cycle's entries. Overspent: balance with "K x over" badge, split-too-tight tip (R-OVER-4) → Income, cover options as radio cards in R-OVER-2 order with before → after, next cycle's bucket, lock caption, Move K x (R-OVER-3) with toast. |
| S-07 | 10–11 Goals & Plan | ✅ done | agent | 10 Nov 2026 | #56 | 10: stats, goal cards (progress, K x a month · ETA / not in any split → Income / reached), new goal sheet, celebration toast once (R-GOAL-4), empty state. 11: To buy / Wishes tabs (no Bills tab, per AP-03), check rows with bucket, add sheet for buys and wishes, wish ring with hours left, Changed my mind, Time's up → Still want it / Drop it, empty per tab, `?tab=wishes`. Needs follow-up for bills/fees → S-07b. |
| S-08 | 22 Check-in | ✅ done | agent | 10 Nov 2026 | #57 | Step list; sort step → 18 (skipped when nothing to sort); count: you should have, wallet amount, spot on / missing (Log it now, Mark untracked) / received (Into Living, Keep as cash); week: spent per bucket, saved, untracked. Fixes S-04's ScreenFrame change, where toasts covered the buttons. |
| S-09 | 23 States everywhere | ✅ done | agent | 10 Nov 2026 | #59 | Sweep tests over every screen at text scale 1.0 and 1.3: no overflow, 44 px targets, labelled targets, contrast. Error sweep: every loading screen shows the banner with Try again. Fixes: Home payday banner had no screen-reader label; segmented options 40 → 44 px; BkListRow trailing could overflow; payday hero wraps at large text. |
| S-10 | Me tab | ✅ done | agent | 10 Nov 2026 | #58 | Me list: income sources, bills, a split per income, buckets & accounts, notifications; app lock toggle (unlock first; needs a phone screen lock) plus the lock itself at launch and on resume after 1 min; snoozes 0–3, cooling-off 24/48/72h, wish threshold, auto-file; about & privacy. Domain: `SetAppLock`, `SavePlanningPreferences`, `UnlockApp`, `AppLockPolicy`. Every route now has a real screen. |
| S-01b | 01b About you + 6-step setup (DOC-01 follow-up) | ✅ done | agent | 11 Nov 2026 | [#78](https://github.com/Isaac-Zimba-J/buckets/pull/78) | ProfileScreen (01b) wired to ProfileController; setup flow header now n of 6; Welcome→01b, Income back→01b. l10n strings added. Flow + state tests updated/added; setup, routing, flows, a11y suites green locally. |
| S-10b | 24–28 Me, settings, security, data, rules | ✅ done | agent | 11 Nov 2026 | [#79](https://github.com/Isaac-Zimba-J/buckets/pull/79) | Me hub redesign (avatar + nav), Settings (25), Security (26, app lock/timeout/hide amounts), Data & privacy (27, storage + clear alerts; delete-all awaits DataWiper), Rules (28, categories; merchant rules await port). Wired to AP-02b controllers; me/a11y/routing tests. |
| S-11 | 29–32 Help, article, report, about | 🔵 in review | agent | 11 Nov 2026 | – | Help (search + topic cards + report CTA), Help article (body + Open settings + Did-this-help), Report (category chips, multiline, attach-info, opens email app), About (version, privacy/how/rate/licences). Wired to AP-02b controllers; BkTextField gains maxLines. Screen widget tests + visual check vs mockups 29–32. |
| S-12 | Move, starting balance & remove on 09 + Home card | 🔵 in review | agent | 11 Nov 2026 | #85 | Screen 09 "Manage bucket" section (overline + settings rows, Remove destructive for goals); move sheet (destination picker, cap, R-MOVE-2 confirm dialog); starting-balance sheet; remove flow (move-out picker, destructive confirm, pop Home); Home firstRun card. Matches me-folder settings design. 5 screen tests. |
| S-13 | 33–37 Bills & fees screens (DOC-03) | 🔵 in review | agent | 13 Nov 2026 | – | Added docs/TESTING_BILLS_FEES.md (docs only). |
| S-04b | Payday fees (DOC-03) | 🔵 in review | agent | 13 Nov 2026 | – | Per-transfer fee (~K x, K x actual, or no fee) and a hero note 'Plus about K x in transfer fees, taken from Living'. Unknown rates show nothing. |
| S-07b | Plan Bills tab (DOC-03) | 🔵 in review | agent | 13 Nov 2026 | – | Plan (11) has a Bills segment that opens screen 33. |

## Phase 6 – Release V1

| ID | Task | Status | Owner | Date | PR | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| R-01 | Android permissions & policy review | 🔵 in review | agent | 13 Nov 2026 | – | ADR-0006: keep POST_NOTIFICATIONS, SCHEDULE_EXACT_ALARM (inexact fallback), notification listener; no USE_EXACT_ALARM, full-screen intent or SMS permissions. Not done: merged release manifest not built or inspected; Play listener policy wording unconfirmed. |
| R-02 | Low-end device pass | ⬜ todo | – | – | – |  |
| R-03 | Dogfood build | ⬜ todo | – | – | – |  |

## Handoff state (12 Nov 2026)

Written when work moved between machines. See `docs/HANDOVER.md` for the full
picture. The per-task rows above are owned by their PRs; this section is the
index of what is in flight.

**Open PRs, CI green, awaiting a human merge** (merge in this order):

| Order | PR | Task | Status after merge |
| --- | --- | --- | --- |
| 1 | #91 | S-11 Help, article, report, about (29–32) | ✅ (Phase 5 Done +1) |
| 2 | #94 | S-11p Help article steps + common questions (stacked on #91) | ✅ |
| 3 | #92 | DA-13 DataWiper / Delete all data (R-PRIV-4) | ✅ |
| 4 | #93 | D-18 Merchant rule editing on screen 28 | ✅ |

After merging: resolve the expected PROGRESS conflict by keeping every row,
take the newest "Last updated" text, and **recount the Summary table** (S-11,
DA-13 and D-18 change the Phase 5, Phase 2 and Phase 1 totals).

**Remaining, in order:**

1. DOC-03 Bills tracking & transaction fees: docs-only plan, pre-flight done,
   **waiting for the owner's "go"**. ID renumbering is in HANDOVER §8.
2. Screen-by-screen UI polish pass against the mockups (Home done).
3. Device-test DA-12's native code (CI can't exercise Kotlin).
4. Release phase: R-01, R-02, R-03.
5. Blocked on the owner: SMS fixtures (Q1) and package names (Q2) for D-06a/b
   and DA-08; receipt OCR fixtures (Q10); support email address (Q13, currently
   the placeholder in `app/lib/bootstrap/app_config.dart`).

**Deferred on purpose:** Me tab "proven paydays" / setup counts (the design
doesn't show them).

## Open questions

Agents add questions here instead of guessing. A human answers inline and moves the item to Decisions.

1. **Fixtures:** owner to provide 10–20 redacted MTN MoMo and Airtel Money messages per type (DOMAIN §17). Blocks D-06a/b.
2. **Package names allowed for the alert listener:** confirm the Android package IDs of the MTN MoMo app, the Airtel Money app and the default SMS app(s) on the owner's phone. Needed for DA-08.
3. **Emergency target:** the Goals design frame shows K 24,450 (old 50% Living split). DOMAIN R-GOAL-3 with the current split gives K 22,140. Domain wins unless the owner says otherwise; design frame to be updated.
4. **Termly bills:** R-BILL-1 uses a sinking fund aimed at the next due date. Confirm this is preferred over a flat amount ÷ 4.
5. **Snooze limit default:** 1 per payday (R-PAY-4). Confirm.
6. **Basic validation added in D-01 (please confirm):** names must not be blank; amounts must be above K 0 for income, bills, transfers, paydays, transactions, planned buys, wishes and goal targets; a bucket may appear only once in a split; a transaction's split lines must add up to its total; counted cash cannot be negative. DOMAIN.md doesn't state these.
7. **Planned purchase `repeatEvery`:** DOMAIN §14 gives no unit. Modelled as a `Duration` for now. Is it days, weeks or months (calendar months would need a different type)?
8. **Check-in fields:** DOMAIN §15 doesn't list them. Modelled as `countedAt`, `expectedCash`, `countedCash`, with `gap` derived. Anything else to store (e.g. week summary)?
9. **Names that clash with Dart keywords:** alert status `new` is `AlertStatus.newAlert`; message direction `out`/`in` is `MessageDirection.outgoing`/`incoming`.
10. **Receipt fixtures:** owner to provide redacted OCR text from 10–20 real receipts in `packages/domain/test/fixtures/receipts/` (`<case>.txt` + `<case>.expected.json`). Blocks the `ReceiptTextParser` implementation (R-RECEIPT-1); the review rules (R-RECEIPT-2) are done.
11. **Payday alarm in quiet hours:** R-NOTIF-1 lets N-PAYDAY fire in quiet hours "if the user scheduled the payday reminder inside that window themselves", but DOMAIN §16 has no payday-reminder time setting. For now the alarm always skips quiet hours and resumes at 07:00. Should there be a payday reminder time setting (PATTERNS says 08:00 on payday)?
12. **Manual "Salary landed" (DOMAIN §5 (b)):** a payday can start when "the scheduled payday date arrives and the user taps 'Salary landed'", but SCREENS.md gives no screen or controller that action. Screen 17 now has it for a salary *alert* (§5 (a)). Where should the manual button live: Home 07/08 on payday, the N-PAYDAY reminder, or both? And should it ask for the amount (default: expected salary)?
13. **Support email address** for Report a problem (R-SUPPORT-1).
14. **Packages for links, app info and help:** approve ADRs for (a) one package that opens links, used for both the email app (`mailto:`, DA-12) and the Play Store listing (32), e.g. `url_launcher`, with the system-settings deep links (DA-12) through it or a small platform channel; (b) app version and build for About and R-SUPPORT-2, e.g. `package_info_plus`, or build-time constants; (c) Android version and device model for R-SUPPORT-2, e.g. `device_info_plus`, or a platform channel; (d) rendering bundled Markdown help articles (30), e.g. a Markdown widget package, or plain-text articles with no package. Resolved 11 Nov 2026: implemented with native MethodChannels + flutter_timezone, no new packages (see Decisions). Markdown help renders with a tiny in-app renderer, no package.

15. **Leftover Bills money:** when a bill is paid for less than was set aside (R-BILL-7), keep the difference in Bills (default) or move it to Short-term?
16. **Fee charging:** fees are charged to Living by default (R-FEE-6). Confirm, or charge the bucket the money is moving from.
17. **Bill payee match keys:** what each bill's payment message shows as the recipient (e.g. ZESCO). Owner to add redacted bill-payment fixtures (R-BILL-9).

## Decisions

| Date | Decision | Where recorded |
| --- | --- | --- |
| 3 Nov 2026 | Buckets pinned to Flutter 3.47.9 / Dart 3.13.7 via `.fvmrc` (other projects stay on 3.44.9), so drift codegen, build_runner and very_good_analysis 11 fit one workspace | .fvmrc, CI |
| 11 Nov 2026 | Categories are name-keyed: a categories table keyed by name with isDefault/archived; rename rewrites the denormalised category name on transactions. No ids, no transaction migration. | DOMAIN R-CAT-1/2, CategoryRepository |
| 11 Nov 2026 | Profile/help/support adapters (DA-12) use native MethodChannels (as the alert listener does) and the existing flutter_timezone; no new packages, so no ADR and open question 14 is resolved. | ARCHITECTURE §9, MainActivity.kt |
| 30 Oct 2026 | Logic before UI, enforced by the Logic complete gate | PLAN.md, AGENTS.md |
| 30 Oct 2026 | Guilt-free bucket is part of the default salary split (10%) | DOMAIN R-SPLIT-4 |
| 1 Nov 2026 | Bill money is allocated to its paying bucket, tagged per bill, and excluded from left to spend | DOMAIN R-BILL-2a, R-LEDGER-5 |
| 1 Nov 2026 | Payday on a missing day falls on the month's last day; reversed spends are netted out of cycle spend | DOMAIN R-TIME-3a, R-LEDGER-2 |
| 1 Nov 2026 | With no goal, the default splits' goal share goes to a configurable bucket, Long-term by default | DOMAIN R-SPLIT-4a, Settings.goalShareFallback |
| 30 Oct 2026 | Whole-kwacha display rounds half up (K 412.50 → K 413) | WRITING.md, MoneyFormatter |
| 30 Oct 2026 | Application ID `com.isaaczimba.buckets`; app name stays “Buckets” for now | app/android/app/build.gradle.kts |

## Blockers

| Task | Blocked by | Since |
| --- | --- | --- |
| D-06a, D-06b | Missing SMS fixtures | 30 Oct 2026 |
| D-09 (ReceiptTextParser only) | Missing receipt OCR fixtures (Open question 10) | 1 Nov 2026 |
| S-01b, S-10b, S-11 | The Logic complete gate is already open, but D-16, D-16b, D-01b, D-02b, D-02c, D-15b, D-15c, DA-01b, DA-03b, DA-12, AP-02b and AP-03b must be ✅ before these screen tasks start (DOC-01) | 10 Nov 2026 |
| DA-12, S-11 | Open questions 13 and 14 | 10 Nov 2026 |
