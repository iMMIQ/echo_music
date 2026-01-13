import 'package:echo_music/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App starts successfully', (WidgetTester tester) async {
    // Wrap app with ProviderScope for Riverpod
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Trigger a frame
    await tester.pump();

    // Verify that the app builds without throwing
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
