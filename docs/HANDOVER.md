# Handover for the next AI agent

You are continuing work on **Buckets**, a Zambian personal-money Flutter app
(offline, single-user, V1). Read this once, then follow it.

## 0. Read these first, every session (hard rule)

1. `AGENTS.md` (repo root) — the strict rules. They override your defaults.
2. `docs/PROGRESS.md` — status of every task; the source of truth for what's done.
3. `docs/PLAN.md` — task list and acceptance criteria.
4. `docs/DOMAIN.md` — business rules (R-*). Every money/time/privacy decision is here.
5. `docs/ARCHITECTURE.md` — layers and dependency direction.
6. For UI work: `docs/SCREENS.md`, `docs/COMPONENTS.md`, `docs/design/` and the
   mockups in `docs/design/screens/me/` (named `NN <screen>.png`).

Do not skip this. If a rule conflicts with a request, stop and ask the human.

## 1. Environment & commands

- **Flutter is pinned** to 3.47.9 via fvm. Always prefix PATH:
  `export PATH=$HOME/.pub-cache/bin:$HOME/fvm/versions/3.47.9/bin:$PATH`
  and `/usr/local/bin` for `gh`.
- Dart pub workspace + Melos. Useful: `melos run format`, `melos run analyze`,
  `melos run tokens` (regenerate design tokens), `melos run test`.
