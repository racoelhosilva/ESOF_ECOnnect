import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:econnect/model/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:econnect/view/search/search_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_page_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DatabaseController>(),
  MockSpec<SessionController>(),
])
void main() {
  late MockDatabaseController dbController;
  late MockSessionController sessionController;

  setUp(() {
    dbController = MockDatabaseController();
    sessionController = MockSessionController();
  });
  testWidgets('Initial page loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SearchPage(
          dbController: dbController,
          sessionController: sessionController,
        ),
      ),
    );

    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Searching for users returns the correct widgets',
      (WidgetTester tester) async {
    final List<User> mockUsers = [
      User(
        id: '123',
        email: 'test1@example.com',
        username: 'test1',
        score: 0,
        isBlocked: false,
        registerDatetime: DateTime.now(),
        admin: false,
        profilePicture: '',
      ),
      User(
        id: '124',
        email: 'test2@example.com',
        username: 'test2',
        score: 0,
        isBlocked: false,
        registerDatetime: DateTime.now(),
        admin: false,
        profilePicture: '',
      ),
      User(
        id: '125',
        email: 'test3@example.com',
        username: 'test3',
        score: 0,
        isBlocked: false,
        registerDatetime: DateTime.now(),
        admin: false,
        profilePicture: '',
      ),
    ];

    when(dbController.searchUsers('search query'))
        .thenAnswer((_) async => mockUsers);

    await tester.pumpWidget(
      MaterialApp(
        home: SearchPage(
          dbController: dbController,
          sessionController: sessionController,
        ),
      ),
    );

    await tester.tap(find.byType(TextField));
    await tester.enterText(find.byType(TextField), 'search query');

    //expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();

    //expect(find.byType(CircularProgressIndicator), findsNothing);

    expect(find.byType(ListTile), findsNWidgets(3));
  });
}
