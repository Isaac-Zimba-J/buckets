# Patterns

How version 1 flows, which states every screen needs, and how the app interrupts.

## The core loop

1. **Setup (once):** Welcome → Income → Fixed bills → Split → Where money lives → Notifications & alarm → Home (empty until first payday).
2. **Payday (monthly, or when side-hustle money arrives):** salary alert → payday alarm → transfer checklist → prove each transfer → all done. Living and Guilt-free money are "unlocked" on Home once every transfer is proven or snoozed.
3. **Everyday:** a MoMo/Airtel alert opens the "What was this?" sheet; cash and receipts go through Log payment. Each payment reduces a bucket.
4. **Weekly (Sunday):** check-in reminder → clear unsorted payments → count cash → see the week.
5. **When things go wrong:** a bucket runs out → overspent sheet with three ways to cover it. Guilt-free is offered first, then Short-term, then next month. Emergency and Long-term are never offered.

Order matters: bills are entered before the split because the split divides what is left after bills. Accounts are mapped after the split because each bucket needs a real place to live before proof can be checked.

## States every screen designs

| State | Rule |
| --- | --- |
| Empty | Headline saying what will be here, one sentence on how it fills, one action. Never a blank list. |
| Loading | Skeletons in the shape of the content. Spinners only inside buttons. |
| Error | Banner at the top of the affected area: what happened, what to do. Keep the user's input. |
| Offline | Nothing changes: the app is offline-first. Only backup shows "Waiting for internet". |
| Success | Toast for small actions; a full screen only for payday complete and goal reached. |
| Disabled | Explain why in a caption under the control. |

## Notifications

Local notifications only in V1. Each has a channel the user can mute in settings, except the payday alarm, which can only be snoozed in the app.

| Notification | When | Title / body example | Tap opens |
| --- | --- | --- | --- |
| Payday alarm | Salary SMS detected, or payday date at 08:00 | Salary landed / Move K 3,080 to savings before you spend it. | Transfer checklist |
| Alarm repeat | Every 30 min while transfers are open | 2 transfers still open / Long-term and Laptop goal are waiting. | Transfer checklist |
| Payment detected | MoMo / Airtel payment alert | K 185 to [MERCHANT NAME] / Tap to file it. | What was this? sheet |
| Money received | Incoming transfer not from salary | +K 2,000 from [NAME] / Side hustle money? | Side hustle split |
| Bill due | 2 days before | ZESCO due Thursday / K 400 from Living. | Plan › bills |
| Cooling off over | 48 h after a wish is added | Still want the speaker? / K 700 from Short-term. | Plan |
| Weekly check-in | Sunday 18:00 | Your Sunday check-in / 3 payments to sort, then count your cash. | Check-in |
| Bucket low | Living under 20% with over a week to go | Living is at K 410 / About K 45 a day until payday. | Living bucket |

Rules: at most one non-alarm notification an hour; nothing between 21:00 and 07:00 except a payday alarm the user scheduled; every notification names an amount or an action.

## Proof checks

A transfer is proven when the pasted SMS or screenshot shows: the bucket's amount (±K 1 for rounding), a recipient matching the bucket's account, today's or yesterday's date, and a transaction reference not used before. Each failed check is shown by name with how to fix it; the user can still mark it as saved manually, which is recorded as "self-reported".
