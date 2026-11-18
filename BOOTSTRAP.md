# One-time bootstrap

Calibrate this workflow to this repo, then delete this file. Edit only the files `init-ai` added (listed in `.git/info/exclude`); never touch tracked team files.

1. **Inspect** (read-only): top-level tree to depth 2; package manager and lockfile; manifests and their scripts (package.json, pyproject, go.mod, pubspec.yaml, Cargo.toml, Makefile); CI workflows; any AGENTS.md / CONTRIBUTING.md rules (PR size, commit style, checks).
2. **WORKER_NOTES.md**: replace each TODO. Repo shape in ≤6 lines; one exact check command per area (type-check/lint) and the test command; code rules from the repo's docs (commit style, PR size limit); known gotchas. Under 60 lines.
3. **kilo.jsonc**: replace both workers' `bash` allow lists with exactly those commands (prefix + `*`). Keep `"*": "deny"` first. Tester also keeps `git status*` and `git diff*`.
4. **.claude/settings.local.json**: `deny` Edit and Write for every source and test directory you found (cwd-relative globs, e.g. `Edit(apps/**)`); keep docs and `PLAN.md` editable. Drop default entries for directories that don't exist.
5. **.claude/CLAUDE.md**: nothing to change unless the repo needs an extra routing rule; the Sonnet worker's Bash patterns come from WORKER_NOTES.md.
6. **Smoke test**: `kilo run --agent coder --auto "Reply with the CHECK commands you are allowed to run. Do not edit anything."` and confirm it lists the right commands.
7. Delete `BOOTSTRAP.md` and report what you set, in ≤8 lines.
