# Keep Flutter Local Notifications package
-keep class com.dexterous.** { *; }

# Keep Firebase Messaging classes
-keep class com.google.firebase.messaging.** { *; }
-keep class io.flutter.plugins.firebase.messaging.** { *; }

# Ensure WorkManager works correctly
-keep class androidx.work.** { *; }

# Keep reflection-based code for Flutter plugins
-keep class io.flutter.embedding.engine.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep classes related to Android AlarmManager and NotificationManager
-keep class android.app.NotificationManager { *; }
-keep class android.app.AlarmManager { *; }
-keep class android.app.NotificationChannel { *; }
-keep class androidx.core.app.NotificationCompat { *; }
-keep class android.app.PendingIntent { *; }

# Keep Flutter plugin classes (e.g., flutter_local_notifications)
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# Keep Firebase Messaging Service (if using Firebase)
-keep class com.google.firebase.messaging.FirebaseMessagingService { *; }
-keep class com.google.firebase.** { *; }

# Keep reflection-based classes (prevents runtime crashes)
-keepattributes *Annotation*
-keep class * {
    @androidx.annotation.Keep *;
}

# Prevent ProGuard from removing methods required for notifications
-dontwarn com.dexterous.**
-dontwarn com.google.firebase.messaging.**
-dontwarn io.flutter.plugins.firebase.messaging.**

# Keep Google Play related classes
-keep class com.google.android.play.** { *; }
-dontwarn com.google.android.play.**
