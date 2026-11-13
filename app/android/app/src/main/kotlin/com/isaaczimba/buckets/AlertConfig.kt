package com.isaaczimba.buckets

/** Which apps' notifications may be read as payment alerts (ARCHITECTURE §6). */
object AlertConfig {
    /**
     * Android package IDs of the MTN MoMo app, the Airtel Money app and the
     * SMS app(s). Empty until the owner confirms them (PROGRESS Open
     * question 2): with an empty list nothing is ever captured.
     */
    val allowedPackages: Set<String> = setOf(
        "com.airtel.africa.selfcare",  // Airtel Money ZM
        "mtnft.momo.consumer",         // MTN MoMo ZM
    )
}
