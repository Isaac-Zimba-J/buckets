# Components

The parts every screen is built from. Sizes in px; colours, radii and spacing by token name.

## Buttons

| Kind | Look | Use |
| --- | --- | --- |
| Primary | 54 tall, full width, `action` fill, `on-action` callout 600, `radius-md` | The one main action of a screen |
| Secondary | 48 tall, `surface` fill, 1px `control-border`, `ink` text | Alternatives: Retake, Later, Snooze |
| Text | 44 tall, no fill, `ink` or `info` text 600 | Low-weight actions: Skip, See all |
| Destructive | Secondary with `danger` text | Remove, Delete |
| Icon | 44 × 44, `surface` fill, `shadow-card`, `radius-full` | Back, close, notifications. Needs an aria-label |
| Floating log | 60 × 60, `action` fill, `radius-full`, `shadow-float`, plus icon | Home only, bottom-right above the tab bar |

Disabled: `surface-sunken` fill with `ink-muted` text, plus a caption explaining why.

## Cards

- **Surface card:** `surface`, `radius-lg`, `shadow-card`, `space-4` padding.
- **Hero card:** `hero` fill, `radius-xl`, `space-5` padding, `on-hero` text, `accent` for the key number or progress. Max one per screen.
- **List group:** a surface card whose rows are divided by 1px `line`. Row: 56 min height, headline left, caption below, amount-m right.

## Bucket parts

- **Bucket dot:** 10 × 10 `radius-full` in the bucket colour, left of the bucket name.
- **Split bar:** 12 tall `radius-full`, segments with 3px gaps, widths by percentage, legend underneath. Shows how one income is split.
- **Bucket tile:** surface card with dot + name (caption), balance (amount-m or amount-l), optional 6px progress bar.
- **Progress bar:** 8 tall `surface-sunken` track, fill in bucket colour (on hero: `accent` on a 20% white track).

## Inputs

- **Text field:** label (callout 600, `ink`) above, 52 tall `surface` field, 1px `control-border`, `radius-md`, body text. Focus: 2px `ink` border. Error: 2px `danger` border + caption in `danger` below.
- **Amount field:** amount-xl centred, no border, caption below with the effect ("Living after: K 1,955").
- **Segmented control:** `surface-sunken` track, 4px padding, `radius-md`; selected segment `surface` with `shadow-card` and 600 weight.
- **Chip:** 36 tall `radius-full`. Unselected: `surface` + `control-border`. Selected: `ink` fill, white text.
- **Row picker:** list-group row with label left, value right and a chevron.

## Feedback

- **Banner:** tint fill (`positive-tint`, `warning-tint`, `danger-tint`, `info-tint`), `radius-md`, 20px icon, callout text in the matching signal colour. Errors use `role="alert"`.
- **Toast:** `ink` fill, white callout, `radius-full`, `shadow-float`, floats 16px above the bottom action area, 3 seconds, optional Undo.
- **Bottom sheet:** `surface`, `radius-xl` top corners, `shadow-sheet`, 36 × 5 grabber, `scrim` behind. Title in title-2.
- **Skeleton:** `surface-sunken` blocks in the shape of the content, `radius-sm`.
- **Badge:** 24 tall pill in a tint with caption 600 text: "Proven", "Needs proof", "Over".

## Navigation

- **Top bar:** 44 icon button left, optional centred headline, optional 44 action right. On flows, a step label ("2 of 5") centred and a thin progress bar beneath.
- **Tab bar:** 76 tall `surface` with a 1px `line` top; four tabs Home, Goals, Plan, Me; active tab `ink` 600 with filled icon, others `ink-muted`.
