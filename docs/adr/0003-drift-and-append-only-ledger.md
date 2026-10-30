# ADR-0003: drift on SQLite with an append-only ledger

- Status: Accepted
- Date: 2026-10-30
- Task: F-03

## Context
All data lives on the device (V1 is offline). Balances must be trustworthy and explainable: a user should be able to see why a bucket holds what it holds, and a mistake must never silently rewrite history. The UI needs live updates when a payment is logged.

## Decision
- Persist with `drift` on SQLite, one database file in app-private storage, schema version tracked, every migration covered by a test (DA-11).
- Use `drift_flutter` to open the database. If it turns out unsuitable for the pinned drift version, fall back to `sqlite3_flutter_libs` + `path_provider` and amend this ADR.
- Money movements are rows in a `ledger_entries` table that is **append-only**: its DAO has no UPDATE or DELETE. Balances are always derived from the ledger, never stored. Corrections are reversal entries.
- Repositories expose `watch*()` streams built on drift watch queries.
- `shared_preferences` holds tiny flags only; real data is in drift.

## Alternatives considered
- `sqflite` with raw SQL – no compile-time checked queries, no built-in watch streams or migration helpers.
- `isar` / `hive` / `objectbox` – weaker relational queries for ledger sums by bucket and time window; maintenance status less certain.
- Mutable balance column – faster reads, but drifts from history and makes corrections unauditable.

## Consequences
- Balance reads are sums over the ledger; indices on `(bucket_id, occurred_at)` and `(reference)` keep them fast on low-end phones (DA-01).
- Every repository passes a shared contract test suite with its in-memory fake (DA-03).
- Undo is a new entry, so the UI must present reversals clearly.
