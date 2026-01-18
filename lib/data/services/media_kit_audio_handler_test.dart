import 'package:flutter_test/flutter_test.dart';
import 'package:media_kit/media_kit.dart';
import 'package:echo_music/data/services/media_kit_audio_handler.dart';

void main() {
  setUpAll(() {
    MediaKit.ensureInitialized();
  });

  group('MediaKitAudioHandler', () {
    test('should create Player on initialization', () {
      final handler = MediaKitAudioHandler();
      expect(handler.player, isNotNull);
      handler.dispose();
    });
  });
}
