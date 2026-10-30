# Component system (ui_kit)

`packages/ui_kit` is the Flutter version of the Buckets design system (`docs/design/`). Every pixel the app draws comes from here. Feature screens compose these components; they never style things themselves.

Built in Phase 4, after the Logic complete gate. Only the token generator (F-05) exists earlier.

## 1. Rules

1. **Tokens only.** Colors, text styles, spacing, radii and shadows come from generated tokens via the theme. No `Color(0x…)`, `EdgeInsets.all(13)` or `TextStyle(fontSize: …)` outside `ui_kit/lib/src/tokens/`.
2. **No domain.** Components never import `domain`, `data` or `app`. They take plain inputs: `String`, `int`, `bool`, enums defined in `ui_kit`, `VoidCallback`, `ValueChanged<T>`.
3. **Money as text.** Components receive already-formatted strings (`'K 1,540'`) or use `BkMoneyText(ngwee: 154000)` which formats with `core`'s `MoneyFormatter`. `core` is the one package `ui_kit` may import.
4. **Stateless where possible.** State lives in controllers. Components with ephemeral visual state (pressed, focus) keep it internal.
5. **Accessible by default.** Minimum 44×44 hit area; `Semantics` labels required for icon-only widgets (a required constructor argument); text scales to 1.3 without clipping; contrast per token notes.
6. **Both themes.** Every component works in light and dark; goldens prove it.
7. **One component per file**, named `bk_<name>.dart`, exported from `ui_kit.dart`.
8. **Every component has:** dartdoc with a usage example, a widget test, golden tests (light/dark, each state), and a gallery page.

## 2. Tokens → Dart

`tool/gen_tokens.dart` reads `docs/design/tokens.json` and generates:

| File | Contents |
| --- | --- |
| `bk_colors.g.dart` | `BkColors extends ThemeExtension<BkColors>` with one field per color token (`bg`, `surface`, `ink`, `inkMuted`, `accent`, `action`, `positive`, `positiveTint`, …, `bucketLiving`, `bucketFun`, …), `BkColors.light` and `BkColors.dark`, `lerp`. |
| `bk_typography.g.dart` | `BkTypography` with `display`, `title1`, `title2`, `headline`, `body`, `callout`, `caption`, `overline`, `amountXl`, `amountL`, `amountM`, `reference`; amounts include `FontFeature.tabularFigures()`. |
| `bk_spacing.g.dart` | `BkSpacing.s1 = 4` … `s8 = 32`. |
| `bk_radius.g.dart` | `BkRadius.sm/md/lg/xl/full`. |
| `bk_shadows.g.dart` | `BkShadows.card/sheet/float` as `List<BoxShadow>`. |

Token names map kebab → camel (`bucket-fun` → `bucketFun`). The font is Geist (bundled as asset files, not fetched at runtime, because V1 makes no network calls), with Geist Mono for references.

Access in widgets: `context.bk.colors.ink`, `context.bk.type.body`, `BkSpacing.s4`.

Bucket colours are exposed through an enum so features never pick hex values:

```dart
enum BkBucketColor { living, fun, emergency, short, long, goal, family, business }
// BkBucketColor.living.resolve(context) → Color from BkColors
```

The app maps domain `BucketKind` → `BkBucketColor` in the controller's view-model mapper.

## 3. Catalog

Specs (sizes, fills, states) are in `docs/design/COMPONENT_SPECS.md`. The Flutter names and APIs:

### Actions
| Component | Key API | States |
| --- | --- | --- |
| `BkButton.primary/secondary/text/destructive` | `label`, `onPressed`, `icon?`, `loading` | enabled, pressed, disabled (+ `disabledReason` caption), loading |
| `BkIconButton` | `icon`, `semanticLabel` (required), `onPressed`, `variant` (surface, onHero, onDark) | enabled, pressed, disabled |
| `BkFab` | `semanticLabel`, `onPressed` | enabled, pressed |

