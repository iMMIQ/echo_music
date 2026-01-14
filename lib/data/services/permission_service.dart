import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

/// Permission service for handling app permissions
class PermissionService {
  /// Request storage permission for accessing music files
  Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      // Try the newer READ_MEDIA_AUDIO permission first (Android 13+)
      // If that fails, fall back to READ_EXTERNAL_STORAGE (Android < 13)
      bool permissionGranted = false;

      try {
        final status = await Permission.audio.request();
        permissionGranted = status.isGranted;
        if (!permissionGranted && status.isPermanentlyDenied) {
          await openAppSettings();
        }
      } catch (e) {
        // Permission.audio not available, try Permission.storage
        final status = await Permission.storage.request();
        permissionGranted = status.isGranted;
        if (!permissionGranted && status.isPermanentlyDenied) {
          await openAppSettings();
        }
      }

      return permissionGranted;
    } else if (Platform.isIOS) {
      // iOS doesn't need storage permission for music library
      return true;
    }
    return true;
  }

  /// Request notification permission for Android 13+
  Future<bool> requestNotificationPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.notification.request();
      return status.isGranted;
    }
    return true; // iOS doesn't need this
  }

  /// Request all necessary permissions
  Future<PermissionResult> requestAllPermissions() async {
    final results = PermissionResult()
      ..storageGranted = await requestStoragePermission()
      ..notificationGranted = await requestNotificationPermission();

    return results;
  }

  /// Check if all permissions are granted
  Future<bool> checkPermissions() async {
    if (Platform.isAndroid) {
      // Try both permission types
      bool audioGranted = false;
      bool storageGranted = false;

      try {
        audioGranted = await Permission.audio.status.isGranted;
      } catch (e) {
        // Permission.audio not available on this Android version
      }

      try {
        storageGranted = await Permission.storage.status.isGranted;
      } catch (e) {
        // Permission.storage not available on this Android version
      }

      // At least one storage permission should be granted
      return audioGranted || storageGranted;
    }
    return true;
  }
}

/// Result of permission request
class PermissionResult {
  bool storageGranted = false;
  bool notificationGranted = false;
}
