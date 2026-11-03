package com.isaaczimba.buckets

import android.app.Notification
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification

/**
 * Reads notifications posted by the allow-listed payment apps only
 * (ARCHITECTURE §6) and queues their text for the app. Parsing happens in
 * Dart (domain `SmsParser`) when the app drains the queue.
 */
class PaymentAlertListenerService : NotificationListenerService() {
    override fun onNotificationPosted(sbn: StatusBarNotification) {
        if (sbn.packageName !in AlertConfig.allowedPackages) return
        val extras = sbn.notification.extras
        val body = extras.getCharSequence(Notification.EXTRA_BIG_TEXT)
            ?: extras.getCharSequence(Notification.EXTRA_TEXT)
        val text = listOfNotNull(extras.getCharSequence(Notification.EXTRA_TITLE), body)
            .joinToString("\n")
        if (text.isBlank()) return
        AlertQueue(applicationContext).add(sbn.packageName, text, sbn.postTime)
    }
}
