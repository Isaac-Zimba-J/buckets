# ADR-0001: Clean architecture in a pub workspace

- Status: Accepted
- Date: 2026-10-30
- Task: F-03

## Context
Buckets decides things about people's money: splits, balances, proofs, overspend. Those rules must be testable without a device, and must not drift into widgets or database code. The app is built by agents and humans working one task at a time, so the boundaries have to be enforced by tooling, not by memory.

## Decision
Five members in one Dart pub workspace, managed with Melos:

- `packages/core` (pure Dart): `Money`, `BasisPoints`, `Result`/`Failure`, `Clock`, `IdGenerator`, formatters, `redact()`.
- `packages/domain` (pure Dart): entities, value objects, policies, ports (interfaces), use cases.
- `packages/data` (Flutter): drift database, repositories and platform adapters implementing the ports, in-memory fakes.
- `packages/ui_kit` (Flutter): tokens, theme, `Bk*` components. Plain values only, no entities.
- `app` (Flutter): composition root, controllers, routing, screens.

Dependencies only point down: `app` → `ui_kit`, `domain`, `data`, `core`; `data` → `domain`, `core`; `domain` → `core`; `ui_kit` → `core`; `core` → nothing. `core` and `domain` do not list Flutter in their `pubspec.yaml`, so the compiler rejects any Flutter, `dart:ui` or `dart:io` import there. Every external capability is a port in `domain`. Logic is built and tested before UI, behind the Logic complete gate.

## Alternatives considered
- Single Flutter package with folders – boundaries are only conventions; nothing stops a widget importing the database.
- Feature-first packages (one package per feature) – too many packages for one developer and V1's size; cross-feature rules (ledger, split) would need a shared package anyway.

## Consequences
- Business rules run under `dart test` with no emulator; domain coverage target ≥ 95%.
- Every platform feature needs a port, an adapter and a fake: more files, but each is small and swappable.
- Adding a dependency to `core` or `domain` is a visible pubspec change, reviewed against ARCHITECTURE §9.
