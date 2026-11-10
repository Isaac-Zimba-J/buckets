package com.isaaczimba.buckets

import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.core.app.NotificationManagerCompat
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

// local_auth needs a FragmentActivity for its system prompt.
class MainActivity : FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "drain" -> result.success(AlertQueue(applicationContext).drain())
                    "isEnabled" -> result.success(
                        NotificationManagerCompat.getEnabledListenerPackages(this)
                            .contains(packageName),
                    )
                    "openSettings" -> {
                        startActivity(Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS))
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SUPPORT_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "composeEmail" -> result.success(
                        composeEmail(
                            call.argument<String>("to").orEmpty(),
                            call.argument<String>("subject").orEmpty(),
                            call.argument<String>("body").orEmpty(),
                        ),
                    )
                    "openNotificationAccess" -> {
                        startActivity(Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS))
                        result.success(null)
                    }
                    "openBatterySettings" -> {
                        startActivity(
                            Intent(
                                Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
                                Uri.fromParts("package", packageName, null),
                            ),
                        )
                        result.success(null)
                    }
                    "openStoreListing" -> {
                        openStoreListing()
                        result.success(null)
                    }
                    "appInfo" -> result.success(appInfo())
                    else -> result.notImplemented()
                }
            }
    }

    private fun composeEmail(to: String, subject: String, body: String): Boolean {
        val intent = Intent(Intent.ACTION_SENDTO).apply {
            data = Uri.parse("mailto:")
            putExtra(Intent.EXTRA_EMAIL, arrayOf(to))
            putExtra(Intent.EXTRA_SUBJECT, subject)
            putExtra(Intent.EXTRA_TEXT, body)
        }
        return try {
            startActivity(intent)
            true
        } catch (e: ActivityNotFoundException) {
            false
        }
    }

    private fun openStoreListing() {
        val market = Intent(
            Intent.ACTION_VIEW,
            Uri.parse("market://details?id=$packageName"),
        )
        try {
            startActivity(market)
        } catch (e: ActivityNotFoundException) {
            startActivity(
                Intent(
                    Intent.ACTION_VIEW,
                    Uri.parse(
                        "https://play.google.com/store/apps/details?id=$packageName",
                    ),
                ),
            )
        }
    }

    private fun appInfo(): Map<String, String> {
        val info = packageManager.getPackageInfo(packageName, 0)
        val code = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            info.longVersionCode.toString()
        } else {
            @Suppress("DEPRECATION")
            info.versionCode.toString()
        }
        return mapOf(
            "appVersion" to (info.versionName ?: ""),
            "buildNumber" to code,
            "androidVersion" to Build.VERSION.RELEASE,
            "deviceModel" to Build.MODEL,
        )
    }

    companion object {
        /** Must match `AndroidPaymentAlertSource.channel` in buckets_data. */
        const val CHANNEL = "com.isaaczimba.buckets/payment_alerts"

        /** Must match `supportChannelName` in buckets_data. */
        const val SUPPORT_CHANNEL = "com.isaaczimba.buckets/support"
    }
}