### Inputs
| Component | Key API | States |
| --- | --- | --- |
| `BkTextField` | `label`, `value`, `onChanged`, `hint`, `errorText`, `keyboardType` | idle, focused, error, disabled |
| `BkAmountField` | `ngwee`, `onChanged`, `effectCaption` | idle, focused, error |
| `BkSegmented<T>` | `options` (label, icon?), `selected`, `onChanged` | per option selected / not |
| `BkChip` / `BkChipGroup<T>` | `label`, `selected`, `leadingDot?` | selected, unselected, disabled |
| `BkBucketChips` | `options` (label, `BkBucketColor`), `selected`, `trailingCaption` | – |
| `BkToggleRow` | `title`, `subtitle`, `value`, `onChanged`, `leadingIcon` | on, off, disabled |
| `BkCheckRow` | `title`, `subtitle`, `checked`, `trailing` | checked, unchecked |
| `BkRadioCard` | `title`, `subtitle`, `selected`, `onTap` | selected, unselected |
| `BkRowPicker` | `label`, `value`, `leadingDot?`, `onTap` | – |
| `BkSmsField` | `value`, `onPaste`, `error` | idle, error |

### Containers and feedback
| Component | Key API | Notes |
| --- | --- | --- |
| `BkCard` | `child`, `padding` | surface + card shadow, radius lg |
| `BkHeroCard` | `child` | one per screen; dark fill, radius xl |
| `BkListGroup` / `BkListRow` | `title`, `subtitle`, `leading`, `trailing`, `chevron`, `onTap` | rows divided by hairlines |
| `BkBanner` | `kind` (positive, warning, danger, info), `title?`, `message` | danger has `liveRegion` |
| `BkToast` (+ `showBkToast(context, …)`) | `message`, `actionLabel?`, `onAction?` | 3 s, above bottom actions |
| `BkBadge` | `label`, `kind` (positive, warning, danger, info, neutral) | 24 px pill |
| `BkBottomSheet` (+ `showBkSheet`) | `title`, `child`, `actions` | grabber, scrim |
| `BkSkeleton` | `width`, `height`, `radius` | shimmer-free (static) to save battery |
| `BkEmptyState` | `icon`, `title`, `message`, `actionLabel`, `onAction` | |
| `BkBottomActions` | `children` | pinned area with 32 px bottom inset |

### Money widgets
| Component | Key API |
| --- | --- |
| `BkMoneyText` | `ngwee`, `style` (amountXl/L/M), `showSign`, `showNgwee` |
| `BkBucketDot` | `color: BkBucketColor`, `size` |
| `BkSplitBar` | `segments: List<(BkBucketColor, int bp)>`, `height`, `onHero` |
| `BkBucketTile` | `label`, `color`, `amountText`, `progress?`, `caption?`, `onTap?` |
| `BkProgressBar` | `value 0–1`, `color`, `onHero` |
| `BkProgressRing` | `value`, `centerLabel`, `color` |
| `BkTransferRow` | `bucketLabel`, `color`, `amountText`, `destination`, `status` (pending, proven, partial, selfReported), `onProve` |
| `BkProofCheckRow` | `label`, `value`, `result` (passed, failed, unknown) |
| `BkStepList` | `steps: (title, subtitle, state: done/active/todo)` |

### Navigation
| Component | Key API |
| --- | --- |
| `BkTopBar` | `leading` (back/close), `title?`, `trailing?` |
| `BkFlowHeader` | `step`, `total`, `onBack` |
| `BkGreetingHeader` | `greeting`, `title`, `hasUnread`, `onNotifications` |
| `BkTabBar` | `items` (label, icon), `currentIndex`, `onTap` |

## 4. Gallery

`packages/ui_kit/gallery` is a small Flutter app (or Widgetbook, decided by ADR in UI-07) listing every component with every state in light and dark. Reviewers check new components here against the design canvas before screens use them.

## 5. Composing screens

Feature widgets in `app/lib/features/<feature>/presentation/widgets/` may combine `ui_kit` components into larger pieces (e.g. `HomeBucketGrid`) but may not add new visual styles. If a screen needs something the kit doesn't have, add it to `ui_kit` first (with tests and gallery), in its own PR.
