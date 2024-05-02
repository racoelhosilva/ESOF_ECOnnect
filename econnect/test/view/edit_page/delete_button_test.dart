import 'package:econnect/view/post/widgets/delete_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';

void main() {
  testWidgets('DeleteButton onPressed callback is called when pressed',
      (WidgetTester tester) async {
    bool onPressedCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DeleteButton(
            onPressed: () {
              onPressedCalled = true;
            },
          ),
        ),
      ),
    );

    final deleteButtonFinder = find.byType(FloatingActionButton);
    expect(deleteButtonFinder, findsOneWidget);

    await tester.tap(deleteButtonFinder);
    await tester.pump();

    expect(onPressedCalled, true);
  });

  testWidgets('DeleteButton icon',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DeleteButton(
            onPressed: () {},
          ),
        ),
      ),
    );

    final deleteButtonFinder = find.byType(FloatingActionButton);
    expect(deleteButtonFinder, findsOneWidget);
    expect(find.byIcon(LucideIcons.trash2), findsOneWidget);

  });

  
}