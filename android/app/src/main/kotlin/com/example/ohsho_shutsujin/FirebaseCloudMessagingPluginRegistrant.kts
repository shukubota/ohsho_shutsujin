package com.shukubota.ohsho_shutsujin
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin
object FirebaseCloudMessagingPluginRegistrant {
    fun registerWith(registry: PluginRegistry?) {
        if (alreadyRegisteredWith(registry)) {
            return
        }
        FlutterFirebaseMessagingPlugin.registerWith(
                registry?.registrarFor(
                        "io.flutter.plugins.firebase.messaging.FirebaseMessagingPlugin"))
    }
    private fun alreadyRegisteredWith(registry: PluginRegistry?): Boolean {
        val key: String? = FirebaseCloudMessagingPluginRegistrant::class.java.canonicalName
        if (registry?.hasPlugin(key)!!) {
            return true
        }
        registry.registrarFor(key)
        return false
    }
}