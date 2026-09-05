// Basic smoke test for the Flutter Docs app.
// It verifies the app builds and shows the stage "desktop".

import 'package:flutter_test/flutter_test.dart';

import 'package:mi_primer_app/main.dart';

void main() {
  testWidgets('Flutter Docs shows the stage desktop', (WidgetTester tester) async {
    await tester.pumpWidget(const FlutterDocs());

    // The stage cards for the available stages are shown.
    expect(find.text('Etapa 1 · Fundamentos'), findsNothing);
    expect(find.text('Fundamentos'), findsOneWidget);
  });
}