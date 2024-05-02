import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:econnect/view/settings/widgets/username_field.dart';

void main() {
  testWidgets('UsernameField widget renders correctly',
      (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UsernameField(controller: controller),
        ),
      ),
    );

    expect(find.text('Username'), findsOneWidget);

    expect(find.byType(TextField), findsOneWidget);

    expect((tester.widget(find.byType(TextField)) as TextField).controller,
        controller);

    expect((tester.widget(find.byType(TextField)) as TextField).maxLength, 25);

    expect(
      (tester.widget(find.byType(TextField)) as TextField).decoration!.hintText,
      'Write your username here...',
    );
  });

  testWidgets('UsernameField widget updates controller value',
      (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UsernameField(controller: controller),
        ),
      ),
    );

    // Simulate entering text into the TextField
    await tester.enterText(find.byType(TextField), 'TestUsername');

    // Verify if the controller value is updated
    expect(controller.text, 'TestUsername');
  });
}
