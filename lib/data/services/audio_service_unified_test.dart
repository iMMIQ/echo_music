import 'package:flutter_test/flutter_test.dart';
import 'package:media_kit/media_kit.dart';

import 'package:echo_music/data/services/audio_service.dart';
import 'package:echo_music/data/services/audio_service_unified.dart';

void main() {
  setUpAll(() {
    MediaKit.ensureInitialized();
  });

  group('UnifiedAudioService', () {
    test('should create Player instance on initialization', () {
      final service = UnifiedAudioService();
      expect(service.player, isNotNull);
      service.dispose();
    });

    test('should implement AudioService interface', () {
      final service = UnifiedAudioService();
      expect(service, isA<AudioService>());
      service.dispose();
    });
  });
}
