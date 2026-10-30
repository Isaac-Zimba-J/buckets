# ADR-0002: Riverpod for state and DI, go_router for navigation

- Status: Accepted
- Date: 2026-10-30
- Task: F-03

## Context
The app needs one place that wires ports to implementations (with overrides for tests and a demo mode), screen controllers with explicit loading/empty/ready/error states, live updates from database streams, and deep links from notifications (`buckets://payday/<id>` and friends).

## Decision
- `flutter_riverpod` with code generation (`riverpod_annotation`, `riverpod_generator`) for dependency injection and screen state. Ports and use cases are `@riverpod` providers (keepAlive for the database and ports); each screen has one `Notifier`/`AsyncNotifier` with a `freezed` state union.
- `go_router` for routes, guards (no setup → `/welcome`) and deep links. Routes are declared once in `app/lib/routing/routes.dart`.

## Alternatives considered
- `provider` + `ChangeNotifier` – no compile-time safety for overrides; testing without widgets is awkward.
- `bloc` – more boilerplate per screen, and still needs a separate DI solution.
- `get_it` for DI – a global service locator; overrides per test are manual and easy to leak.
- Navigator 2.0 by hand – deep links and guards would be custom code to maintain.

## Consequences
- Controllers are tested with a `ProviderContainer` and fake overrides, no widgets needed (AP-02, AP-04).
- Code generation (`build_runner`) is part of the workflow; CI fails if generated files are stale.
- Both packages are on the approved list (ARCHITECTURE §9); versions are pinned when added in AP-01/AP-03.
