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

### 01b About you (profile)
- Route `/setup/profile` (also `/me/profile`) · `ProfileController`
- Use cases: `SaveProfile` (display name, greeting style), `GetDeviceTimeZone`
- States: empty name (Continue still allowed; greeting uses the chosen greeting word alone, e.g. "Muli shani"), ready
- Rules: R-PROFILE-1…3
- Components: flow header (1 of 6), text field, segmented control, list rows, info banner
- Design: docs/design/screens/me/01b-about-you.png (the banner's "You can add a PIN later in Settings" predates R-SEC-1; the domain wins: there is no in-app PIN)

### 02 Income
- Route `/setup/income` (also `/me/income` after setup) · `IncomeSetupController`
- Use cases: `SaveIncomeSource`, `ListIncomeSources`
- States: ready, validation error (amount ≤ 0, payday out of range), saving
- Rules: R-SPLIT defaults created on save; side hustle defaults to `irregular`, `deductBillsFirst = false`
- Components: flow header (2 of 6), text field, amount field, segmented control, list row, secondary button

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

## 5 · Me, settings and help

### 24 Me (profile tab)
- Route `/me` · `MeController`
- Use cases: `WatchProfileSummary` (name, initial, proven paydays), `WatchSetupCounts` (incomes, bills total, buckets, rules)
- States: ready
- Links: 01b, 02, 03, 04, 05, 28, 25, 29, 31, 32
- Components: avatar, list groups with value + chevron, support tiles, tab bar
- Design: docs/design/screens/me/24-me.png

### 25 Settings
- Route `/me/settings` · `SettingsController`
- Use cases: `WatchSettings`, `UpdateSettings` (snooze limit, quiet hours, check-in day/time, bill reminders, cooling-off threshold and length, auto-file)
- States: ready, saving (inline), validation error (quiet hours start and end can't be the same)
- Appearance (dark theme) row shows "Coming in 1.1" and is disabled in V1
- Rules: DOMAIN §12, §14, §16
- Components: list rows with values, toggle rows, pickers in bottom sheets
- Design: docs/design/screens/me/25-settings.png

### 26 Security
- Route `/me/settings/security` · `SecurityController`
- Use cases: `SetAppLock` (unlock with the phone's screen lock first), `SetLockTimeout`, `SetHideAmounts`
- States: lock off, lock on, no phone screen lock (toggle disabled + caption explaining why)
- Rules: R-SEC-1, R-SEC-2, R-SEC-4
- Components: status header, toggle rows, list row with value, info banner
- Design: docs/design/screens/me/26-security.png

### 27 Data & privacy
- Route `/me/settings/data` · `DataPrivacyController`
- Use cases: `GetStorageSummary`, `ClearAlertHistory`, `DeleteAllData`, `ExportBackup` (V1.1, row shows "Coming in 1.1")
- States: ready, confirm delete dialog (type DELETE), deleting, deleted → app restarts at 01
- Rules: R-PRIV-1…4
- Components: positive banner, info list, list rows (destructive), alert dialog (new `BkConfirmDialog`)
- Design: docs/design/screens/me/27-data-privacy.png

### 28 Auto-filing rules
- Route `/me/rules` · `RulesController`
- Use cases: `WatchMerchantRules`, `UpdateMerchantRule`, `DeleteMerchantRule`, `WatchCategories`, `AddCategory`, `RenameCategory`, `ArchiveCategory`
- States: empty ("Rules appear when you tick Always file"), ready
- Rules: R-SPEND-3, R-CAT-1…2
- Components: list rows with category·bucket pills, toggle row, chip group with add chip
- Design: docs/design/screens/me/28-rules.png

### 29 Help
- Route `/help` · `HelpController`
- Use cases: `ListHelpTopics`, `SearchHelp` (local, bundled articles; no network)
- States: ready, search results, no results ("Try other words, or report a problem")
- Components: search field, topic tiles, list group, dark call-to-action row
- Design: docs/design/screens/me/29-help.png

### 30 Help article
- Route `/help/:articleId` · `HelpArticleController`
- Use cases: `GetHelpArticle`, `OpenSystemSettings` (notification access, battery), `RecordArticleFeedback` (stored locally only)
- States: ready, feedback given
- Content: bundled Markdown in `app/assets/help/*.md`, written per WRITING.md
- Design: docs/design/screens/me/30-help-article.png

### 31 Report a problem
- Route `/help/report` · `ReportController`
- Use cases: `BuildProblemReport` (category, text, optional app info), `OpenEmailComposer` (platform port `EmailComposer`)
- States: ready, empty text (button disabled + caption), no email app (error banner with the address to copy)
- Rules: R-SUPPORT-1…2
- Components: chip group, multiline field, toggle row, info banner, primary
- Design: docs/design/screens/me/31-report.png

### 32 About
- Route `/me/about` · `AboutController`
- Use cases: `GetAppInfo` (version, build), `OpenStoreListing`, `ShowLicences` (Flutter `showLicensePage`)
- States: ready
- Components: logo, list rows, caption
- Design: docs/design/screens/me/32-about.png
