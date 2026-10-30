# Contributing to Buckets

Thanks for helping. This guide is for two kinds of contributors:

- **Contributors** who write code themselves.
- **Agent drivers** who direct an AI coding agent (Claude Code, Cursor, Copilot, etc.) to write code.

Both follow the same process and the same rules. Agents additionally follow `AGENTS.md`, and the human driving the agent is responsible for everything it submits.

## 1. Before you start

1. Read `README.md`, `docs/ARCHITECTURE.md`, `docs/DOMAIN.md` and `docs/PLAN.md`.
2. Set up your machine with `docs/BOOTSTRAP.md` §1–§3.
3. Open `docs/PROGRESS.md` and pick the **first** `⬜ todo` task whose dependencies are `✅ done`. If you want something else, ask in the issue tracker first.
4. Mark it `🟡 in progress` with your name in a small PR or directly on `main` if you are the maintainer.

## 2. The golden rules

- **Logic before UI.** No screen or UI component work until the "Logic complete" gate in `docs/PROGRESS.md` is ✅.
- **One task, one branch, one PR.** Task IDs come from `docs/PLAN.md`.
- **Pure domain.** `packages/core` and `packages/domain` never import Flutter or plugins.
- **Money is integer ngwee.** Never `double`.
- **No network in V1.** No analytics, crash SDKs or HTTP clients.
- **Tests first in `domain`.**
- **Docs move with code.** If behaviour changes, `docs/DOMAIN.md` changes in the same PR.

## 3. Branches and commits

- Branch name: `<task-id>-<short-slug>`, e.g. `d-02-split-calculator`.
- Commits follow Conventional Commits with the task ID as scope:
  - `feat(D-02): allocate remainder to living bucket`
  - `test(D-06): cover amount tolerance boundary`
  - `fix(DA-03): map reversal entries correctly`
  - `docs(PLAN): clarify cooling-off threshold`
  - `chore(F-02): add CI cache`
- Keep commits small and meaningful. Squash-merge PRs.

## 4. Pull requests

Title: `[<task-id>] <what it does>`

The PR description must contain:

```
## Task
<task-id> – <task name from PLAN.md>

## What changed
- …

## How it was tested
- [ ] unit  - [ ] contract  - [ ] widget  - [ ] golden  - [ ] integration
Commands run: …

## Docs updated
- [ ] PROGRESS.md row  - [ ] DOMAIN.md (if rules changed)  - [ ] ARCHITECTURE.md / ADR (if structure or deps changed)

## Screens (UI tasks only)
Screenshots light + dark, side by side with the design canvas frame.

## Agent disclosure
- [ ] Written by a human  - [ ] Written with an AI agent (name: …), reviewed line by line by me
```

### Review checklist (reviewers tick these)

- [ ] Correct layer: no Flutter/plugin imports in `core`/`domain`; no `domain`/`data` imports in `ui_kit`
- [ ] No business logic in widgets, controllers, DAOs or mappers
- [ ] Money uses `Money`/ngwee; percentages use `BasisPoints`
- [ ] Time via `Clock`, IDs via `IdGenerator`
- [ ] Every new rule is in `docs/DOMAIN.md` and has a test
- [ ] Tests cover edge cases; nothing skipped without the fixture reason
- [ ] No new dependency without an approved ADR
- [ ] No personal data in code, fixtures, logs or screenshots
- [ ] UI uses only `ui_kit` components and tokens; strings in ARB; states from `docs/SCREENS.md` implemented
- [ ] `docs/PROGRESS.md` updated

## 5. Working with an AI agent

You, the human, own the result. Agents are fast and confident; they are also wrong in quiet ways, especially about money rounding, time zones, and package APIs.

**Start every agent session with this prompt** (fill in the task):

```
You are working in the Buckets repository.
Follow AGENTS.md strictly. First read, in order: AGENTS.md, docs/PROGRESS.md,
docs/PLAN.md, docs/ARCHITECTURE.md, docs/DOMAIN.md (and docs/COMPONENTS.md,
docs/SCREENS.md, docs/design/* if the task is UI).

Task: <TASK-ID> – <task name>
Before writing code, reply with:
1. The acceptance criteria for this task, in your own words.
2. The files you plan to create or change.
3. The tests you will write first.
4. Any question where DOMAIN.md does not give an answer.
Wait for my "go" before coding.
```

**Then:**

1. Check its plan against `docs/PLAN.md`. Correct it before saying "go".
2. Let it write tests first for domain tasks. Read the tests: they are the spec.
3. Run the commands yourself (`docs/BOOTSTRAP.md` §8). Do not trust "all tests pass" without seeing it.
4. Read every line of the diff. Pay extra attention to: money arithmetic, date/time windows, nullable handling, anything touching permissions or notifications.
5. Ask the agent to update `docs/PROGRESS.md` as its last step.
6. Keep sessions to one task. Start a fresh session for the next task so stale context doesn't leak.

**Never let an agent:** add dependencies on its own, change `AGENTS.md`, open the Logic gate, weaken or delete tests, touch real personal data, or "temporarily" put logic in UI.

## 6. Architecture Decision Records

Any change to layers, folder structure, state management, persistence, a new dependency or a privacy-relevant behaviour needs an ADR:

1. Copy `docs/adr/0000-template.md` to `docs/adr/NNNN-short-title.md`.
2. Fill in context, decision, alternatives, consequences.
3. Link it in the PR. Status `Proposed` until a maintainer marks it `Accepted`.

## 7. Fixtures and personal data

SMS and receipt fixtures are vital and sensitive.

- Replace every name with `[NAME]`, every phone/account number with `[ACCOUNT]`, every transaction reference with a fake of the same length and character pattern (e.g. `AB12CD34EF` → `ZX98YW76VU`), and keep amounts, dates, punctuation and line breaks exactly as received.
- Never commit screenshots that show real balances or names.
- Fixtures live in `packages/domain/test/fixtures/sms/<provider>/<case>.txt` with a sibling `<case>.expected.json`.

## 8. Reporting bugs

Open an issue with: what you did, what you expected, what happened, app version, Android version and device, and (redacted) SMS text if a parser is involved. Label `bug` plus the layer (`domain`, `data`, `app`, `ui_kit`).
