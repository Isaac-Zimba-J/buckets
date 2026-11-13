# Domain rules

This is the source of truth for every business rule. Code in `packages/domain` implements exactly what is written here, and every numbered rule has at least one test that names it (e.g. `test('R-SPLIT-3 remainder goes to living', ...)`). If a rule is missing or unclear, do not guess: add it to "Open questions" in `docs/PROGRESS.md`.

Example values in this document match the design canvas: salary K 12,000, bills K 4,300, K 7,700 left to split.

## 1. Money, percentages and time

- **R-MONEY-1** Money is an integer number of ngwee. K 1 = 100 ngwee.
- **R-MONEY-2** Percentages are basis points (bp). 100% = 10,000 bp. 10% = 1,000 bp.
- **R-MONEY-3** Applying a percentage floors to the ngwee: `floor(amount × bp / 10000)`.
- **R-MONEY-4** Display rules are in `docs/design/WRITING.md`: whole kwacha in most places, ngwee on receipts and proofs.
- **R-TIME-1** All dates are stored in UTC and evaluated in the device time zone (default `Africa/Lusaka`, UTC+2, no daylight saving).
- **R-TIME-2** "Today" and "yesterday" are calendar days in the device time zone.
- **R-TIME-3** A month for budgeting is a **pay cycle**: from one salary payday (inclusive) to the next (exclusive). Before the first payday, the cycle is from setup to the first payday.
- **R-TIME-3a** A monthly payday on a day the month doesn't have (e.g. 31 in November) falls on that month's last day. The cycle ends at local midnight of the next expected payday; if that day passes without a payday being started (late salary), the cycle stays open until the end of today. Irregular salary has no cycle end.

## 2. Accounts

An account is a real place money sits.

- Fields: `id`, `name`, `kind` (`bank`, `mtnMomo`, `airtelMoney`, `cash`, `investment`, `other`), `matchKeys` (list of strings that appear in confirmation messages, e.g. the last 4 digits or the registered name), `isSpending` (bool).
- **R-ACC-1** Exactly one account is the default spending account (`isSpending = true`). Salary lands there unless the income says otherwise.
- **R-ACC-2** A `cash` account exists automatically ("Cash in hand").
- **R-ACC-3** Match keys are compared case-insensitively after collapsing whitespace. A key must be at least 3 characters.

## 3. Buckets

A bucket is a labelled share of money with a purpose.

- Fields: `id`, `name`, `kind`, `colorToken`, `accountId` (where its money lives), `isProtected`, `sortOrder`, `archived`.
- Kinds: `living`, `guiltFree`, `emergency`, `shortTerm`, `longTerm`, `goal`, `family`, `business`, `custom`, `bills`.
- **R-BUCKET-1** Default buckets created at setup: Living (`bucket-living`), Guilt-free (`bucket-fun`), Emergency (`bucket-emergency`), Short-term (`bucket-short`), Long-term (`bucket-long`). Goals are buckets of kind `goal` (`bucket-goal`).
- **R-BUCKET-2** Emergency and Long-term are `isProtected = true`. Their money is never reduced automatically — not by overspend cover (R-OVER-2) and not by spending. The user can still move money out of them by hand, which always warns and asks to confirm (R-MOVE-2). (Confirmed manual moves replace the V1.1-only `WithdrawFromProtected`; the deliberate 24-hour-wait withdrawal is still V1.1.)
- **R-BUCKET-3** Living and Guilt-free live in the spending account by default. Saving buckets should point to a different account; if they don't, setup shows a warning but allows it.
- **R-BUCKET-4** A bucket's balance is never stored. It is derived from the ledger (§6).
- **R-BUCKET-5** Bucket names are unique (case-insensitive) among non-archived buckets. Kinds `living` and `guiltFree` have exactly one bucket each.
- **R-BUCKET-6** Only user-created buckets — goals and the `custom` / `family` / `business` kinds — can be removed; the five default buckets (R-BUCKET-1) cannot. Removing **archives** the bucket (`archived = true`) and never hard-deletes it, so its ledger history stays and balances remain correct. If the bucket still holds money, the user picks a destination bucket and the balance is moved there in the same transaction (R-LEDGER-3) before it is archived; an overspent (negative) bucket must be covered first and cannot be removed while negative. Removal is blocked while an open payday has an unproven transfer to the bucket. The removed bucket's split allocations are reassigned to the `goalShareFallback` bucket (R-SPLIT-4a) for future paydays only (R-SPLIT-6).