- **Codegen (freezed, riverpod):** after editing any `@freezed` / `@riverpod`
  file run `dart run build_runner build` (no `--delete-conflicting-outputs`;
  it's removed). CI diffs the generated `.g.dart`/`.freezed.dart`, so commit
  them. The first build on a cold machine is slow (~10 min); incremental ~30 s.
- **l10n:** strings live in `app/lib/l10n/app_en.arb`. After editing run
  `flutter gen-l10n`. Never hard-code user-facing text.
- **Checks before every PR:** `melos run format`, `dart analyze --fatal-infos`
  (must be "No issues found!"), and the relevant tests. Lints: `very_good_analysis`.
  Files <= 300 lines, functions <= 40.
- **This machine is slow.** Start the next task while builds/tests/CI run; never
  idle. Long commands: run in background, then do other work.

## 2. Git / PR workflow (what every change follows)

- One task ID per branch and per PR. Branch off `origin/main`.
- Commit messages and PR bodies end with the attribution the session's
  system-reminder specifies (currently `Co-Authored-By: Claude Opus 4.8
  <noreply@anthropic.com>` for commits, and the "Generated with Claude Code"
  line for PRs). Use whatever the active reminder says.
- Open the PR with `gh pr create`, wait for the `check` CI job to be SUCCESS,
  then `gh pr merge <n> --merge`. A typical wait loop:
  `until s=$(gh pr checks <n> --json name,state --jq '[.[]|select(.name=="check")|.state]|first'); [ "$s" = SUCCESS ] || [ "$s" = FAILURE ]; do sleep 20; done`
- Update `docs/PROGRESS.md` in the same PR: your row's status/date/PR link, the
  "Last updated" line, and recount the phase summary if a row flipped to done.
- After `gh pr merge`, `git checkout main && git pull` before the next branch.
- **Never run `git stash pop` blindly.** An old unrelated stash
  ("D-06a redacted MTN templates and fixtures") exists; applying it pollutes the
  tree. Stash with a message and pop only what you pushed.

## 3. Where things stand (Nov 2026)

V1 is essentially built: Foundations, Domain, Data, Application, UI-kit, and
Screens S-01…S-12 are merged. The app runs on a real phone through setup, Home,
logging, payday, goals/plan, check-in, and the Me stack.

Recently merged: S-12 (#85 move/starting-balance/remove bucket), Home polish to
mockup 07 (#87), design PNGs 33–37 (#88), Home first-run data (#89, name + hero
amounts + tile split %).

**Dark mode decision:** the app follows the system theme (light + dark both
ship). Do NOT force light-only — the owner wants dark kept. Mockups are light;
that's fine.

## 4. Worklist (do in order)

1. ~~Home first-run data~~ — DONE (#89).
2. **Screen-by-screen UI pass** against `docs/design/screens/me/`. Home done.
   Next in flow order: Setup 01–06, Bucket detail 09, Goals/Plan 10–11,
   Payday 13–17, Logging 18–22, Me stack 24–28. Method that worked for Home:
   run on device, screenshot (`adb -s <id> exec-out screencap -p > out.png`),
   diff against the mockup, fix, one PR per screen. Common gaps seen: section
   labels (uppercase overline + muted, see `_Section` in settings_screen.dart),
   card-vs-row layouts, spacing, tile aspect ratios.
3. **New scope — bills & fees (designs 33–37).** Bills management (mark paid,
   history) and **mobile-money fees** (the parked "item 4"). These need a
   planning pass first — write a DOC-03 adding the rules to DOMAIN.md and tasks
   to PLAN.md (mirror how DOC-02 was done), get owner confirmation on the money
   rules, then implement domain -> data -> controllers -> screens.
4. **Two more Home niceties** are optional polish, already partly covered by #89.

## 5. Blocked on the human (do not guess)

- **SMS fixtures** (Open question 1): redacted MTN MoMo / Airtel messages.
  Blocks D-06a/D-06b parser templates; without them real alerts don't parse.
- **Android package names** (Open question 2) for the notification-access
  listener allow-list (DA-08).
- **Receipt OCR fixtures** (Open question 10): blocks the real receipt parser.
- Open questions 3–9, 11 are assumptions awaiting confirmation (see PROGRESS).
- The money/time/privacy rule: when DOMAIN.md doesn't answer, add the question
  to PROGRESS "Open questions" and ask — never guess.

## 6. Testing gotchas (will save you time)

- Domain tests use `packages/domain/test/support/world.dart` and
  `payday_world.dart` (seeded repos; `PaydayWorld` has a `laptop` goal and
  `canvasSetup()`/`startSalary()`).
- App widget tests: harness in `app/test/features/setup/screens/screen_harness.dart`
  (`pumpApp`, `pumpScreen`, `type`, `typeAmount`, `tapOn`, `settleStreams`).
  **Live (stream) controllers** need `settleStreams(tester)` — the in-memory
  fakes deliver on the real event loop, so alternate short real waits with
  frames. Build the `ProviderContainer` inside each test (`start()`), not in a
  shared field, so fakes and widgets share the fake-async zone.
- Goldens tolerate a 3% pixel diff (macOS record vs Linux CI) — see
  `packages/ui_kit/test/flutter_test_config.dart` (ADR-0005). Gallery and
  goldens share their sample pages (`package:buckets_ui_kit/gallery.dart`).
- Money is always `Money` (int ngwee). Never `double`. Format only with
  `MoneyFormatter` (note the non-breaking space after `K`, so test strings use
  `K `). Percentages are `BasisPoints` (10000 = 100%).

## 7. Running on device

```
export PATH=$HOME/.pub-cache/bin:$HOME/fvm/versions/3.47.9/bin:$PATH
cd app && flutter run -d <device-id>   # flutter devices to list; authorize USB debugging on the phone
```
`flutter run` stays attached — launch it in the background and wait for the
"Flutter run key commands" line (or a build error) before screenshotting.

---

## 8. Next planning task — Bills tracking & transaction fees (owner spec)

This is the detailed spec for worklist item 3. The owner will hand you the same
text as your task prompt. **Before you run it, fix these ID collisions — the
spec was written without the current task numbers:**

- It calls itself **DOC-02**, but DOC-02 is taken (moves/starting-balance docs,
  PR #82). Use **DOC-03**.
- It reuses IDs that are **already built and merged**: `D-17` (= move/starting-
  balance/remove), `S-12` (= move screens), and `D-15c`, `DA-01c`, `DA-03c`,
  `AP-02c`, `AP-03c` collide with existing `*-b`/`*-c` rows. **Renumber every new
  row to the next free ID** in its phase (check `docs/PROGRESS.md` first). Keep
  the rule names (R-BUCKET-6 etc.) — but note **R-BUCKET-6 already exists**
  (remove-bucket); the bills rule must take the next free number (e.g.
  R-BUCKET-7), and likewise check R-BILL-*/R-FEE-* numbering against DOMAIN.md.
- Images are in **`docs/design/screens/me/`** (files `33 Plan · bills this
  cycle.png` … `37 Fee rates.png`), **not** `docs/design/screens/bills-fees/`.
- It is **DOCS ONLY** — no code. It must not change any existing task row's
  status/owner/date/PR. Reply with the plan and wait for the owner's "go".

Owner's spec, verbatim:

<<<BEGIN OWNER SPEC
Task: Bills tracking and transaction fees — add to the plan. DOCS ONLY: no code.
Do not change the status, owner, date, PR or notes of any existing task row.

What's new
1. Bills tracking. Bill money is set aside on payday, but there is no way to tick
   a bill as paid each cycle. New: each pay cycle creates a fresh, unticked entry
   for every bill due in that cycle. The user ticks it when paid; next cycle a new
   entry appears. History is kept. Bill money now lives in its own "Bills" bucket
   (kept in the spending account, no transfer), instead of a hidden sub-balance of
   Living.
2. Transaction fees. MTN MoMo and Airtel Money charge fees on transfers, cash-outs
   and bill payments. New: every fee is recorded (from the message when it shows
   one, otherwise estimated from fee rates, otherwise flagged as missing), payday
   shows the estimated fee per transfer, and a dedicated Fees page shows totals.
   Fee rates are learned from messages and editable; the app ships with NO
   built-in tariffs.

New canvas screens (row "6 · Bills & fees"), images in docs/design/screens/me/:
33 Plan · Bills this cycle (the Plan screen's "Bills" tab), 34 Mark bill paid
(sheet), 35 Bill history, 36 Fees, 37 Fee rates. Changed: 13 Payday now shows
"fee ~ K x" per transfer and "Plus about K 25 in transfer fees, taken from
Living"; 11 Plan's Bills tab links to 33.

Steps
1. docs/DOMAIN.md
   - In §3 add bucket kind `bills` and the bills-bucket rule (text below).
   - Replace R-BILL-2 and add the new R-BILL-* rules (text below).
   - Add a new section "§10b Transaction fees" with R-FEE-1..7 (text below).
   - In §12 add notification N-BILL-DUE-TODAY and N-BILL-OVERDUE (text below).
2. docs/SCREENS.md – add a section "## 6 · Bills and fees" with entries 33-37
   (text below), and update 11 Plan and 13 Payday as described. Link each image.
3. docs/PLAN.md – add the task rows below to their phases, in dependency order.
4. docs/PROGRESS.md – add the new docs task (status in review) to the Docs table
   and the new task rows as todo; update Summary totals; add the open questions
   below (continue numbering).
5. docs/COMPONENTS.md – add the component rows below.
6. docs/ARCHITECTURE.md – entities: add `BillOccurrence`, `FeeTariff`, `FeeBand`;
   repository ports: add `BillOccurrenceRepository`, `FeeTariffRepository`; routes
   list (if present): add /plan/bills, /plan/bills/:billId, /plan/bills/:billId/pay,
   /fees, /fees/rates.
7. Impact check (report only): annotate done tasks that need follow-ups (likely
   D-01, D-02, D-03 SplitCalculator because bills now allocate into the Bills
   bucket, D-05 PaydayPlanner, D-08 Spending, DA-01, DA-03, DA-05 seed, AP-02,
   AP-03, S-04 Payday, S-07 Plan) with "Needs follow-up for bills/fees ->
   <new ID>" and add those follow-up rows.
8. Open PR "[DOC-03] Bills tracking and transaction fees".
Reply first with the files you'll change, the done tasks you'll annotate and any
conflicts with what is already built. Wait for "go".

---------------- TEXT TO INSERT ----------------

DOMAIN §3
- A `bills` bucket ("Bills money") is created at setup. It lives in the spending
  account, never has a payday transfer, is not shown in the split percentages,
  and is shown on Plan > Bills. It is not protected, but it is never offered as an
  overspend cover source.

DOMAIN §5 (replace R-BILL-2, then add)
- R-BILL-2 On payday, the monthly reservation of every bill (R-BILL-1) is
  allocated into the Bills bucket before the split. Non-monthly bills keep a
  per-bill "put aside" amount inside the Bills bucket.
- Bills are paid from the Bills bucket by default (`paidFromBucketId`), and the
  user may choose another bucket per bill.
- At the start of each pay cycle, a `BillOccurrence` is created for every bill
  whose due date falls in that cycle: billId, cycleStart, dueDate, expectedAmount,
  status (`due`, `paid`, `skipped`), paidAmount, paidAt, accountId,
  feeTransactionId, proofRef. Non-monthly bills only get an occurrence in the
  cycle they are due; in other cycles they show as "Saving up" with
  put-aside / amount.
- Marking an occurrence paid writes a `spend` entry from the paying bucket for
  paidAmount (category Bill), records the fee as a separate Fees transaction, and
  sets status `paid`. Paying less leaves the difference in the Bills bucket;
  paying more takes it from the Bills bucket and can make it overspent (R-OVER
  applies, Bills cannot cover others).
- Late = paidAt after dueDate. Overdue = still `due` after dueDate.
- Auto-suggest: an outgoing alert whose counterparty contains a bill's payee
  match key during the cycle, with amount within +/-25% of expected, suggests
  "Mark <bill> as paid?" in the sort sheet. The user confirms; it is never ticked
  silently.
- History keeps all occurrences. Stats: average of the last 6 paid amounts,
  on-time count of the last 5. Unpaid occurrences from past cycles stay `due`
  (shown as overdue) until paid or skipped.

DOMAIN §10b Transaction fees
- R-FEE-1 Every fee is a Transaction in category Fees with `feeType` (`send`,
  `cashOut`, `billPay`, `merchantPay`, `other`), `provider`, `source` (`message`,
  `estimated`, `missing`) and `parentTransactionId` (the transfer, bill or
  withdrawal it belongs to).
- R-FEE-2 Fee amount comes from, in order: the fee shown in the confirmation
  message; else the estimate from fee rates (R-FEE-3), marked "estimated"; else 0
  with source `missing`, listed for review on the Fees page.
- R-FEE-3 Fee rates are `FeeTariff(provider, feeType)` with ordered
  `FeeBand(minAmount, maxAmount, fee, source: learned|user, observations)`. The
  app ships with no rates.
- R-FEE-4 Learning: when a message shows a fee for an amount whose band is empty,
  the band is filled (source `learned`). When it differs from an existing band,
  the user is asked before updating. User-entered bands are never overwritten
  without asking.
- R-FEE-5 Payday shows an estimated fee for each transfer (from the source
  account's provider and `send` rates) and the total. When the transfer is
  proven, the actual fee from the proof message replaces the estimate.
- R-FEE-6 Fees are charged to Living by default (setting: Living, or the bucket
  the money is moving from). Fees on bill payments follow the same setting.
- R-FEE-7 Fees page (per pay cycle): total, by provider, by feeType, count of
  `missing`, percentage of money moved (sum of outgoing amounts, excluding fees),
  and the previous cycle's total.

DOMAIN §12 notifications (add rows)
| N-BILL-DUE-TODAY | bill occurrence due today and unpaid | 09:00 on the due date |
| N-BILL-OVERDUE | occurrence overdue | 09:00 the day after due, then every 3 days, max 3 |

SCREENS – "## 6 · Bills and fees"
33 Plan · Bills this cycle – Route /plan/bills · BillsCycleController. Use cases:
  WatchBillsCycle (Bills bucket set aside / paid / still to pay / saving up),
  WatchFeesTotal. States: all paid, some due, overdue (danger badge), no bills
  (empty state -> add bill). Components: segmented control, hero card, BkBillRow
  (tick + badge), saving-up row, link card.
34 Mark bill paid – bottom sheet /plan/bills/:billId/pay · MarkBillPaidController.
  Use cases: EstimateFee, MarkBillPaid, ParsePastedMessage (optional proof).
  States: ready, fee estimated, fee unknown ("Add fee"), amount differs from usual
  (caption), saving.
35 Bill history – /plan/bills/:billId · BillHistoryController. Use cases:
  WatchBillHistory, GetBillStats. States: ready, first cycle (no history).
  Components: stat cards, BkMonthGrid.
36 Fees – /fees · FeesController. Use cases: WatchFeesSummary (R-FEE-7),
  ListMissingFees. States: no fees yet (empty), ready, missing fees (warning
  banner). Components: amount hero, BkProviderBar, list group, banners, link card.
37 Fee rates – /fees/rates · FeeRatesController. Use cases: WatchFeeTariffs,
  SaveFeeBand, DeleteFeeBand, ResolveFeeChange (accept/decline learned update).
  States: empty (no rates), ready, pending learned change (prompt). Components:
  segmented control, rows with source labels.
Update 11 Plan: segmented "Bills" opens 33. Update 13 Payday: transfer rows show
  "fee ~ K x" or "no fee", hero shows estimated total fees and where they're taken
  from (R-FEE-5/6).

PLAN rows (RENUMBER IDs to the next free ones before adding)
| Bills cycle & occurrences | depends D-04, D-01b | bills bucket rule, R-BILL-2 and new bill rules; occurrences per cycle incl. non-monthly; late/overdue; auto-suggest matching. |
| Fee rates & FeePolicy | depends D-06, D-08 | R-FEE-1..7; band lookup edges (min/max inclusive), learning and ask-before-update, estimates on payday. |
| Use cases for 33-37 and Payday fees | depends above | all use cases in SCREENS §6 with tests. |
| Schema: bill occurrences, fee tariffs, fee fields | depends DA-01b | migration with test; bills bucket seeded for existing installs. |
| Repositories + contract tests | depends schema | BillOccurrenceRepository, FeeTariffRepository, fakes. |
| Controllers 33-37, Payday fees | depends use cases | every listed state tested. |
| Routes & notification deep links | depends controllers | /plan/bills..., /fees..., N-BILL-DUE-TODAY/OVERDUE payloads. |
| Bill & fee components | depends UI-05 | BkBillRow, BkMonthGrid, BkProviderBar with goldens. |
| Screens 33-37 | depends routes + components | match designs; all states. |
| Payday fees | depends controllers | 13 shows per-transfer and total fee estimates. |

COMPONENTS rows
| BkBillRow | title, subtitle, amountText, status (due, dueSoon, overdue, paid), onTick, onTap | tick circle + status badge |
| BkMonthGrid | months: (label, state paid/late/due/skipped, caption) | 3-column history grid |
| BkProviderBar | label, colorDot, amountText, fraction | labelled bar per provider |

Open questions (continue the numbering in PROGRESS)
- Leftover Bills money at the end of a cycle (paid less than set aside): keep it
  in Bills (default), or move it to Short-term?
- Fees charged to Living or to the bucket being moved (R-FEE-6 default is Living)
  – confirm.
- Payee match keys for bills (e.g. what the ZESCO payment message shows as the
  recipient) – owner to add redacted bill-payment fixtures.
END OWNER SPEC>>>
