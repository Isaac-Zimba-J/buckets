# ADR-0004: No network access in V1

- Status: Accepted
- Date: 2026-10-30
- Task: F-03

## Context
Buckets reads payment alerts, account numbers, merchant names and receipt photos. Users in Zambia often have expensive or unreliable data. Trust is the product: people will only let an app read their mobile money alerts if nothing leaves the phone.

## Decision
V1 makes zero network calls.

- No `http`, `dio`, Firebase, analytics, crash reporting, remote config or any SDK that phones home.
- OCR is on-device (`google_mlkit_text_recognition`); fonts are bundled, not fetched.
- R-01 checks the merged release manifest for network permissions that plugins add, and removes any that are not needed.
- Raw alert text, account numbers, merchant names and receipt images never appear in logs; log lines pass through `redact()`.
- Backups (V1.1) are a user-held encrypted file, not a server.

Any later network feature follows `docs/API_PLAN.md` and needs a new ADR that supersedes this one.

## Alternatives considered
- Crash reporting only – useful, but it still sends device and stack data off the phone, and many SDKs collect more than crashes.
- Opt-in analytics – adds consent screens and a backend before the core habit loop is proven.

## Consequences
- Bugs are found by dogfooding and tests, not telemetry (R-03).
- Every new dependency is checked for network use before approval.
- Parser updates ship only with app updates in V1.