- **R-BUCKET-7** A `bills` bucket ("Bills money") is created at setup and for existing installs. It lives in the spending account, never has a payday transfer, is not shown in the split percentages, and is shown on Plan > Bills. It is not protected, but it is never offered as an overspend cover source (R-OVER-2). It cannot be removed (R-BUCKET-6).

## 4. Income and splits

- Income source fields: `id`, `name`, `kind` (`salary`, `sideHustle`, `other`), `expectedAmount` (nullable for irregular), `frequency` (`monthly`, `fortnightly`, `irregular`), `payday` (day of month for monthly; anchor date for fortnightly), `landsInAccountId`, `splitProfileId`, `deductBillsFirst` (true for salary by default, false for side hustles).
- Split profile: ordered list of `Allocation(bucketId, bp)`, plus `holdUntilMonthEnd` (bool, side hustles only).
- **R-SPLIT-1** Allocations in a profile must sum to exactly 10,000 bp. Saving a profile that doesn't is a `ValidationFailure` with the difference (the design shows "110% · too much").
- **R-SPLIT-2** If `deductBillsFirst`, the amount to split = income − sum of monthly bill reservations (§5). If that is negative, splitting fails with `ValidationFailure(code: billsExceedIncome)` and the UI asks the user to review bills.
- **R-SPLIT-3** Each allocation gets `floor(amountToSplit × bp / 10000)`. The leftover ngwee from flooring go to the Living bucket (or, for a profile without Living, to the allocation with the largest bp, first in order on ties). The allocations always sum exactly to the amount split.
- **R-SPLIT-4** Default salary profile: Living 40%, Guilt-free 10%, Emergency 10%, Short-term 10%, Long-term 20%, first goal 10%. Example: K 7,700 → 3,080 / 770 / 770 / 770 / 1,540 / 770.
- **R-SPLIT-4a** If there is no active goal bucket, the goal share in R-SPLIT-4 and R-SPLIT-5 goes to the bucket chosen in the `goalShareFallback` setting (default Long-term; one of the five default buckets). Shares that land on the same bucket add up, e.g. salary with no goal → Long-term 30%.
- **R-SPLIT-5** Default side-hustle profile: Restock (business) 30%, Long-term 30%, a goal 20%, Guilt-free 20%. If the user has no business bucket, Restock is replaced by Short-term.
- **R-SPLIT-6** Changing a split affects only future paydays, never past ledger entries.

## 5. Bills

- Fields: `id`, `name`, `amount`, `frequency` (`monthly`, `termly` = every 4 months, `yearly`, `everyNMonths(n)`), `dueDay` / `nextDueDate`, `paidFromBucketId` (default Living), `payeeAccountHint` (optional).
- **R-BILL-1** Monthly reservation of a monthly bill = its amount. For any other frequency it is a sinking fund aimed at the next due date: `ceil((amount − put aside so far) / months until nextDueDate)`, with months counted in whole pay cycles and a minimum of 1. Example: school fees K 2,400 due in January, nothing put aside, 3 cycles left → K 800 per month. The reservation is recalculated at the start of every cycle.
- **R-BILL-2** On payday, the monthly reservation of every bill (R-BILL-1) is allocated into the Bills bucket (R-BUCKET-7) before the split. Non-monthly bills keep a per-bill "put aside" amount inside the Bills bucket, shown as "K 1,600 put aside so far". *(Replaces the old hidden sub-balance of the paying bucket, DOC-03.)*
- **R-BILL-3** Bill total shown in setup = sum of monthly reservations (example K 2,500 + 400 + 600 + 800 = K 4,300).
- **R-BILL-2a** *Retired by DOC-03:* bills are no longer allocated into the paying bucket; see R-BILL-2. Existing tagged entries stay where they are and stay valid: a bill's put-aside amount is the sum of its tagged entries in any bucket (R-LEDGER-5), so no figure changes. Only new paydays write into the Bills bucket.
- **R-BILL-4** A bill reminder is scheduled 2 days before `nextDueDate` at 09:00 (§12).
- **R-BILL-5** Bills are paid from the Bills bucket by default (`paidFromBucketId`); the user may choose another bucket per bill.
- **R-BILL-6** At the start of each pay cycle a `BillOccurrence` is created for every bill whose due date falls in that cycle: `billId`, `cycleStart`, `dueDate`, `expectedAmount`, `status` (`due`, `paid`, `skipped`), `paidAmount`, `paidAt`, `accountId`, `feeTransactionId`, `proofRef`. Non-monthly bills only get an occurrence in the cycle they are due; in other cycles they show as "Saving up" with put-aside / amount.
- **R-BILL-7** Marking an occurrence paid writes a `spend` entry from the paying bucket for `paidAmount` (category Bill), records the fee as a separate Fees transaction (R-FEE-1), and sets status `paid`. Paying less leaves the difference in the Bills bucket; paying more takes it from the Bills bucket and can make it overspent (R-OVER applies; Bills cannot cover other buckets).
- **R-BILL-8** Late = `paidAt` after `dueDate`. Overdue = still `due` after `dueDate`; unpaid occurrences from past cycles stay `due` (shown overdue) until paid or skipped.
- **R-BILL-9** Auto-suggest: an outgoing alert whose counterparty contains a bill's payee match key during the cycle, with amount within ±25% of expected, suggests "Mark <bill> as paid?" in the sort sheet (18). The user confirms; it is never ticked silently.
- **R-BILL-10** History keeps all occurrences. Stats: average of the last 6 paid amounts, on-time count of the last 5.

