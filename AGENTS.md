# AGENTS.md

Strict rules for any AI coding agent working in this repository. These rules override your defaults. If a rule conflicts with a request in a task, stop and ask the human before continuing.

## 0. Read before you write anything

Read these files in this order at the start of every session, every time:

1. `AGENTS.md` (this file)
2. `docs/PROGRESS.md` – what is done, what is next, what is blocked
3. `docs/PLAN.md` – the task you are about to do and its acceptance criteria
4. `docs/ARCHITECTURE.md` – layers, folders, dependency rules
5. `docs/DOMAIN.md` – business rules (the source of truth for all logic)
6. If the task touches UI: `docs/COMPONENTS.md`, `docs/SCREENS.md` and everything in `docs/design/`

Then state, in one short paragraph, which task ID you are working on and what "done" means for it. Do not start coding until you have done this.

## 1. Order of work (the hard gate)

The app is built logic first, UI last.

1. **Foundations (F-*)** → 2. **Domain (D-*)** → 3. **Data (DA-*)** → 4. **Application/state (AP-*)** → 5. **UI kit (UI-*)** → 6. **Screens (S-*)** → 7. **Release (R-*)**.

- You may not create or edit any file under `app/lib/features/**/presentation/screens/` or `packages/ui_kit/lib/src/components/` until `docs/PROGRESS.md` shows the **Logic complete gate** as ✅. The gate is opened by a human, never by an agent.
- Inside a phase, do tasks in the order listed in `docs/PLAN.md` unless the task says it has no dependencies.
- One task ID per branch and per pull request. Never mix tasks.

## 2. Architecture rules (non-negotiable)

- Dependency direction: `app` → `ui_kit`, `domain`, `data`, `core`. `data` → `domain`, `core`. `domain` → `core`. `core` → nothing. `ui_kit` → `core` only.
- `packages/core` and `packages/domain` are **pure Dart**. They must never import `package:flutter`, `dart:ui`, `dart:io`, any database, any plugin or any platform API.
- `ui_kit` never imports `domain` or `data`. Components receive plain values (strings, ints, enums, callbacks), never entities.
- Screens never call repositories, databases or plugins. Screens talk to controllers; controllers call use cases; use cases call repository and port interfaces.
- Every external capability (database, notifications, alert listener, OCR, camera, clock, IDs, settings) is an interface (a "port") in `domain` with an implementation in `data` and an in-memory fake for tests.
- No business rule may live in a widget, a controller, a DAO or a mapper. If you are writing an `if` that decides money, it belongs in `domain`.

## 3. Money and data rules

- Money is always `Money` from `core` backed by an `int` of **ngwee** (1 kwacha = 100 ngwee). Never use `double` for money anywhere, including tests and DTOs.
- Percentages are `BasisPoints` (`int`, 10000 = 100%).
- Balances are derived from the append-only ledger. Never store a mutable balance column. Corrections are reversal entries.
- All time comes from the `Clock` port. Never call `DateTime.now()` outside `data/clock`.
- All IDs come from the `IdGenerator` port.
- Format money only with `MoneyFormatter` (`K 1,540`, `−K 320`, `K 412.50`) as defined in `docs/design/WRITING.md`.

## 4. Privacy rules (V1)

- V1 makes **zero network calls**. Do not add `http`, `dio`, Firebase, analytics, crash reporting or any SDK that phones home. If a task seems to need one, stop and ask.
- Raw SMS/notification text, account numbers, merchant names and receipt images never leave the device and never appear in logs. Use `redact()` from `core` in any log line.
- Never commit real personal data. SMS fixtures must be redacted (see `test/fixtures/README.md` rules in `docs/DOMAIN.md` §7).

## 5. Do not invent

