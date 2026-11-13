# ADR-0006: Android permissions and Play policy

- Status: Accepted
- Date: 2026-11-13
- Task: R-01

## Context
Buckets needs notifications, a payday alarm that repeats, boot persistence, app lock and access to payment-app notifications. Android 13 and 14 and Google Play restrict several of these. This review checked the current Android developer and Play Console help pages (sources below). The merged release manifest has not been built or inspected yet; that is a release check (see Consequences).

## Decision

| Capability | Permission / API | Decision |
| --- | --- | --- |
| Notifications | `POST_NOTIFICATIONS` (Android 13+) | Keep. Asked at runtime on screen 06; if refused, the app still works and shows an in-app banner. |
| Payday alarm timing | `SCHEDULE_EXACT_ALARM` | Keep. Denied by default on new installs targeting Android 13+ and revocable by the user or system, so the app checks `canScheduleExactNotifications()` and asks at runtime. If refused, it schedules inexact (`inexactAllowWhileIdle`) and relies on the 30-minute repeats. Already how `LocalNotificationScheduler` works. |
| Exact alarms without a prompt | `USE_EXACT_ALARM` | **Do not use.** Play limits it to calendar and alarm-clock apps. Buckets is a budgeting app. |
| Full-screen alarm | `USE_FULL_SCREEN_INTENT` | **Do not use.** On Android 14+ Play revokes it for apps that are not calling or alarm apps, and a Play Console declaration is required. The alarm is a high-importance notification that repeats until the payday is done. |
| Survive reboot | `RECEIVE_BOOT_COMPLETED` | Keep (reschedules notifications). |
| App lock | `USE_BIOMETRIC` | Keep. |
| Payment alerts | `NotificationListenerService` (user grants notification access in system settings) | Keep. Play Protect treats notification access as sensitive, so: only allow-listed payment-app packages are read; raw text stays on the device; screen 06 explains what is read and why before opening settings; the Play Data safety form and listing must say so. |
| SMS | `READ_SMS` / `RECEIVE_SMS` | **Never request.** Play restricts them to default SMS apps and a few exceptions behind a declaration form. Users paste SMS text instead (R-PROOF). |
| Network | `INTERNET` | None in release (ADR-0004). |

## Alternatives considered
- `USE_EXACT_ALARM` – no prompt, but Buckets would not qualify and could be rejected.
- Full-screen intent for the alarm – best wake-up, but needs a Play declaration Buckets cannot truthfully make and is off by default on Android 14+.
- Reading SMS directly – more reliable alerts, but a Play policy risk and a larger privacy ask.

## Consequences
- Release checklist for R-03 and any Play listing: (1) build the release APK and inspect the merged manifest (`app/build/app/intermediates/merged_manifests/release/`) for permissions that plugins add, especially `INTERNET` and `USE_FULL_SCREEN_INTENT`; (2) on Android 13, 14 and 15 test: notification permission refused, exact alarm refused, exact alarm revoked after granting; (3) complete the Play Data safety form, and re-read the "Permissions and APIs that access sensitive information" policy before upload, since this review could not confirm its current wording for notification listeners.
- Owner action: none now; the Play listing is out of V1 scope (dogfood APK first, R-03).
- Behaviour is unchanged by this ADR: the manifest and scheduler already match it.

## Sources
- Android 14: schedule exact alarms — https://developer.android.com/about/versions/14/changes/schedule-exact-alarms
- Full-screen intent limits — https://source.android.com/docs/core/permissions/fsi-limits
- Play: foreground service and full-screen intent requirements — https://support.google.com/googleplay/android-developer/answer/13392821
- Play: SMS and Call Log permissions policy — https://support.google.com/googleplay/android-developer/answer/10208820
- Play Protect: notification listener as a sensitive permission — https://developers.google.cn/android/play-protect/warning-dev-guidance
