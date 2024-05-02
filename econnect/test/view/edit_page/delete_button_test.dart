import 'package:econnect/view/post/widgets/delete_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../controller/session_controller_test.mocks.dart';

void main() {
  late MockDatabaseController mockDbController;

  setUp(() {
    mockDbController = MockDatabaseController();
  });

  testWidgets('DeleteButton onPressed callback test',
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

    await tester.tap(find.text('Delete'));
    expect(onPressedCalled, true);
  });

  testWidgets('DeleteButton deleting post test', (WidgetTester tester) async {
    const String postId = '123';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DeleteButton(
            onPressed: () async {
              await mockDbController.deletePost(postId);
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    verify(mockDbController.deletePost(postId)).called(1);
  });
}
