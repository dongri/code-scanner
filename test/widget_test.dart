// This is a basic Flutter widget test.

import 'package:flutter_test/flutter_test.dart';
import 'package:code_scanner/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CodeScanApp());

    // Verify basic app structure
    expect(find.text('CODE SCANNER'), findsOneWidget);
  });
}
