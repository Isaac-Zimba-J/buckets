# Screens

Every screen in the design canvas, mapped to its route, controller, use cases, states and components. Phases 1–3 build the use cases and controllers listed here; Phase 5 builds the screens. Numbers match the canvas frames. Example data in the design (names in [BRACKETS], amounts) is illustrative; real values always come from the domain.

**Design sources:** canvas https://claude.ai/artifact/HNvV5sC6BSaUV1ueLPuZDC · design system https://claude.ai/artifact/EkymUKUmHTX2mkWngY2SVY (private until the owner shares them; export frame PNGs into `docs/design/screens/NN-name.png` for agents).

Shared states (from `docs/design/PATTERNS.md`): **loading** = skeletons, **empty** = headline + sentence + action, **error** = banner with what to do, input kept.

---

## 1 · Setup (first run)

### 01 Welcome
- Route `/welcome` · Controller `WelcomeController`
- Use cases: `GetSetupStatus`, `ImportBackup` (V1.1, button hidden in V1)
- States: ready
- Components: hero card (split preview), display title, primary button, text button, lock caption

### 02 Income
- Route `/setup/income` (also `/me/income` after setup) · `IncomeSetupController`
- Use cases: `SaveIncomeSource`, `ListIncomeSources`
- States: ready, validation error (amount ≤ 0, payday out of range), saving
- Rules: R-SPLIT defaults created on save; side hustle defaults to `irregular`, `deductBillsFirst = false`
- Components: flow header (1 of 5), text field, amount field, segmented control, list row, secondary button

### 03 Fixed bills
- Route `/setup/bills` · `BillsController`
- Use cases: `SaveBill`, `DeleteBill`, `ListBills`, `GetBillReservations`
- States: empty ("No bills yet" + add), ready, validation error
- Rules: R-BILL-1…3; sinking-fund progress for non-monthly bills
- Components: list group, progress bar, secondary button, total row

### 04 Split what's left
- Route `/setup/split/:incomeId` · `SplitController`
- Use cases: `PreviewSplit`, `SaveSplitProfile`
- States: valid (100%), invalid (≠100%, Continue disabled, alert caption), bills exceed income (error banner)
- Rules: R-SPLIT-1…4, R-SPLIT-2 error
- Components: hero card with split bar, list rows with percent inputs, disabled primary

### 05 Where buckets live
- Route `/setup/accounts` · `BucketAccountsController`
- Use cases: `ListBucketsWithAccounts`, `AssignBucketAccount`, `SaveAccount` (with match keys)
- States: ready, some unassigned (warning badge "Choose"), validation error on match key length
- Rules: R-ACC-1…3, R-BUCKET-3
- Components: list rows with bucket dots and badges, info banner, text button "Set the rest later"

### 06 Alarms & alerts
- Route `/setup/permissions` · `PermissionsController`
- Use cases: `GetPermissionStatus`, `RequestNotificationPermission`, `OpenNotificationAccessSettings`, `SaveNotificationPreferences`, `CompleteSetup`
- States: ready, permission denied (inline warning + "Open settings"), completing
- Components: toggle rows, info banner, primary button

## 2 · Home, goals and plan

### 07 Home · before first payday
- Route `/home` when no payday has started · `HomeController` (variant `firstRun`)
- Use cases: `WatchHome`, `GetNextPayday`
- States: firstRun, loading
- Components: greeting top bar, hero card (countdown), bucket tiles (3 columns), card row "Add starting balances" (V1.1 → hidden in V1), FAB, tab bar

### 08 Home · mid-cycle
- Route `/home` · `HomeController` (variant `active`)
- Use cases: `WatchHome` (Living left, per-day, Guilt-free left, bucket balances, unsorted count, recent transactions, open payday)
- States: active, payday open (alarm banner on top), loading, error (storage failure banner)
- Rules: R-LEDGER-5, R-PAY-5
- Components: hero card with progress, warning row "N payments to sort", bucket tiles, list group, FAB, tab bar

### 09 Bucket detail · overspent
- Route `/bucket/:bucketId` · `BucketDetailController`
- Use cases: `WatchBucket`, `GetCoverOptions`, `CoverOverspend`
- States: normal (transactions list), overspent (cover options), covering, error
- Rules: R-OVER-1…5
- Components: card with badge "K x over", radio cards, lock caption, primary button

### 10 Goals
- Route `/goals` · `GoalsController`
- Use cases: `WatchGoals`, `CreateGoal`, `GetSavingsStats`
- States: empty ("Pick something to save for"), ready, goal reached (celebration toast once)
- Rules: R-GOAL-1…4. Note: the canvas shows an emergency target of K 24,450; the correct value from R-GOAL-3 is used.
- Components: stat cards, goal cards with progress, dashed "not in a split" card, icon button

