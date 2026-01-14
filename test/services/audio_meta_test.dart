import 'dart:io';

import 'package:audio_meta/audio_meta.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test audio_meta API', () {
    const testFile = '/home/ayd/音乐/iroha _ 镜音铃 (鏡音リン) - 炉心融解.ogg';

    // Skip test if file doesn't exist (e.g., in CI environment)
    if (!File(testFile).existsSync()) {
      return;
    }

    try {
      // Test with bytes constructor (audio_meta 2.0.0 API)
      final bytes = File(testFile).readAsBytesSync();
      final meta = AudioMeta(bytes);

      expect(meta.duration, isNotNull);
      expect(meta.duration.inSeconds, greaterThan(0));
    } catch (e) {
      fail('AudioMeta(bytes) failed: $e');
    }
  });
}
