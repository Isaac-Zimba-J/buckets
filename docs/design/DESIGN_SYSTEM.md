# Buckets

Give every kwacha a job.

Buckets is a personal money app for people paid in Zambian kwacha through a bank, MTN MoMo or Airtel Money. On every payday it splits income into buckets (Living, Guilt-free, Emergency, Short-term, Long-term, Goals), reminds the user to physically move the savings, asks for proof that they did, and tracks spending from mobile money alerts, cash entries and scanned receipts. "Buckets" is a working name.

This system is the single source for anyone, human or AI, designing or building screens for the app. Read this page first, then `writing.md` (words and numbers), `components.md` (parts) and `patterns.md` (flows, states, notifications).

## Rules for AI agents building with this system

1. Use only colours from `tokens.json`. Refer to them by token name in code (`var(--positive)`), never invent a hex.
2. Every amount follows the money format in `writing.md`. No exceptions in mockups either.
3. One primary button (`action` fill) per screen. Everything else is secondary or text.
4. Bucket colours always appear with the bucket's name. Colour alone never carries meaning.
5. Each screen designs all of its states: normal, empty, loading, error, and success where an action completes (see `patterns.md`).
6. Phone first: 390 × 844 frame, 20px side margins (`space-5`), content never under 44px touch targets.
7. Do not add features outside version 1 (listed below) without being asked.
8. Never shame the user. Copy rules in `writing.md` apply to every string, including notifications and errors.

## Principles

**Decide before you spend.** Money is split the moment it arrives. The app's loudest moment is payday, not the month-end report.

**Enjoy some of it.** Every salary sets aside Guilt-free money (10% by default). Spending it never triggers a warning; it is the reward that makes the saving stick.

**Make the right move the easy move.** Saving takes two taps and a pasted SMS. Raiding savings takes deliberate steps.

**Honest, not harsh.** Overspending is shown plainly with a way forward, never in red capitals.

**Works offline, costs no data.** Nothing on screen depends on a connection. Network-only features say so.

## Version 1 scope

Income sources with their own splits (salary and side hustles), fixed bills taken off the top, six default buckets plus goals, where each bucket's money lives, the payday transfer checklist with proof, logging spending (MoMo alert, cash, receipt scan), planned purchases with a 48-hour cooling-off list, a weekly check-in with cash count, and overspent handling. Not in V1: bank connections, cloud sync, investing, shared budgets, charts beyond progress bars.

## Colour

Neutral first. The app is mostly `bg`, `surface` and `ink`; colour is spent on money meaning.

- **Grounds:** screens are `bg`; cards and list groups are `surface` lifted with `shadow-card` and no border. Inputs are `surface` with a 1px `control-border`.
- **Hero:** at most one `hero` card per screen (the balance on Home, the payday alarm). Inside it, `accent` lime marks progress and the key number. Lime never appears on light grounds.
- **Actions:** the primary button is `action` with `on-action` text. Secondary buttons are `surface` with `control-border`.
- **Signals:** `positive` for money in and proven transfers, `warning` for "please check", `danger` only for overspent and failed proof. Each has a `-tint` background for banners.
- **Buckets:** `bucket-living`, `bucket-fun` (Guilt-free), `bucket-emergency`, `bucket-short`, `bucket-long`, `bucket-goal`, `bucket-family`, `bucket-business`. Used as 10px dots, split-bar segments and progress fills, always beside the bucket name.

## Typography

One family, Geist (Google Fonts), with Geist Mono only for transaction references. All amounts use tabular figures (`font-variant-numeric: tabular-nums`) so columns line up.

| Style | Use |
| --- | --- |
| display 36/40 | Welcome and celebration headlines only |
| title-1 28/34 | Screen titles |
| title-2 20/26 | Sheet titles, section heads on long screens |
| headline 16/22 | Card titles, list-row primary text |
| body 15/22 | Paragraphs, inputs |
| callout 14/20 | Buttons, chips, banners |
| caption 12/16 | Metadata under rows, helper text |
| overline 11/14 caps | Group labels above lists |
| amount-xl 44/48 | The single most important number on a screen |
| amount-l 28/32 | Card balances |
| amount-m 17/22 | Row amounts |

Sentence case everywhere. Overline is the only all-caps style.

## Layout

A 390px phone frame with 20px side margins and an 8px rhythm (`space-*`). Screens stack: top bar (44px buttons), title, content sections 24px apart, and a bottom action area pinned above the home indicator with 32px below it. Tab screens (Home, Goals, Plan, Me) have a 76px bottom bar; flows (setup, payday, logging) never show the tab bar.

Radii are soft: `radius-md` for controls, `radius-lg` for cards, `radius-xl` for the hero card and sheets, `radius-full` for pills, chips and progress bars.

## Iconography

Outline icons on a 24px grid, 1.75px stroke, round caps and joins, coloured with the text they sit beside. Icons support labels; the only icon-only buttons are back, close, notifications and the floating log button, each with an accessible label. No emoji, no illustrations of people or money.

## Accessibility

Text meets 4.5:1 on its ground in both themes; `ink-muted` is the lightest allowed text colour. Controls are real buttons, links and inputs with labels. Touch targets are at least 44 × 44px. Bucket colours differ in lightness as well as hue, and always come with names.
