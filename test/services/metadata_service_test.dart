import 'package:echo_music/data/services/metadata_service.dart';
import 'package:echo_music/data/services/metadata_service_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MetadataService', () {
    late MetadataService metadataService;

    setUp(() {
      metadataService = MetadataServiceImpl();
    });

    test('should recognize OGG files as supported format', () {
      // Test various OGG file paths
      expect(metadataService.isSupportedFormat('/path/to/file.ogg'), isTrue);
      expect(metadataService.isSupportedFormat('/path/to/file.OGG'), isTrue);
      expect(metadataService.isSupportedFormat('/path/to/iroha _ 鏡音鈴 (鏡音リン) - 炉心融解.ogg'), isTrue);
      expect(metadataService.isSupportedFormat('/home/ayd/音乐/test.ogg'), isTrue);
    });

    test('should support all expected extensions', () {
      final extensions = metadataService.supportedExtensions;
      debugPrint('Supported extensions: $extensions');

      expect(extensions, contains('.mp3'));
      expect(extensions, contains('.ogg'));
      expect(extensions, contains('.flac'));
      expect(extensions, contains('.wav'));
      expect(extensions, contains('.m4a'));
      expect(extensions, contains('.opus'));
      expect(extensions, contains('.wma'));
      expect(extensions, contains('.aac'));
    });

    test('should not support non-audio files', () {
      expect(metadataService.isSupportedFormat('/path/to/file.txt'), isFalse);
      expect(metadataService.isSupportedFormat('/path/to/file.pdf'), isFalse);
      expect(metadataService.isSupportedFormat('/path/to/file.mp4'), isFalse);
    });

    test('FilePicker extensions should be without dots', () {
      final extensions = metadataService.supportedExtensions;
      debugPrint('Extensions for FilePicker: ${extensions.map((e) => e.replaceFirst('.', ''))}');
    });
  });
}
