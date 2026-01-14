import 'dart:io';

import 'package:audio_meta/audio_meta.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test audio_meta API', () {
    const testFile = '/home/ayd/音乐/iroha _ 镜音铃 (鏡音リン) - 炉心融解.ogg';

    print('Testing audio_meta API...');
    print('File exists: ${File(testFile).existsSync()}');

    try {
      // Try different API methods
      print('Trying AudioMeta.fromPath...');
      final meta1 = AudioMeta.fromPath(testFile);
      print('✓ AudioMeta.fromPath works!');
      print('Duration: ${meta1.duration}');
    } catch (e) {
      print('✗ AudioMeta.fromPath failed: $e');
    }

    try {
      print('Trying AudioMeta.fromFile...');
      final meta2 = AudioMeta.fromFile(File(testFile));
      print('✓ AudioMeta.fromFile works!');
      print('Duration: ${meta2.duration}');
    } catch (e) {
      print('✗ AudioMeta.fromFile failed: $e');
    }

    try {
      print('Trying AudioMeta.fromBytes...');
      final bytes = File(testFile).readAsBytesSync();
      final meta3 = AudioMeta.fromBytes(bytes);
      print('✓ AudioMeta.fromBytes works!');
      print('Duration: ${meta3.duration}');
    } catch (e) {
      print('✗ AudioMeta.fromBytes failed: $e');
    }
  });
}
