import 'package:echo_music/data/services/metadata_service.dart';
import 'package:echo_music/data/services/metadata_service_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OGG Duration Test', () {
    late MetadataService metadataService;

    setUp(() {
      metadataService = MetadataServiceImpl();
    });

    test('test actual OGG file duration extraction', () async {
      const testFile = '/home/ayd/音乐/iroha _ 镜音铃 (鏡音リン) - 炉心融解.ogg';

      print('Extracting metadata from: $testFile');
      final metadata = await metadataService.extractMetadata(testFile);

      print('\n=== Metadata Results ===');
      print('Title: ${metadata.title}');
      print('Artist: ${metadata.artist}');
      print('Album: ${metadata.album}');
      print('Duration: ${metadata.duration}');
      print('Duration in seconds: ${metadata.duration.inSeconds}');
      print('Duration in minutes: ${metadata.duration.inMinutes}.${(metadata.duration.inSeconds % 60).toString().padLeft(2, '0')}');
      print('=======================\n');

      // Expected duration is 5:33 (333 seconds)
      const expectedDurationSeconds = 333;
      final actualDurationSeconds = metadata.duration.inSeconds;

      print('Expected: $expectedDurationSeconds seconds (5:33)');
      print('Actual: $actualDurationSeconds seconds');

      if (actualDurationSeconds != expectedDurationSeconds) {
        print('\n❌ DURATION MISMATCH!');
        print('The metadata_god package did not extract the correct duration.');
        print('We need to use an alternative method to get the duration.');
      } else {
        print('\n✅ Duration is correct!');
      }
    });
  });
}
