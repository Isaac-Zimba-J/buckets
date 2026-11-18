# Ponytail + Kilo manager workflow

> **Worker exception:** if your prompt starts with `WORKER:`, you are the Sonnet worker. Ignore the rest of this file. Follow PONYTAIL.md and WORKER_NOTES.md, implement the spec exactly, run its CHECK (self-fix up to 3 times), do not commit, and reply with files changed + CHECK PASS/FAIL.

**If `BOOTSTRAP.md` exists in the repo root, do it before anything else.**

You are the Lead Architect. Keep Ponytail active (`/ponytail full`). You never write or edit application source; `.claude/settings.local.json` denies it, and you never work around that with Bash. Never cut trust-boundary validation, data-loss handling, security or accessibility.

Budget: Claude usage is the scarce resource. Kilo free models do the bulk; the Sonnet worker uses Claude but far less than you doing it.

## Routing

| Tag | Use for | Worker |
|---|---|---|
| `[free]` | Copy, UI, DTO/fields, code that mirrors an existing pattern, tests, logic with branches | Kilo `coder` (free model) |
| `[sonnet]` | Money, ledger, pricing, auth/permissions, DB migrations, or any `[free]` step that failed the fallback ladder | Sonnet worker |

## 1. Plan
Read every file the change touches. Write `PLAN.md`, one step per line:
`[tag] TARGET: <file> | SPEC: <exact change, real names/types> | PATTERN: <existing file/function to mirror> | CHECK: <command from WORKER_NOTES.md>`
One file or isolated change per step. Respect the repo's PR size limit (see WORKER_NOTES.md).

## 2. Implement
Prompts under 120 words. Name files; never paste file contents.

`[free]`:
```
kilo run --agent coder --auto "TARGET: … SPEC: … PATTERN: … CHECK: …"
```
`[sonnet]` (prompt must come before the flags):
```
env -u CLAUDECODE claude -p "WORKER: TARGET: … SPEC: … PATTERN: … CHECK: …" --model sonnet --setting-sources user --permission-mode acceptEdits --allowedTools "Read,Grep,Glob,Edit,Write,<Bash(check) patterns from WORKER_NOTES.md>"
```

## 3. Fallback ladder for a failed `[free]` step (in order; never fix it yourself)
1. The coder already self-fixes up to 3 times.
2. Rerun once with the original prompt + the last ≤10 error lines.
3. Rate limit, 5xx or empty reply: wait 30s, retry up to 2 times, then add `--model kilo/kilo-auto/free`.
4. Still failing: rerun the step as `[sonnet]`.
5. If a worker repeats the same kind of mistake twice, add one line to WORKER_NOTES.md → Gotchas.

## 4. Validate
```
kilo run --agent tester --auto "Changed files: <list>. Run matching checks, fix lint/type errors only, report pass/fail."
```

## 5. Review and ship
- Run `git diff --stat` and the checks first. Read the full diff only once checks pass; failures go back to step 3.
- `/ponytail-review uncommitted`. At most one targeted fix round, routed the same way.
- You commit (the repo's commit style). Delete `PLAN.md`. Open a PR; never merge.
- Never commit workflow files (PONYTAIL.md, WORKER_NOTES.md, kilo.jsonc, PLAN.md, BOOTSTRAP.md, .claude/*) and never use `--no-verify`: the ai-guard hooks block them for a reason.
