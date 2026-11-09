# ADR-0005: Component gallery and golden tests without extra packages

- Status: Accepted
- Date: 2026-11-09
- Task: UI-07

## Context
COMPONENTS.md §4 asks for a gallery that shows every `ui_kit` component in every state, in light and dark. ARCHITECTURE §9 lists `widgetbook` (optional) for the gallery, and "`alchemist` or a `golden_toolkit` successor (choose one via ADR)" for golden tests. UI-01 to UI-06 already have light and dark goldens built with `flutter_test`'s `matchesGoldenFile`.

The goldens are recorded on macOS but checked on Linux CI, where antialiasing differs slightly (about 2% of pixels). UI-01's first CI run failed on exactly this.

## Decision
- **Gallery:** a plain Flutter app at `packages/ui_kit/gallery`, with no Widgetbook. Its pages come from `package:buckets_ui_kit/gallery.dart`, a separate library that is not part of the main barrel, so the app never ships it. There is one page per group: foundation, actions, inputs, containers, feedback, money widgets and navigation. A switch flips light, dark or system theme.
- **Goldens:** stay on `flutter_test`'s `matchesGoldenFile`, rendering **the same gallery pages** in both themes. Gallery and goldens therefore cannot drift apart.
- **Cross-platform diffs:** `test/flutter_test_config.dart` installs a comparator that accepts up to a 3% pixel diff.

## Alternatives considered
- **Widgetbook:** a richer catalogue (knobs, device frames), but a new dependency with generated code for 30-odd components. Not needed while one person reviews the kit.
- **alchemist:** CI-safe goldens with blocked-out text, but a new dependency and a second set of golden files. The 3% tolerance covers the platform difference we actually see.
- **Recording goldens on CI only:** exact, but every golden change needs a CI round trip to update. Possible later if the tolerance ever hides a real regression.

## Consequences
- No new packages. Golden tests and the gallery share their sample pages, so a new component needs one gallery page entry and gets its goldens automatically.
- The 3% tolerance can hide very small visual changes, such as a 1px shift in a large image. Reviewers still check the gallery by eye. Revisit if that happens.
- `packages/ui_kit/gallery` is a workspace member. It has a smoke test that every page builds in both themes.
