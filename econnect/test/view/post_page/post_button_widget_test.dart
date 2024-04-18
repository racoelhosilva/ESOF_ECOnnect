import 'package:econnect/model/database.dart';
import 'package:econnect/view/post/widgets/post_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:econnect/controller/database_controller.dart';
import 'package:mockito/mockito.dart';

import '../../controller/database_controller_test.mocks.dart';

void main() {
  late DatabaseController databaseController;
  late Database database;

  setUp(() {
    database = MockDatabase();
    databaseController = DatabaseController(db: database);
  });

  testWidgets('Creates post', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PostButton(
            dbController: databaseController,
            postController: TextEditingController(),
            imagePath: 'testImagePath',
          ),
        ),
      ),
    );

    await tester.tap(find.byType(PostButton));
    await tester.pump();

    verify(databaseController.createPost("user", "", 'testImagePath', ''))
        .called(1);
  });

  testWidgets('No image selected when imagePath is null',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PostButton(
            dbController: databaseController,
            postController: TextEditingController(),
            imagePath: null,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Publish'));
    await tester.pump();

    verifyNever(databaseController.createPost("user", "", 'testImagePath', ''));
  });
}
