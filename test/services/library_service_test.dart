import 'package:echo_music/data/services/metadata_service.dart';
import 'package:echo_music/data/services/metadata_service_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FilePicker Extensions', () {
    late MetadataService metadataService;

    setUp(() {
      metadataService = MetadataServiceImpl();
    });

    test('should convert extensions with dots to without dots for FilePicker', () {
      final extensionsWithDots = metadataService.supportedExtensions;
      final extensionsWithoutDots = extensionsWithDots
          .map((e) => e.replaceFirst('.', ''))
          .toList();

      debugPrint('Extensions with dots: $extensionsWithDots');
      debugPrint('Extensions without dots: $extensionsWithoutDots');

      // Verify all extensions are converted correctly
      expect(extensionsWithoutDots, contains('mp3'));
      expect(extensionsWithoutDots, contains('ogg'));
      expect(extensionsWithoutDots, contains('flac'));
      expect(extensionsWithoutDots, contains('wav'));
      expect(extensionsWithoutDots, contains('m4a'));
      expect(extensionsWithoutDots, contains('opus'));
      expect(extensionsWithoutDots, contains('wma'));
      expect(extensionsWithoutDots, contains('aac'));

      // Verify none have dots
      for (final ext in extensionsWithoutDots) {
        expect(ext.startsWith('.'), isFalse,
            reason: 'Extension "$ext" should not start with a dot');
      }
    });
  });
}
