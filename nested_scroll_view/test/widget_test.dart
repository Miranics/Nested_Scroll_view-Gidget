// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:nested_scroll_view/main.dart';

void main() {
  testWidgets('App builds and shows Gallery tab', (WidgetTester tester) async {
    // Build the demo app and verify the Gallery tab is present.
    await tester.pumpWidget(const DemoApp());
    await tester.pumpAndSettle();

    expect(find.text('Gallery'), findsOneWidget);
  });
}
