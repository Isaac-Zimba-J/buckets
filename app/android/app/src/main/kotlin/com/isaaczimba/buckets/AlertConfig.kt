package com.isaaczimba.buckets

/** Which apps' notifications may be read as payment alerts (ARCHITECTURE §6). */
object AlertConfig {
    /**
     * Android package IDs of the MTN MoMo app, the Airtel Money app, the
     * SMS app(s) and the Google/Samsung/AOSP messaging apps. Empty until the
     * owner confirms them (PROGRESS Open question 2): with an empty list
     * nothing is ever captured.
     * SMS texts are parsed in Dart; non-payment SMS are dropped there.
     */
    val allowedPackages: Set<String> = setOf(
        "com.airtel.africa.selfcare",  // Airtel Money ZM
        "mtnft.momo.consumer",         // MTN MoMo ZM
        "com.google.android.apps.messaging",  // Google Messages
        "com.samsung.android.messaging",       // Samsung Messages
        "com.android.mms",                     // AOSP/Xiaomi/Tecno/Infinix
        "com.android.messaging",               // AOSP Messaging
    )
}