- Do not invent SMS, notification or receipt formats. Parsers are written only against fixtures in `packages/domain/test/fixtures/`. If fixtures are missing for a provider, implement the parser interface, add a failing test that is skipped with `skip: 'needs fixtures'`, record the blocker in `docs/PROGRESS.md`, and move on.
- Do not invent package APIs. Before using a package, read its current documentation on pub.dev and pin the exact version you used in `pubspec.yaml`.
- Do not invent business rules. If `docs/DOMAIN.md` does not answer a question, stop, write the question under "Open questions" in `docs/PROGRESS.md`, and ask the human.

## 6. Dependencies

- Only the packages listed in `docs/ARCHITECTURE.md` §9 are approved.
- Adding any other dependency requires an ADR in `docs/adr/` (copy `docs/adr/0000-template.md`) and human approval before the code is merged.

## 7. Testing rules

- `domain`: test-driven. Write the failing test first. Every public use case and service has unit tests covering the happy path, every rule in `docs/DOMAIN.md` it implements, and edge cases (zero, rounding, negative balances, boundaries of time windows). Target ≥ 95% line coverage for `domain`.
- `data`: every repository implementation passes the same contract test suite as its in-memory fake. Drift migrations have migration tests.
- `app` controllers: tested with fakes, covering loading, empty, error and success states.
- `ui_kit`: every component has a widget test and golden tests in light and dark themes.
- Screens: widget tests for each state listed in `docs/SCREENS.md`, and the flow integration tests in `docs/PLAN.md` (AP-04, S-*).
- Never delete or weaken a test to make it pass. Never use `skip` except the fixture case in §5.

## 8. UI rules (only after the gate)

- Use only `ui_kit` components and theme tokens. No raw `Color(0x…)`, no hard-coded font sizes, paddings or radii in feature code.
- Every screen implements all its states from `docs/SCREENS.md` (normal, empty, loading, error, success where listed).
- All copy follows `docs/design/WRITING.md`. Strings live in `app/lib/l10n/app_en.arb`, never inline.
- Touch targets ≥ 44 logical px. Every icon-only button has a semantic label. Text contrast follows the token usage notes.
- Match the design canvas screen by screen. If a design detail conflicts with `docs/DOMAIN.md`, the domain wins and you note it in the PR.

## 9. Code style

- `dart format .` and `dart analyze --fatal-infos` (and `flutter analyze` in Flutter packages) must be clean.
- Lints: `very_good_analysis`. Do not add `// ignore:` without a comment explaining why.
- Files ≤ 300 lines, functions ≤ 40 lines. Split before you exceed them.
- Names: entities are nouns (`Bucket`), use cases are verbs (`ProveTransfer`), ports end in their role (`LedgerRepository`, `NotificationScheduler`), implementations are prefixed with their technology (`DriftLedgerRepository`, `LocalNotificationScheduler`), fakes with `InMemory` / `Fake`.
- Public APIs in `core`, `domain` and `ui_kit` have dartdoc comments.

## 10. Definition of done (every task)

A task is done only when all of these are true:

- [ ] Acceptance criteria in `docs/PLAN.md` for that task are met
- [ ] Tests written and passing (`melos run test` or the commands in `docs/BOOTSTRAP.md` §8)
- [ ] Format and analyze are clean
- [ ] No rule in this file is broken
- [ ] `docs/PROGRESS.md` is updated: task status, date, short note, PR link, any new open questions
- [ ] If you changed a rule, layer or dependency: the matching doc and an ADR are updated in the same PR

## 11. Updating PROGRESS.md

- Change only the row for your task and the "Last updated" line, plus "Open questions" or "Blockers" if needed.
- Status values: `⬜ todo`, `🟡 in progress`, `🔵 in review`, `✅ done`, `⛔ blocked`.
- Set `🟡` when you start, `🔵` when you open the PR. Only a human sets `✅` after merge.

## 12. When you are unsure

Stop and ask. A clear question costs a minute; a wrong assumption in money logic costs the user's trust. Never guess about money, time windows, privacy or permissions.