### 11 Plan
- Route `/plan` · `PlanController`
- Use cases: `WatchPlannedPurchases`, `TogglePlannedPurchase`, `AddPlannedPurchase`, `WatchWishes`, `DropWish`, `ApproveWish`
- States: empty per tab, ready, wish timer running, wish ended
- Rules: R-PLAN-1…3
- Components: segmented control, overline, check rows, progress ring, destructive secondary button

## 3 · Payday loop

### 12 Notifications (system)
- Not a screen. `NotificationPolicy` + `LocalNotificationScheduler` produce N-PAYDAY, N-INCOME, N-ALERT, N-CHECKIN, N-WISH (DOMAIN §12), each deep-linking to 13, 17, 18, 22, 11.

### 13 Payday transfers
- Route `/payday/:paydayId` · `PaydayController`
- Use cases: `WatchPayday`, `SnoozePaydayAlarm`
- States: open (n of m), all proven → navigate to 16, snooze used, no snoozes left (button disabled + caption)
- Rules: R-PAY-2…5
- Components: hero card (amount left, progress), transfer rows (proven badge / Prove button), secondary snooze button

### 14 Prove transfer · passed
- Route `/payday/:paydayId/proof/:transferId` · `ProofController`
- Use cases: `ProveTransfer`, `MarkTransferSelfReported`
- States: idle (empty textarea), checking, passed (4 green checks), failed (→ 15), unknown fields
- Rules: R-PROOF-1…5
- Components: textarea with paste action, check rows, primary, secondary "Use a screenshot" (V1.1 hidden)

### 15 Prove transfer · failed
- Same route and controller, state `failed`
- Use cases: `RecordPartialTransfer`
- Rules: R-PROOF-2, R-PROOF-3
- Components: danger banner, textarea in error, check rows with one failed, primary, text button, caption

### 16 Payday complete
- Route `/payday/:paydayId/done` · `PaydayDoneController`
- Use cases: `GetPaydaySummary` (moved total, unlocked Living and Guilt-free, per-day, streak, top goal progress)
- States: ready
- Components: full-bleed hero, stat tiles, accent primary button

### 17 Side hustle received
- Route `/income/received/:alertId` · `IncomeReceivedController`
- Use cases: `ClassifyIncomingAlert`, `SplitSideHustleIncome`, `HoldSideHustleIncome`, `IgnoreAlert`
- States: ready, holding (month-end note), not hustle (dismiss)
- Rules: R-PARSE-5, R-SPLIT-5, R-PAY-6
- Components: amount display, segmented control, split bar, list rows, primary + secondary

## 4 · Logging, check-in and states

### 18 Payment detected · sort sheet
- Route `/sort` (bottom sheet over Home; steps through unsorted alerts) · `SortAlertsController`
- Use cases: `WatchUnsortedAlerts`, `CategorizeAlert`, `SaveMerchantRule`, `SkipAlert`
- States: next alert, last alert, none left (sheet closes + toast "All sorted")
- Rules: R-SPEND-1…3, R-SPEND-5
- Components: bottom sheet, chip group (category), bucket chip row "Paid from", checkbox row, secondary + primary

### 19 Log a payment
- Route `/log` · `LogPaymentController`
- Use cases: `LogCashPayment`, `ParsePastedMessage` + `LogPastedPayment`, `SuggestWish` (R-PLAN-1)
- States: cash tab, paste tab, validation error (amount 0), wish suggestion banner, saved (toast + pop)
- Components: segmented control with icons, amount field, chip group, bucket chips, row picker (date/time), text field, primary

### 20 Scan receipt
- Route `/log/scan` · `ScanController`
- Use cases: `CaptureReceiptImage` (camera/gallery), `RecognizeReceipt` (OCR + `ReceiptTextParser`)
- States: camera, processing (skeleton), no text found (error banner + retake), permission denied
- Components: dark camera frame, icon buttons, shutter button

### 21 Receipt review
- Route `/log/receipt/:draftId` · `ReceiptReviewController`
- Use cases: `UpdateReceiptDraft`, `SaveReceipt`
- States: confident, total needs check (warning card), items don't add up (danger caption), saving
- Rules: R-RECEIPT-1…3, R-SPEND-1
- Components: thumbnail, warning input card, list rows with bucket pills, retake + primary

### 22 Sunday check-in
- Route `/checkin` · `CheckInController`
- Use cases: `GetCheckInState`, `CountCash`, `RecordUntrackedCash`, `GetWeekSummary`
- States: step 1 sort (links to 18), step 2 count, gap positive (warning banner), gap negative (question), step 3 summary
- Rules: R-CASH-1…3, R-CHECKIN-1
- Components: step list, list group, amount text field, warning banner, secondary + primary

### 23 States & feedback library
- Not a route. Reference for toasts, skeletons, banners, empty states and badges that every screen above uses (UI-04).

## Me tab (no canvas frame yet; S-10)

- `/me` list: Income sources (→ 02), Bills (→ 03), Splits (→ 04), Buckets & accounts (→ 05), Notifications (→ 06), App lock, Cooling-off and snooze settings, About & privacy.
- Built from list group + list rows + toggle rows only.
