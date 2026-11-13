# Device test guide: bills and fees (DOC-03)

Run on a real Android phone: `cd app && flutter run -d <device-id>`. Use your real setup (salary, bills, accounts). Tick each line; note anything odd with the screen number.

Fee amounts below depend on your provider's current price list. Where it says "your rate", use a number you know is right.

## 0. Before you start
- [ ] The Bills bucket exists but is **not** a tile on Home (it shows only on Plan > Bills).
- [ ] Choose (05) does not list the Bills bucket.
- [ ] Notification permission granted. Exact alarms: try once granted and once refused (R-01, ADR-0006).

## 1. Plan > Bills (33, 11)
- [ ] Plan has three segments: To buy, Bills, Wishes. Bills opens 33.
- [ ] Hero: "set aside" equals your monthly bill total; "still to pay" equals the unpaid bills.
- [ ] Every monthly bill appears under "Due this cycle" with the right due date and badge (Due, Due soon within 3 days, Overdue after the date).
- [ ] A termly or yearly bill shows under "Saving up", not in the due list, until its cycle.
- [ ] With no bills, you see the empty state and "Add a bill" opens Bills setup.
- [ ] The "Fees this cycle" card shows a total and opens 36.

## 2. Mark a bill paid (34)
- [ ] Tick circle (or tapping Mark) opens 34 with the bill's amount filled in.
- [ ] Choose MoMo/Airtel: a fee line appears. With a saved rate it says "Fee about K x"; with none it says "Fee not known".
- [ ] Choose Cash or Bank: no fee line.
- [ ] Mark as paid returns to 33: the row is ticked and "Paid", the hero numbers move, and Living drops by the fee only (Bills drops by the bill).
- [ ] Paste your real confirmation SMS in "Confirmation SMS": after saving, the fee equals the SMS fee and the bill shows the proof reference. (Do not share real messages in bug reports; redact them.)
- [ ] Paying a different amount: the difference stays in Bills money.
- [ ] A bill cannot be paid twice.

## 3. Bill history (35)
- [ ] Tapping a row opens the bill: Budget, Average, On time, last cycles grid.
- [ ] Paid on time is green, paid late is amber, unpaid is outlined. First cycle shows the "first cycle" note.
- [ ] "Fees paid on this bill" adds up this year's fees for that bill.
- [ ] "Mark <month> as paid" opens 34.

## 4. Fees (36)
- [ ] Before any fee: empty state, plus the Fee rates link.
- [ ] After a paid bill and a proven transfer: total, per-provider bars, by-type list.
- [ ] A bill paid with no known fee shows the "fees missing" warning. After you can correct it, the count drops.

## 5. Fee rates (37)
- [ ] Segments for MTN, Airtel, Bank. Add a band (from, to, fee): it appears with "Entered by you".
- [ ] Overlapping bands are refused with a clear message.
- [ ] Tap a band: change it, or delete it.
- [ ] Paste an SMS whose fee differs from a saved band: a "This fee looks different" prompt appears. "Update" changes the band; "Keep mine" leaves it. The prompt is lost if you close the app (known limit).

## 6. Payday (13) with fees
- [ ] With a send rate saved, each transfer row shows "fee ~ K x" and the hero says "Plus about K x in transfer fees, taken from Living".
- [ ] After proving a transfer with an SMS that has a fee, that row shows the actual "fee K x".
- [ ] No rate saved: no fee text and no fee total.

## 7. Reminders
- [ ] A bill due in 2 days gives the "due soon" notification at 09:00.
- [ ] A bill due today and unpaid gives "A bill is due today" at 09:00; tapping opens its Mark as paid.
- [ ] An overdue bill reminds the next day, then every 3 days, three times at most; tapping opens 33.
- [ ] Paying the bill stops its reminders.

## 8. Money checks (do these once)
- [ ] After paying a bill with a fee: Bills down by the bill, Living down by the fee, totals match the ledger.
- [ ] Kill and reopen the app: every number is the same.
- [ ] Airplane mode on: everything above still works (the app makes no network calls).

## Report
For each failure: screen number, what you did, what you expected, what happened. Redact amounts you do not want shared, and never paste real account numbers.
