# Buckets

Give every kwacha a job.

Buckets is an offline-first Android app (Flutter) that splits every payday into buckets (Living, Guilt-free, Emergency, Short-term, Long-term and goals), sounds an alarm until savings are actually moved and proven with the confirmation SMS, and tracks spending from MTN MoMo and Airtel Money alerts, cash and scanned receipts. "Buckets" is a working name.

## Start here

| If you are… | Read |
| --- | --- |
| An AI coding agent | `AGENTS.md` first, then follow its reading order |
| A contributor or agent driver | `CONTRIBUTING.md` |
| Setting up the repo | `docs/BOOTSTRAP.md` |

## Documentation map

| File | What it is |
| --- | --- |
| `AGENTS.md` | Strict rules for AI agents |
| `CONTRIBUTING.md` | How to contribute, PR rules, how to drive an agent |
| `docs/ARCHITECTURE.md` | Layers, folders, dependency rules, approved packages |
| `docs/DOMAIN.md` | Every business rule (source of truth for logic) |
| `docs/PLAN.md` | Versions 1 → 4, phases and tasks with acceptance criteria |
| `docs/PROGRESS.md` | Live status of every task, the Logic complete gate, open questions |
| `docs/SCREENS.md` | Each design screen → route, controller, use cases, states |
| `docs/COMPONENTS.md` | The Flutter component system (ui_kit) |
| `docs/BOOTSTRAP.md` | Commands to create the workspace now |
| `docs/API_PLAN.md` | Future, consent-first backend plan (not built in V1) |
| `docs/design/` | Design tokens and design system docs |
| `docs/adr/` | Architecture decision records |

## How we build

1. Foundations → 2. Domain → 3. Data → 4. Application state → **Logic complete gate** → 5. UI kit → 6. Screens → 7. Release.

No UI until the logic is planned, built and tested.

## Design

- Design canvas (23 screens): https://claude.ai/artifact/HNvV5sC6BSaUV1ueLPuZDC
- Design system: https://claude.ai/artifact/EkymUKUmHTX2mkWngY2SVY

These links are private until the owner shares them. Agents use the offline copies in `docs/design/` and exported screen images in `docs/design/screens/`.
