import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/user.dart';
import 'package:econnect/view/settings/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_button_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DatabaseController>(),
  MockSpec<SessionController>(),
  MockSpec<TextEditingController>(),
])
void main() {
  group('SaveButton Widget Tests', () {
    late MockDatabaseController dbController;
    late MockSessionController sessionController;
    late MockTextEditingController usernameController;
    late MockTextEditingController descriptionController;

    setUp(() {
      dbController = MockDatabaseController();
      sessionController = MockSessionController();
      usernameController = MockTextEditingController();
      descriptionController = MockTextEditingController();
    });

    testWidgets(
        'SaveButton widget displays CircularProgressIndicator when loading',
        (WidgetTester tester) async {
      when(sessionController.loggedInUser).thenReturn(User(
        id: '1',
        email: 'test@example.com',
        username: 'user',
        description: 'description',
        profilePicture: 'picture.jpg',
        score: 0,
        isBlocked: false,
        registerDatetime: DateTime.now(),
        admin: false,
      ));
      when(sessionController.updateUser(any, any)).thenAnswer(
          (_) async => await Future.delayed(const Duration(seconds: 20)));

      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/home': (_) => Scaffold(
                  body: SaveButton(
                    dbController: dbController,
                    sessionController: sessionController,
                    usernameController: usernameController,
                    descriptionController: descriptionController,
                    newProfilePicturePath: 'photo.png',
                  ),
                ),
            '/profile': (_) => const Text('Profile Page'),
          },
          initialRoute: '/home',
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();
    });

    testWidgets(
        'SaveButton widget updates user and navigates to profile page on press',
        (WidgetTester tester) async {
      final oldUser = User(
        id: '1',
        email: 'test@example.com',
        username: 'OldUsername',
        description: 'OldDescription',
        profilePicture: 'old_picture.jpg',
        score: 0,
        isBlocked: false,
        registerDatetime: DateTime.now(),
        admin: false,
      );

      int i = 0;
      when(sessionController.loggedInUser).thenReturn(oldUser);
      when(sessionController.updateUser(any, any)).thenAnswer((_) async => i++);
      when(usernameController.text).thenReturn('NewUsername');
      when(descriptionController.text).thenReturn('NewDescription');

      await tester.pumpWidget(
        MaterialApp(
          initialRoute: '/home',
          routes: {
            '/home': (context) => Scaffold(
                  body: SaveButton(
                    dbController: dbController,
                    sessionController: sessionController,
                    usernameController: usernameController,
                    descriptionController: descriptionController,
                    newProfilePicturePath: 'photo.png',
                  ),
                ),
            '/profile': (context) => const Scaffold(),
          },
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      verify(sessionController.updateUser(any, dbController)).called(1);
    });
  });
}
