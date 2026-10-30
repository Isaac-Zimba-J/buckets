# API backend plan (future: Version 3 and later)

**Status: planning only.** Nothing in this document is built in V1 or V2. V1 makes no network calls (AGENTS.md §4). This plan exists so the V1 architecture doesn't block a backend later, and so data is collected only in ways people clearly agree to.

## 1. Why a backend at all

1. **Backup and multi-device sync** for people who want it.
2. **Opt-in insights:** learn from consented, anonymized patterns to give better suggestions (split sizes that work, early overspend warnings, realistic goal timelines).
3. **Model delivery:** ship improved on-device models (categorization, parsing templates) as updates.

The app must stay fully useful without an account, forever.

## 2. Principles

- **Local-first.** The phone is the source of truth. The server is optional.
- **Consent per purpose.** Separate, revocable toggles: (a) encrypted backup, (b) anonymous insights, (c) model improvement. Default off. Plain-language explanation before each.
- **Minimise.** Collect the least data that answers a defined question. Every field in an event schema needs a written purpose.
- **Never collect** raw SMS/notification text, names, phone or account numbers, merchant names, receipt images, exact GPS location, or contacts.
- **Aggregate before learning.** Insights use banded and aggregated values; small groups are suppressed.
- **Right to leave.** Export everything, delete account and all server data, withdraw consent at any time, with effect within 30 days at most.
- **Law first.** Comply with Zambia's Data Protection Act (No. 3 of 2021) and any registration duties with the Office of the Data Protection Commissioner, plus the rules of every other country the app is offered in. Get legal advice before launch; this document is not legal advice.

## 3. Data tiers

| Tier | What | Where it may go |
| --- | --- | --- |
| 0 – Device only | raw messages, names, account numbers, merchant names, receipt images, notes | never leaves the phone |
| 1 – Encrypted backup | the full database, encrypted on the device with a key the server never sees | server stores ciphertext only |
| 2 – Anonymous insights (opt-in) | banded, derived metrics, e.g. split percentages, savings rate band, proof completion time band, category share of spending, overspend frequency | server, linked to a random rotating ID, not to the account |
| 3 – Model improvement (opt-in) | user-confirmed corrections to categories/parsing as normalized features (no merchant names; hashed merchant key salted per device) | server, for training; deletable |

## 4. Architecture sketch

```
Phone (Flutter)
  domain ports: SyncGateway, InsightsGateway, ConsentRepository  ← added in V3
  data: HttpSyncGateway, HttpInsightsGateway (only package allowed to use HTTP)
        ↓ HTTPS (TLS 1.2+), certificate pinning
API (stateless service)
  /v1/auth        phone-number OTP → short-lived access + refresh tokens
  /v1/backup      PUT/GET encrypted blob + metadata (size, schema version, created_at)
  /v1/consent     GET/PUT consent record per purpose (versioned text hash, timestamp)
  /v1/insights    POST batched Tier-2 events (anonymous ID, no auth link)
  /v1/models      GET signed on-device model + parser template bundles
  /v1/account     export, delete
Storage
  Postgres: accounts, consents, backup metadata
  Object storage: encrypted backup blobs, model bundles
  Analytics store (separate project/database): Tier-2 events only, retention-limited
Jobs
  aggregation with k-anonymity threshold (e.g. groups < 50 suppressed)
  training pipeline reading only Tier 3 + aggregates
```

Technology is decided by ADR at the time. Reasonable options: a Dart backend (Dart Frog or Serverpod) to share `core`/`domain` value types, or a mainstream stack (Go, TypeScript) with an OpenAPI contract and generated Dart client. Host where latency to Zambia is reasonable and where the data-protection requirements are met.

## 5. API contract rules

- OpenAPI 3 spec in `api/openapi.yaml`, versioned under `/v1`; the Dart client is generated from it.
- All money in ngwee integers; percentages in basis points; times ISO-8601 UTC.
- Idempotency keys on every POST/PUT; uploads resumable for weak connections; batch insights and send only on Wi-Fi or when the user allows mobile data.
- Rate limiting, audit logs for account-level actions, no PII in logs.

## 6. Insight event example (Tier 2)

```json
{
  "schema": "cycle_summary.v1",
  "anon_id": "r-7f3a…",           
  "cycle_month": "2027-03",
  "income_band": "10k-15k",
  "income_sources": 2,
  "split_bp": {"living": 4000, "guiltFree": 1000, "emergency": 1000, "shortTerm": 1000, "longTerm": 2000, "goal": 1000},
  "proof_completion_hours_band": "0-2",
  "transfers_proven_ratio_band": "100",
  "overspent_buckets": ["living"],
  "untracked_cash_band": "0-50",
  "app_version": "3.0.0"
}
```

Each field has a purpose recorded next to the schema (e.g. `split_bp` → learn which splits people sustain for 3+ cycles).

## 7. Models later (Version 4)

Candidate models, preferring on-device inference:

1. **Categorizer:** predicts category and bucket for a new payment from normalized features. Trained on Tier-3 corrections; runs on the phone.
2. **Parser template updates:** new message formats learned from users who opt in to share **redacted structure only** (token shapes, not content), reviewed by a human before shipping as signed templates.
3. **Split coach:** suggests a split based on what similar income bands sustain, from Tier-2 aggregates.
4. **Overspend early warning:** predicts a likely overspend 7 days ahead from your own on-device history; the server only supplies a general model.

Every model ships with: a model card (data, purpose, limits), an evaluation on held-out data, a fairness check across income bands, and a kill switch.

## 8. What V1 must do now so this is possible later

- Keep all domain logic in `domain` with ports: a future `SyncGateway` is just another port.
- Keep the ledger append-only with stable IDs (UUIDs) so sync can merge without conflicts.
- Store a `schemaVersion` and keep migrations tested.
- Keep event-worthy facts derivable from local data (no need to log analytics now).
- Do not add any network code, SDK or identifier before V3 and its ADRs.
