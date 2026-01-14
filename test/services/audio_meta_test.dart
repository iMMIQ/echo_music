import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:audio_meta/audio_meta.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test audio_meta API', () {
    const testFile = '/home/ayd/音乐/iroha _ 镜音铃 (鏡音リン) - 炉心融解.ogg';

    // Use debugPrint instead of print for test output
    debugPrint('Testing audio_meta API...');
    debugPrint('File exists: ${File(testFile).existsSync()}');

    try {
      // Test with bytes constructor (audio_meta 2.0.0 API)
      debugPrint('Trying AudioMeta(bytes)...');
      final bytes = File(testFile).readAsBytesSync();
      final meta = AudioMeta(bytes);
      debugPrint('✓ AudioMeta(bytes) works!');
      debugPrint('Duration: ${meta.duration}');

      expect(meta.duration, isNotNull);
      expect(meta.duration.inSeconds, greaterThan(0));
    } catch (e) {
      debugPrint('✗ AudioMeta(bytes) failed: $e');
      rethrow;
    }
  });
}
