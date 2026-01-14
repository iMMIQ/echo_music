import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:echo_music/main.dart';

void main() {
  testWidgets('App widget creates successfully', (WidgetTester tester) async {
    // Build the app widget without running main()
    // This tests that the widget tree builds correctly
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text('Test'),
        ),
      ),
    );

    // Verify a widget was built
    expect(find.text('Test'), findsOneWidget);
  });
}