## 6. Ledger and balances

The ledger is the only place money moves.

- Entry fields: `id`, `occurredAt`, `kind`, `bucketId`, `amount` (signed ngwee), `counterBucketId` (for moves), `refs` (paydayId, transferId, alertId, transactionId, receiptId), `note`, `reversesEntryId`.
- Kinds: `allocation` (+ to a bucket from a payday split), `spend` (−), `moveOut` / `moveIn` (pair, between buckets), `adjustment` (starting balances, untracked cash), `reversal`.
- **R-LEDGER-1** Entries are append-only. Corrections append a `reversal` entry with the negated amount and `reversesEntryId`.
- **R-LEDGER-2** Bucket balance = sum of its entries. Cycle spend of a bucket = −sum of its `spend` entries in the current pay cycle, with reversed spends netted out of the cycle they were spent in.
- **R-LEDGER-3** Every move between buckets writes two entries in one transaction (`moveOut` −x, `moveIn` +x).
- **R-LEDGER-4** Allocation entries are written when a payday is **started** (§7), not when transfers are proven. Proof changes transfer status only.
- **R-LEDGER-5** "Left to spend" for Living/Guilt-free = balance at now minus unpaid bill money held in the bucket (R-BILL-2a). "About K x a day" = floor(balance ÷ days left in cycle, minimum 1 day), shown only when balance > 0.
- **R-LEDGER-6** A **starting balance** (money the user already had before using Buckets) is one `adjustment` entry into the bucket, with no category and no payday ref. It counts in the bucket balance (R-BUCKET-4), in `totalSaved` and in goal progress, but it is never an `allocation`, so it is excluded from "saved this cycle" (R-CHECKIN-1), payday totals and the streak. Correcting a starting balance re-enters the amount: the bucket's previous starting-balance adjustment is reversed (R-LEDGER-1) and a new one appended, so there is at most one live starting-balance entry per bucket.
- **R-MOVE-1** The user can move money from any bucket to any other bucket or goal. The most that can move is the source's **available balance**: for Living and Guilt-free that is "left to spend" (R-LEDGER-5), so reserved bill money cannot be moved; for every other bucket it is the full balance. A move can never take a bucket below zero. Mechanically a move is a move pair (R-LEDGER-3).
- **R-MOVE-2** A manual move **warns and asks to confirm** when the source is a protected bucket (Emergency or Long-term), or when it would take a saving bucket below what it held at the start of the current pay cycle (its balance at the last salary payday). The confirm names the shortfall. Overspend cover (R-OVER-3) is not a manual move and never warns.

## 7. Payday

- A payday is created when: (a) a salary alert is ingested and confirmed by the user, or (b) the scheduled payday date arrives and the user taps "Salary landed" (manual), or (c) a side-hustle split is confirmed.
- Fields: `id`, `incomeSourceId`, `amount`, `startedAt`, `transfers[]`, `snoozesUsed`, `status` (`open`, `complete`).
- Transfer fields: `id`, `bucketId`, `toAccountId`, `amount`, `status` (`pending`, `proven`, `selfReported`, `partial`), `provenAmount`, `owedAmount`, `proofRef`, `provenAt`.
- **R-PAY-1** Starting a payday runs the split (§4) and writes allocation entries for every bucket.
- **R-PAY-2** A transfer is created for every allocation whose bucket's `accountId` differs from the income's landing account. Example: Emergency, Long-term, Short-term and the Laptop goal = 4 transfers, K 3,850 total. Living and Guilt-free stay, so they have no transfer.
- **R-PAY-3** The payday is `complete` when every transfer is `proven` or `selfReported` and no `partial` transfer has `owedAmount > 0`.
- **R-PAY-4** Snoozes: 1 per payday by default (setting 0–3). A snooze delays the alarm to 20:00 the same day, or by 2 hours if already after 18:00. Snoozing is not allowed from 21:00; the alarm simply resumes at 07:00. At exactly 18:00 both rules give 20:00.
- **R-PAY-5** Living and Guilt-free are "unlocked" in the UI (no lock note on Home) when the payday is complete or a snooze has been used. This is a display rule only; spending is never blocked.
- **R-PAY-6** Side-hustle paydays with `holdUntilMonthEnd` accumulate in a holding balance and are split on the last day of the calendar month at 18:00 (one combined payday).

