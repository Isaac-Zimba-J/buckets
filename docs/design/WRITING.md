# Writing

How Buckets talks, and how it writes money, dates and numbers.

## Voice

A calm friend who is good with money. Plain English that reads naturally in Zambia, short sentences, second person ("you"), active verbs. Encouraging without cheerleading. The app never lectures, never guilts and never jokes about someone's spending.

| Do | Don't |
| --- | --- |
| Living is K 310 over. Here's how to cover it. | You overspent again! |
| Salary landed. Move your savings before you spend. | URGENT: TRANSFER NOW |
| We couldn't read the total. Please check it. | OCR error 422 |
| Nice. 4 paydays in a row. | You're a money master! |

A local greeting on Home is welcome ("Muli shani", "Mwaiseni") but every instruction stays in English.

## Money format

- Kwacha as **K**, a space, then the number with comma thousands: `K 1,540`. The space is a non-breaking space.
- Whole kwacha everywhere except receipts and proofs, which show ngwee: `K 1,540.00`, `K 412.50`.
- Spending uses a true minus: `−K 320`. Money in uses a plus: `+K 2,000`. Plain balances have no sign.
- Never write ZMW in the UI except when quoting an SMS.
- Percentages have no space: `20%`.
- Large numbers are never abbreviated (no `K 12k`).

## Dates and times

- Dates: `25 Nov`, add the year only when it isn't this year: `Aug 2027`.
- Relative where it helps: `Today`, `Yesterday`, `in 12 days`.
- Times: 24-hour, `14:32`.

## Words we use

| Use | Not |
| --- | --- |
| bucket | envelope, jar, category (category means what you bought, bucket means where money came from) |
| split | allocation |
| move / transfer | allocate, sweep |
| prove / proof | verify, validate |
| payday | income event |
| side hustle | secondary income |
| mobile money, MoMo, Airtel Money | e-wallet |
| planned buy | budget item |
| Guilt-free | fun money, splurge, treat budget |

## Lengths

| Element | Max |
| --- | --- |
| Screen title | 32 characters, may wrap to 2 lines |
| Button | 3 words, starts with a verb: "Save", "Mark as saved", "Split it" |
| Notification title | 40 characters |
| Notification body | 90 characters |
| Toast | 1 line, past tense: "Saved to Living" |
| Error banner | What happened + what to do, 2 sentences |
| Empty state | 1 headline + 1 sentence + 1 action |

## Patterns

- Errors say what went wrong and what to do next, with no blame: "This message is for K 1,450, but this transfer is K 1,540. Paste the right message or edit the amount."
- Confirmations name the result: "K 770 moved to Emergency", not "Success".
- Placeholders are examples, not instructions: `e.g. bus to town and back`.
- In mockups, unknown real data is written in brackets: `[MERCHANT NAME]`, `[ACCOUNT NAME]`.
