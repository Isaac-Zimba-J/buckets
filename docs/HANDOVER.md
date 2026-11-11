# Handover for the next AI agent

You are continuing work on **Buckets**, a Zambian personal-money Flutter app
(offline, single-user, V1). Read this once, then follow it.

## 0. Read these first, every session (hard rule)

1. `AGENTS.md` (repo root) — the strict rules. They override your defaults.
2. `docs/PROGRESS.md` — status of every task; the source of truth for what's done.
3. `docs/PLAN.md` — task list and acceptance criteria.
4. `docs/DOMAIN.md` — business rules (R-*). Every money/time/privacy decision is here.
5. `docs/ARCHITECTURE.md` — layers and dependency direction.
6. For UI work: `docs/SCREENS.md`, `docs/COMPONENTS.md`, `docs/design/` and the
   mockups in `docs/design/screens/me/` (named `NN <screen>.png`).

Do not skip this. If a rule conflicts with a request, stop and ask the human.

## 1. Environment & commands

- **Flutter is pinned** to 3.47.9 via fvm. Always prefix PATH:
  `export PATH=$HOME/.pub-cache/bin:$HOME/fvm/versions/3.47.9/bin:$PATH`
  and `/usr/local/bin` for `gh`.
- Dart pub workspace + Melos. Useful: `melos run format`, `melos run analyze`,
  `melos run tokens` (regenerate design tokens), `melos run test`.
- **Codegen (freezed, riverpod):** after editing any `@freezed` / `@riverpod`
  file run `dart run build_runner build` (no `--delete-conflicting-outputs`;
  it's removed). CI diffs the generated `.g.dart`/`.freezed.dart`, so commit
  them. The first build on a cold machine is slow (~10 min); incremental ~30 s.
- **l10n:** strings live in `app/lib/l10n/app_en.arb`. After editing run
  `flutter gen-l10n`. Never hard-code user-facing text.
- **Checks before every PR:** `melos run format`, `dart analyze --fatal-infos`
  (must be "No issues found!"), and the relevant tests. Lints: `very_good_analysis`.
  Files <= 300 lines, functions <= 40.
- **This machine is slow.** Start the next task while builds/tests/CI run; never
  idle. Long commands: run in background, then do other work.

## 2. Git / PR workflow (what every change follows)

- One task ID per branch and per PR. Branch off `origin/main`.
- Commit messages and PR bodies end with the attribution the session's
  system-reminder specifies (currently `Co-Authored-By: Claude Opus 4.8
  <noreply@anthropic.com>` for commits, and the "Generated with Claude Code"
  line for PRs). Use whatever the active reminder says.
- Open the PR with `gh pr create`, wait for the `check` CI job to be SUCCESS,
  then `gh pr merge <n> --merge`. A typical wait loop:
  `until s=$(gh pr checks <n> --json name,state --jq '[.[]|select(.name=="check")|.state]|first'); [ "$s" = SUCCESS ] || [ "$s" = FAILURE ]; do sleep 20; done`
- Update `docs/PROGRESS.md` in the same PR: your row's status/date/PR link, the
  "Last updated" line, and recount the phase summary if a row flipped to done.
- After `gh pr merge`, `git checkout main && git pull` before the next branch.
- **Never run `git stash pop` blindly.** An old unrelated stash
  ("D-06a redacted MTN templates and fixtures") exists; applying it pollutes the
  tree. Stash with a message and pop only what you pushed.

## 3. Where things stand (Nov 2026)

V1 is essentially built: Foundations, Domain, Data, Application, UI-kit, and
Screens S-01…S-12 are merged. The app runs on a real phone through setup, Home,
logging, payday, goals/plan, check-in, and the Me stack.

Recently merged: S-12 (#85 move/starting-balance/remove bucket), Home polish to
mockup 07 (#87), design PNGs 33–37 (#88), Home first-run data (#89, name + hero
amounts + tile split %).

**Dark mode decision:** the app follows the system theme (light + dark both
ship). Do NOT force light-only — the owner wants dark kept. Mockups are light;
that's fine.

## 4. Worklist (do in order)

1. ~~Home first-run data~~ — DONE (#89).
2. **Screen-by-screen UI pass** against `docs/design/screens/me/`. Home done.
   Next in flow order: Setup 01–06, Bucket detail 09, Goals/Plan 10–11,
   Payday 13–17, Logging 18–22, Me stack 24–28. Method that worked for Home:
   run on device, screenshot (`adb -s <id> exec-out screencap -p > out.png`),
   diff against the mockup, fix, one PR per screen. Common gaps seen: section
   labels (uppercase overline + muted, see `_Section` in settings_screen.dart),
   card-vs-row layouts, spacing, tile aspect ratios.
3. **New scope — bills & fees (designs 33–37).** Bills management (mark paid,
   history) and **mobile-money fees** (the parked "item 4"). These need a
   planning pass first — write a DOC-03 adding the rules to DOMAIN.md and tasks
   to PLAN.md (mirror how DOC-02 was done), get owner confirmation on the money
   rules, then implement domain -> data -> controllers -> screens.
4. **Two more Home niceties** are optional polish, already partly covered by #89.

## 5. Blocked on the human (do not guess)

- **SMS fixtures** (Open question 1): redacted MTN MoMo / Airtel messages.
  Blocks D-06a/D-06b parser templates; without them real alerts don't parse.
- **Android package names** (Open question 2) for the notification-access
  listener allow-list (DA-08).
- **Receipt OCR fixtures** (Open question 10): blocks the real receipt parser.
- Open questions 3–9, 11 are assumptions awaiting confirmation (see PROGRESS).
- The money/time/privacy rule: when DOMAIN.md doesn't answer, add the question
  to PROGRESS "Open questions" and ask — never guess.

## 6. Testing gotchas (will save you time)

- Domain tests use `packages/domain/test/support/world.dart` and
  `payday_world.dart` (seeded repos; `PaydayWorld` has a `laptop` goal and
  `canvasSetup()`/`startSalary()`).
- App widget tests: harness in `app/test/features/setup/screens/screen_harness.dart`
  (`pumpApp`, `pumpScreen`, `type`, `typeAmount`, `tapOn`, `settleStreams`).
  **Live (stream) controllers** need `settleStreams(tester)` — the in-memory
  fakes deliver on the real event loop, so alternate short real waits with
  frames. Build the `ProviderContainer` inside each test (`start()`), not in a
  shared field, so fakes and widgets share the fake-async zone.
- Goldens tolerate a 3% pixel diff (macOS record vs Linux CI) — see
  `packages/ui_kit/test/flutter_test_config.dart` (ADR-0005). Gallery and
  goldens share their sample pages (`package:buckets_ui_kit/gallery.dart`).
- Money is always `Money` (int ngwee). Never `double`. Format only with
  `MoneyFormatter` (note the non-breaking space after `K`, so test strings use
  `K `). Percentages are `BasisPoints` (10000 = 100%).

## 7. Running on device

```
export PATH=$HOME/.pub-cache/bin:$HOME/fvm/versions/3.47.9/bin:$PATH
cd app && flutter run -d <device-id>   # flutter devices to list; authorize USB debugging on the phone
```
`flutter run` stays attached — launch it in the background and wait for the
"Flutter run key commands" line (or a build error) before screenshotting.