## 8. Messages, alerts and parsing

- `PaymentAlert`: raw text, source (`mtnMomo`, `airtelMoney`, `bank`, `unknown`), receivedAt, parsed fields, status (`new`, `sorted`, `ignored`, `duplicate`).
- `ParsedMessage`: `direction` (`out`, `in`), `amount`, `fee`, `counterparty`, `reference`, `occurredAt`, `balanceAfter` (all nullable), `confidence` (0–1).
- **R-PARSE-1** Parsers are template sets per provider, each template a regex with named groups, written **only** from redacted fixtures. Each fixture has an `.expected.json`; every template must match at least one fixture.
- **R-PARSE-2** Unparseable text returns a `ParsedMessage` with null fields and `confidence 0`, never an exception.
- **R-PARSE-3** Amounts are parsed as decimal strings into ngwee without floating point (`"1,540.00"` → 154000).
- **R-PARSE-4** Duplicate detection: same provider + same reference → `duplicate`. Without a reference: same amount, counterparty and occurredAt within 2 minutes.
- **R-PARSE-5** An incoming alert (`in`) whose counterparty matches the salary payer or amount is within ±10% of expected salary → suggest "Salary landed"; otherwise suggest "Side hustle money?" (screen 17).

## 9. Proof of transfer

- **R-PROOF-1** A proof passes when all four checks pass:
  1. **Amount:** parsed amount within ±K 1 (100 ngwee) of the transfer amount.
  2. **Account:** parsed counterparty contains any match key of the destination account (R-ACC-3).
  3. **Date:** occurredAt is today or yesterday relative to now (R-TIME-2), and not before the payday started minus 1 day.
  4. **Reference:** non-empty and not used by any other proof.
- **R-PROOF-2** Each check returns `passed`, `failed(reason)` or `unknown` (field not parsed). `unknown` counts as failed and the UI says which field to check.
- **R-PROOF-3** Partial: if only the amount check fails because the parsed amount is lower, the user may "Save K x and mark K y as owed". The transfer becomes `partial` with `owedAmount = transfer − parsed`; the alarm continues for the owed amount. A second proof for the owed amount completes it.
- **R-PROOF-4** "Mark as saved" without passing proof sets `selfReported`. Self-reported transfers count as done but are shown with a neutral "Self-reported" badge and excluded from the proven streak.
- **R-PROOF-5** Streak = consecutive completed paydays where every transfer is `proven`. Self-reported breaks nothing but doesn't increment.
- **R-PROOF-6** Screenshot proof (V1.1) runs OCR then the same parser and checks.

## 10. Spending, categories and receipts

- `Transaction`: `amount`, `bucketId`, `category`, `accountId`, `occurredAt`, `note`, `source` (`alert`, `cash`, `receipt`, `pasted`), optional `alertId` / `receiptId`, optional `lines[]` (receipt split).
- Default categories: Food, Transport, Airtime & data, Market, Family, Bill, Planned buy, Fees, Other.
- **R-SPEND-1** Saving a transaction appends one `spend` entry per bucket involved (a receipt split across Living and Family writes two).
- **R-SPEND-2** Mobile money fees found by the parser are recorded as a separate transaction in category Fees, from the same bucket.
- **R-SPEND-3** "Always file [merchant] as X from Y" creates a `MerchantRule(merchantKey, category, bucketId)`. merchantKey = normalized counterparty (lowercase, digits and punctuation stripped). New alerts matching a rule are pre-filled but still shown in the sort sheet unless the user enabled "auto-file" in settings.
- **R-SPEND-4** Cash: logging a cash payment also reduces "Cash in hand". A MoMo/agent withdrawal (`out` alert identified as withdrawal) increases Cash in hand and is not spending; its fee is.
- **R-SPEND-5** Spending from Guilt-free never produces a warning, notification or overspend prompt unless Guilt-free itself goes below zero.
- **R-RECEIPT-1** OCR text → `ReceiptDraft` via `ReceiptTextParser`: merchant (first non-empty line heuristics), date, line items (`name … amount`), total. Each field carries a confidence.
- **R-RECEIPT-2** If total confidence < 0.8 **or** the sum of line items differs from the total by more than K 1, the total is flagged "please check" (warning state on screen 21). If items sum to the total exactly, the helper text says so.
- **R-RECEIPT-3** Receipt images are stored in app-private storage, linked to the transaction, never uploaded.

