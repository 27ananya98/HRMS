package com.rozgar.hrms

import android.os.Build
import android.provider.Settings
import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
class MainActivity: FlutterActivity() {
    private val CHANNEL = "flutter.native/kotlin_helper"
    private lateinit var locationHandler: LocationHandler
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        locationHandler = LocationHandler(this)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "isDeveloperOptionsEnabled") {
                val isEnabled = isDeveloperOptionsEnabled()
                result.success(isEnabled)
            } else if (call.method == "getCurrentLocation") {
                locationHandler.getCurrentLocation(
                    onSuccess = { latitude, longitude ->
                        val locationMap = mapOf(
                            "latitude" to latitude,
                            "longitude" to longitude
                        )
                        result.success(locationMap)
                    },
                    onError = { errorMessage ->
                        result.error("LOCATION_ERROR", errorMessage, null)
                    }
                )
            } else {
                result.notImplemented()
            }
        }
    }

    private fun isDeveloperOptionsEnabled(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
            Settings.Secure.getInt(
                applicationContext.contentResolver,
                Settings.Global.DEVELOPMENT_SETTINGS_ENABLED,
                0
            ) != 0
        } else {
            false
        }
    }
}
