import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

/// Permission service for handling app permissions
class PermissionService {
  /// Request storage permission for accessing music files
  Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      // Android 13+ uses READ_MEDIA_AUDIO
      if (Platform.version.contains('33') ||
          Platform.version.contains('34') ||
          Platform.version.contains('35')) {
        final status = await Permission.audio.request();
        return status.isGranted;
      } else {
        // Older Android versions use READ_EXTERNAL_STORAGE
        final status = await Permission.storage.request();
        if (status.isGranted) {
          return true;
        } else if (status.isPermanentlyDenied) {
          // Show dialog to open app settings
          await openAppSettings();
          return false;
        }
        return false;
      }
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
    final results = PermissionResult();

    // Request storage permission
    results.storageGranted = await requestStoragePermission();

    // Request notification permission
    results.notificationGranted = await requestNotificationPermission();

    return results;
  }

  /// Check if all permissions are granted
  Future<bool> checkPermissions() async {
    if (Platform.isAndroid) {
      // Android 13+ uses READ_MEDIA_AUDIO
      if (Platform.version.contains('33') ||
          Platform.version.contains('34') ||
          Platform.version.contains('35')) {
        final audioStatus = await Permission.audio.status;
        final notificationStatus = await Permission.notification.status;
        return audioStatus.isGranted && notificationStatus.isGranted;
      } else {
        final storageStatus = await Permission.storage.status;
        return storageStatus.isGranted;
      }
    }
    return true;
  }
}

/// Result of permission requests
class PermissionResult {
  bool storageGranted = false;
  bool notificationGranted = false;
  bool get allGranted => storageGranted && notificationGranted;
}
