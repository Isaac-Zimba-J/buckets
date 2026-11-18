# Handover: bug-fix batch (notifications, SMS, bills, to-buy, Home recent)

Started 2026-11-18. Branch: `fix/notifications-sms-bills`. Nothing in this batch is implemented yet;
the root causes are traced and the fix specs are written in `PLAN.md` (repo root, NOT `docs/PLAN.md`).

## Reported issues -> root cause

| Issue | Root cause | PLAN.md step |
|---|---|---|
| Notifications keep firing, even after tapping | Every re-plan (`NotificationSync`, also on app resume) calls `show()` again for anything already due. Tapping opens the app -> resume -> re-plan -> shown again. Payday alarm slots are anchored to `now`, so IDs/times shift every run. | 1 (policy), 2 (scheduler) |
| SMS auto-sense / logging does nothing | `AlertConfig.kt` allow-lists only the MoMo/Airtel apps, no SMS apps. Listener queues `title\nbody`, but every template is `^`-anchored on the body. Ingest only runs on start/resume. | 3, 4, 5 |
| Bills only show at month end | Before the first payday the cycle is `[setup, first payday)`, so bills due earlier in the month get no occurrence. Owner approved: show them now, overdue if their date passed. | 6 |
| To-buy needs a bin icon | No delete exists at any layer. | 7, 8, 9 |
| Recent transactions missing on Home | The first-run Home state (before first payday) has no recent list. | 10 |

## Status

- Workflow bootstrap done: `WORKER_NOTES.md` and `kilo.jsonc` command allowlists filled in for this repo.
  `BOOTSTRAP.md` can be deleted (it was blocked from deleting during the session).
- No step implemented. Blockers hit:
  - Kilo free models: "Too Many Requests: Free model usage limit reached" (both default and `kilo/kilo-auto/free`).
  - Sonnet worker (`env -u CLAUDECODE claude -p ...`) was refused by Claude Code auto mode; `claude` was also not on the
    non-interactive shell PATH, so the allow rule in `.claude/settings.local.json` never matched.
- First Kilo attempt read `docs/PLAN.md` by mistake; prompts must say "./PLAN.md in the repo root (NOT docs/PLAN.md)".

## How to continue on another PC

1. `git checkout fix/notifications-sms-bills`
2. Flutter 3.47.9 via fvm (`.fvmrc`); `dart pub global activate melos 8.10.0`; `dart pub get`.
3. Ensure `kilo` (pnpm global) and `claude` are on PATH for non-interactive shells.
4. Run steps in order, one at a time (rate limits): 3, 5, 7, 8, then 1, 2, 4, 6, then 9, 10. Example:
   `kilo run --agent coder --auto "Open ./PLAN.md in the repo root (NOT docs/PLAN.md) and do numbered step 3 of it exactly. Touch only that step's files. Do not commit."`
5. Validate: `dart pub global run melos run gen`, `melos run format`, `melos run analyze`, `melos run test`.
6. Kotlin steps (3, 5) have no automated check: build and test on a phone. Grant notification access, send yourself
   an MTN/Airtel SMS, confirm it lands in "To sort" while the app is open, tap a notification and confirm it does not return.
7. After step 6: update `docs/DOMAIN.md` R-BILL-6 (first cycle looks back to the previous expected payday).

## Notes

- `app/lib/main.dart` splash animation work is committed in this branch alongside these notes.
- AI workflow files (PONYTAIL.md, WORKER_NOTES.md, PLAN.md, kilo.jsonc, BOOTSTRAP.md, .claude/*) were committed once
  on purpose with `--no-verify` at the owner's request. Remove them from the branch before opening a PR to main.
