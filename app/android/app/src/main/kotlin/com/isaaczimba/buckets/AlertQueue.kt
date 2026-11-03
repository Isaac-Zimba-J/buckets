package com.isaaczimba.buckets

import android.content.Context
import org.json.JSONArray
import org.json.JSONObject

/**
 * Captured payment notifications waiting for the app to drain them. Kept in
 * app-private storage; the text never leaves the device or reaches a log.
 */
class AlertQueue(context: Context) {
    private val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)

    /** Adds a capture, dropping the oldest beyond [MAX_SIZE]. */
    fun add(packageName: String, text: String, postedAtMillis: Long) = synchronized(LOCK) {
        val queue = read()
        queue.put(
            JSONObject()
                .put("package", packageName)
                .put("text", text)
                .put("postedAt", postedAtMillis),
        )
        while (queue.length() > MAX_SIZE) queue.remove(0)
        prefs.edit().putString(KEY, queue.toString()).apply()
    }

    /** Returns every capture, oldest first, and empties the queue. */
    fun drain(): List<Map<String, Any>> = synchronized(LOCK) {
        val queue = read()
        prefs.edit().remove(KEY).apply()
        (0 until queue.length()).map { i ->
            val item = queue.getJSONObject(i)
            mapOf(
                "package" to item.getString("package"),
                "text" to item.getString("text"),
                "postedAt" to item.getLong("postedAt"),
            )
        }
    }

    private fun read(): JSONArray = JSONArray(prefs.getString(KEY, "[]"))

    companion object {
        private const val PREFS = "payment_alert_queue"
        private const val KEY = "queue"
        private const val MAX_SIZE = 500
        private val LOCK = Any()
    }
}
