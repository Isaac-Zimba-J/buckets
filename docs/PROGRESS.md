# Progress

Updated by whoever finishes work (agent or human) as the last step of every task. Agents follow AGENTS.md §11: change only your task's row, the "Last updated" line, and Open questions / Blockers.

**Last updated:** 30 Oct 2026 – F-04 merged; F-05 in review.

Status: ⬜ todo · 🟡 in progress · 🔵 in review · ✅ done · ⛔ blocked

## Summary

| Phase | Done | Total |
| --- | --- | --- |
| Phase 0 – Foundations | 4 | 5 |
| Phase 1 – Domain | 0 | 17 |
| Phase 2 – Data | 0 | 11 |
| Phase 3 – Application | 0 | 4 |
| Phase 4 – UI kit | 0 | 7 |
| Phase 5 – Screens | 0 | 10 |
| Phase 6 – Release V1 | 0 | 3 |


## Phase 0 – Foundations

| ID | Task | Status | Owner | Date | PR | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| F-01 | Scaffold workspace | ✅ done | agent | 30 Oct 2026 | [#1](https://github.com/Isaac-Zimba-J/buckets/pull/1) | Pub workspace + Melos 8.10.0; `test` pinned 1.31.0 (flutter_test pins test_api). Plugin deps deferred to the tasks that use them. Debug APK builds; not yet run on a device. |
| F-02 | Lints, format, CI | ✅ done | agent | 30 Oct 2026 | [#2](https://github.com/Isaac-Zimba-J/buckets/pull/2) | very_good_analysis 10.3.0 (11.x needs Dart 3.13), one root analysis_options.yaml. CI pinned to Flutter 3.44.9. Token staleness check joins CI in F-05. |
| F-03 | ADR set | ✅ done | agent | 30 Oct 2026 | [#3](https://github.com/Isaac-Zimba-J/buckets/pull/3) | ADR-0001…0004 Accepted, written from ARCHITECTURE/AGENTS. |
| F-04 | core primitives | ✅ done | agent | 30 Oct 2026 | [#4](https://github.com/Isaac-Zimba-J/buckets/pull/4) | 100% line coverage (86/86). `redact()` masks letters → x, digits → #. Logger deferred to first use. |
| F-05 | Token generator | 🔵 in review | agent | 30 Oct 2026 | [#5](https://github.com/Isaac-Zimba-J/buckets/pull/5) | 5 generated files, tokens exported from ui_kit, CI fails on stale tokens (verified). No widgets. |

## Phase 1 – Domain

| ID | Task | Status | Owner | Date | PR | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| D-01 | Entities & value objects | ⬜ todo | – | – | – |  |
| D-02 | Ports | ⬜ todo | – | – | – |  |
| D-03 | SplitCalculator | ⬜ todo | – | – | – |  |
| D-04 | Ledger & BalanceCalculator | ⬜ todo | – | – | – |  |
| D-05 | PaydayPlanner & payday lifecycle | ⬜ todo | – | – | – |  |
| D-06 | SmsParser framework | ⬜ todo | – | – | – |  |
| D-06a | MTN MoMo templates | ⛔ blocked | – | – | – | Blocked until fixtures exist (DOMAIN §17) |
| D-06b | Airtel Money templates | ⛔ blocked | – | – | – | Blocked until fixtures exist (DOMAIN §17) |
| D-07 | ProofVerifier | ⬜ todo | – | – | – |  |
| D-08 | Spending & Categorizer | ⬜ todo | – | – | – |  |
| D-09 | ReceiptTextParser | ⬜ todo | – | – | – |  |
| D-10 | OverspendPolicy | ⬜ todo | – | – | – |  |
| D-11 | GoalProjector | ⬜ todo | – | – | – |  |
| D-12 | Planning & CoolingOffPolicy | ⬜ todo | – | – | – |  |
| D-13 | CashReconciler & check-in | ⬜ todo | – | – | – |  |
| D-14 | NotificationPolicy | ⬜ todo | – | – | – |  |
| D-15 | Use cases | ⬜ todo | – | – | – |  |

## Phase 2 – Data

| ID | Task | Status | Owner | Date | PR | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| DA-01 | Database schema v1 | ⬜ todo | – | – | – |  |
| DA-02 | Mappers & DAOs | ⬜ todo | – | – | – |  |
| DA-03 | Repository impls + contract tests | ⬜ todo | – | – | – |  |
| DA-04 | Fakes package surface | ⬜ todo | – | – | – |  |
| DA-05 | First-run seed | ⬜ todo | – | – | – |  |
| DA-06 | System adapters | ⬜ todo | – | – | – |  |
| DA-07 | Local notifications adapter | ⬜ todo | – | – | – |  |
| DA-08 | Android alert listener | ⬜ todo | – | – | – |  |
| DA-09 | OCR & image adapters | ⬜ todo | – | – | – |  |
| DA-10 | App lock adapter | ⬜ todo | – | – | – |  |
| DA-11 | Migration test harness | ⬜ todo | – | – | – |  |

## Phase 3 – Application

| ID | Task | Status | Owner | Date | PR | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| AP-01 | Composition root | ⬜ todo | – | – | – |  |
| AP-02 | Screen controllers | ⬜ todo | – | – | – |  |
| AP-03 | Routing & guards | ⬜ todo | – | – | – |  |
| AP-04 | Flow tests without UI | ⬜ todo | – | – | – |  |

## 🚧 Logic complete gate

| Gate | Status | Opened by | Date |
| --- | --- | --- | --- |
| All F, D, DA, AP tasks ✅, coverage met, open questions resolved | ⬜ closed | – | – |

No UI-* or S-* task may start while this gate is closed. Only a human changes this row.

## Phase 4 – UI kit

| ID | Task | Status | Owner | Date | PR | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| UI-01 | Theme | ⬜ todo | – | – | – |  |
| UI-02 | Foundation | ⬜ todo | – | – | – |  |
| UI-03 | Actions & inputs | ⬜ todo | – | – | – |  |
| UI-04 | Containers & feedback | ⬜ todo | – | – | – |  |
| UI-05 | Money widgets | ⬜ todo | – | – | – |  |
| UI-06 | Navigation | ⬜ todo | – | – | – |  |
| UI-07 | Gallery & goldens | ⬜ todo | – | – | – |  |

## Phase 5 – Screens

| ID | Task | Status | Owner | Date | PR | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| S-01 | 01–06 Setup | ⬜ todo | – | – | – |  |
| S-02 | 07–08 Home (empty, normal) | ⬜ todo | – | – | – |  |
| S-03 | 18–21 Logging | ⬜ todo | – | – | – |  |
| S-04 | 12–16 Payday loop | ⬜ todo | – | – | – |  |
| S-05 | 17 Side hustle | ⬜ todo | – | – | – |  |
| S-06 | 09 Overspent | ⬜ todo | – | – | – |  |
| S-07 | 10–11 Goals & Plan | ⬜ todo | – | – | – |  |
| S-08 | 22 Check-in | ⬜ todo | – | – | – |  |
| S-09 | 23 States everywhere | ⬜ todo | – | – | – |  |
| S-10 | Me tab | ⬜ todo | – | – | – |  |

## Phase 6 – Release V1

| ID | Task | Status | Owner | Date | PR | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| R-01 | Android permissions & policy review | ⬜ todo | – | – | – |  |
| R-02 | Low-end device pass | ⬜ todo | – | – | – |  |
| R-03 | Dogfood build | ⬜ todo | – | – | – |  |

## Open questions

Agents add questions here instead of guessing. A human answers inline and moves the item to Decisions.

1. **Fixtures:** owner to provide 10–20 redacted MTN MoMo and Airtel Money messages per type (DOMAIN §17). Blocks D-06a/b.
2. **Package names allowed for the alert listener:** confirm the Android package IDs of the MTN MoMo app, the Airtel Money app and the default SMS app(s) on the owner's phone. Needed for DA-08.
3. **Emergency target:** the Goals design frame shows K 24,450 (old 50% Living split). DOMAIN R-GOAL-3 with the current split gives K 22,140. Domain wins unless the owner says otherwise; design frame to be updated.
4. **Termly bills:** R-BILL-1 uses a sinking fund aimed at the next due date. Confirm this is preferred over a flat amount ÷ 4.
5. **Snooze limit default:** 1 per payday (R-PAY-4). Confirm.

## Decisions

| Date | Decision | Where recorded |
| --- | --- | --- |
| 30 Oct 2026 | Logic before UI, enforced by the Logic complete gate | PLAN.md, AGENTS.md |
| 30 Oct 2026 | Guilt-free bucket is part of the default salary split (10%) | DOMAIN R-SPLIT-4 |
| 30 Oct 2026 | Whole-kwacha display rounds half up (K 412.50 → K 413) | WRITING.md, MoneyFormatter |
| 30 Oct 2026 | Application ID `com.isaaczimba.buckets`; app name stays “Buckets” for now | app/android/app/build.gradle.kts |

## Blockers

| Task | Blocked by | Since |
| --- | --- | --- |
| D-06a, D-06b | Missing SMS fixtures | 30 Oct 2026 |
