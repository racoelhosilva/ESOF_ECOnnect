import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/database.dart';
import 'package:econnect/model/user.dart';
import 'package:econnect/view/post/widgets/post_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
    final user = User(
        id: '123',
        email: 'test@example.com',
        username: 'testuser',
        profilePicture: '',
        score: 0,
        registerDatetime: DateTime.now(),
        isBlocked: false,
        admin: false);

    await tester.pumpWidget(
      MaterialApp(initialRoute: '/createpost', routes: {
        '/home': (_) => const Text('Home Page'),
        '/createpost': (_) => Scaffold(
              body: PostButton(
                dbController: databaseController,
                postController: TextEditingController(),
                imagePath: 'testImagePath',
                user: user,
              ),
            ),
      }),
    );

    await tester.tap(find.byType(PostButton));
    await tester.pump();

    verify(databaseController.createPost(
            user: "user", imgPath: 'testImagePath', description: ''))
        .called(1);
  });

  testWidgets('No image selected when imagePath is null',
      (WidgetTester tester) async {
    final user = User(
        id: '123',
        email: 'test@example.com',
        username: 'testuser',
        profilePicture: '',
        score: 0,
        registerDatetime: DateTime.now(),
        isBlocked: false,
        admin: false);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PostButton(
            dbController: databaseController,
            postController: TextEditingController(),
            imagePath: null,
            user: user,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Publish'));
    await tester.pump();

    verifyNever(databaseController.createPost(
        user: "user", imgPath: 'testImagePath', description: ''));
  });
}