## 10b. Transaction fees

- **R-FEE-1** Every fee is a Transaction in category Fees with `feeType` (`send`, `cashOut`, `billPay`, `merchantPay`, `other`), `provider`, `source` (`message`, `estimated`, `missing`) and `parentTransactionId` (the transfer, bill or withdrawal it belongs to).
- **R-FEE-2** Fee amount comes from, in order: the fee shown in the confirmation message; else the estimate from fee rates (R-FEE-3), marked "estimated"; else 0 with source `missing`, listed for review on the Fees page.
- **R-FEE-3** Fee rates are `FeeTariff(provider, feeType)` with ordered `FeeBand(minAmount, maxAmount, fee, source: learned|user, observations)`; min and max are inclusive. The app ships with no rates.
- **R-FEE-4** Learning: when a message shows a fee for an amount whose band is empty, the band is filled (source `learned`). When it differs from an existing band, the user is asked before updating. User-entered bands are never overwritten without asking.
- **R-FEE-5** Payday shows an estimated fee for each transfer (from the source account's provider and `send` rates) and the total. When the transfer is proven, the actual fee from the proof message replaces the estimate.
- **R-FEE-6** Fees are charged to Living by default (setting: Living, or the bucket the money is moving from). Fees on bill payments follow the same setting.
- **R-FEE-7** Fees page (per pay cycle): total, by provider, by `feeType`, count of `missing`, percentage of money moved (sum of outgoing amounts, excluding fees), and the previous cycle's total.

## 11. Overspending

- **R-OVER-1** A bucket is overspent when its balance < 0.
- **R-OVER-2** Cover options are offered in this order, filtered to those with enough balance: **Guilt-free** (only when the overspent bucket is not Guilt-free), **Short-term**, **Next cycle's same bucket** (writes a carry-over that reduces the next allocation). The Bills bucket is never offered (R-BUCKET-7). Emergency and Long-term are never offered (R-BUCKET-2).
- **R-OVER-3** Covering writes a move pair (R-LEDGER-3) for exactly the overspent amount.
- **R-OVER-4** If the same bucket was overspent in 2 of the last 3 cycles, show the tip "your split may be too tight" with a link to Split.
- **R-OVER-5** Guilt-free overspend can only be covered by next cycle's Guilt-free.

## 12. Notifications

All scheduling decisions come from `NotificationPolicy`; the adapter only executes.

| ID | Trigger | Schedule |
| --- | --- | --- |
| N-PAYDAY | payday started with pending transfers | immediately, then every 30 min while pending (R-PAY-4 snooze rules) |
| N-ALERT | new payment alert ingested | immediately, grouped if several within 5 min |
| N-INCOME | incoming non-salary alert | immediately |
| N-BILL | bill due | 2 days before at 09:00 |
| N-BILL-DUE-TODAY | bill occurrence due today and unpaid | 09:00 on the due date |
| N-BILL-OVERDUE | occurrence overdue | 09:00 the day after due, then every 3 days, max 3 |
| N-WISH | cooling-off ended | at end time, moved out of quiet hours |
| N-CHECKIN | weekly | Sunday 18:00 |
| N-LOW | Living < 20% of allocation with > 7 days left | once per cycle, 12:00 |

- **R-NOTIF-1** Quiet hours 21:00–07:00: nothing fires except N-PAYDAY if the user scheduled the payday reminder inside that window themselves.
- **R-NOTIF-2** At most one non-N-PAYDAY notification per hour; extras are merged into the next one or dropped if stale.
- **R-NOTIF-3** Copy and length limits follow `docs/design/WRITING.md` and `docs/design/PATTERNS.md`.
- **R-NOTIF-4** Every notification carries a deep-link payload (ARCHITECTURE §11).

## 13. Goals

- Goal = bucket of kind `goal` + `target`, optional `targetDate`.
- **R-GOAL-1** Monthly contribution = sum of its allocations per expected monthly income (salary allocation + side-hustle allocation × average of last 3 months of that side hustle, 0 if no history).
- **R-GOAL-2** ETA = now + ceil((target − balance) / monthly contribution) months; "not in any split yet" if contribution is 0.
- **R-GOAL-3** Emergency fund target defaults to 3 × (monthly bill reservations + Living allocation). Example: 3 × (4,300 + 3,080) = K 22,140.
- **R-GOAL-4** Goal reached: balance ≥ target → celebration once, then the goal's allocation is offered to another bucket.

## 14. Planning and cooling-off

- `PlannedPurchase`: name, amount, bucketId, due (optional), repeatEvery (optional), done.
- `Wish`: name, amount, bucketId, createdAt, endsAt, status (`coolingOff`, `approved`, `dropped`, `bought`).
- **R-PLAN-1** Logging an unplanned payment above the cooling-off threshold (default K 500, setting) suggests adding it as a wish instead. Never blocks.
- **R-PLAN-2** Wish cooling-off = 48 hours (setting 24/48/72).
- **R-PLAN-3** Marking a planned purchase done links it to the transaction that paid for it; the difference (planned vs actual) is shown.

## 15. Weekly check-in and cash

- **R-CASH-1** Expected cash = last counted cash + withdrawals since − cash spends since.
- **R-CASH-2** Counting cash records the count; gap = expected − counted. A positive gap can be logged as transactions or recorded as one `adjustment` spend in category "Untracked" from Living.
- **R-CASH-3** A negative gap (more cash than expected) asks "Did you receive cash?" and records an `adjustment` into Living or Cash in hand.
- **R-CHECKIN-1** Check-in steps: sort unsorted alerts → count cash → week summary (spent per bucket, saved this cycle, untracked total).

## 16. Profile, security, settings and privacy

- **R-PROFILE-1** The profile is local only: `displayName` (optional, max 30 characters), `greeting` (`muliShani`, `mwaiseni`, `hello`), `timeZone`, `createdAt`. No email, phone number or password in V1. Currency is fixed to kwacha (K) in V1, display only.
- **R-PROFILE-2** With no name, greetings use the greeting word alone ("Muli shani").
- **R-PROFILE-3** The avatar shows the first letter of `displayName`, or a neutral icon.
- **R-SEC-1** App lock uses the phone's own screen lock (PIN, pattern or fingerprint) via the `AppLock` port. Buckets stores no PIN. If the phone has no screen lock, app lock can't be turned on and the row explains why.
- **R-SEC-2** Lock timeout options: immediately, 1 minute (default), 5 minutes. The app locks when it returns from background after the timeout.
- **R-SEC-4** "Hide amounts" replaces amounts on Home with `K ••••` until tapped; it never changes stored data.
- **R-PRIV-3** "Clear alert history" deletes raw alert text now (the R-PRIV-2 90-day purge, early); parsed transactions stay.
- **R-PRIV-4** "Delete all data" requires typing DELETE, then wipes the database, receipt images, settings and scheduled notifications, and returns to Welcome.
- **R-CAT-1** Categories can be added, renamed or archived, never hard-deleted while used by transactions. Default categories can be renamed but not archived.
- **R-CAT-2** Category names are unique (case-insensitive), max 24 characters.
- **R-SUPPORT-1** Problem reports are composed in the user's email app to the support address in app config; the app sends nothing itself.
- **R-SUPPORT-2** "Attach app info" adds only app version, build, Android version and device model. Never balances, messages, names or accounts.

(R-SEC-3 was removed in DOC-01: lockout after wrong attempts is handled by Android's own screen lock.)

### Settings

- Settings: currency display (fixed K for V1), time zone, quiet hours, snooze limit, cooling-off threshold and hours, check-in day/time, app lock and lock timeout, hide amounts, bill reminders, auto-file rules, default buckets' accounts, no-goal fallback bucket for default splits (R-SPLIT-4a).
- **R-PRIV-1** No network in V1 (AGENTS.md §4).
- **R-PRIV-2** Raw alert text is kept for 90 days for re-parsing, then deleted; parsed fields remain.

## 17. Fixtures (needed before parser work)

The human will provide 10–20 redacted real messages per provider in `packages/domain/test/fixtures/sms/{mtn,airtel,bank}/`: payments to merchants, transfers sent, transfers received, cash-out at agent, airtime purchase, and failed/reversed transactions. Redaction rules are in CONTRIBUTING.md §7.
