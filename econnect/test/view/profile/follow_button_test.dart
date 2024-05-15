import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/view/profile/widgets/follow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'follow_button_test.mocks.dart';

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

  testWidgets('FollowButton initializes correctly when user follows the other',
      (WidgetTester tester) async {
    when(sessionController.isFollowing(any, any))
        .thenAnswer((_) => Future.value(true));

    await tester.pumpWidget(
      MaterialApp(
        home: FollowButton(
          dbController: dbController,
          sessionController: sessionController,
          posterId: 'poster_id',
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.star), findsOneWidget);
  });

  testWidgets(
      'FollowButton initializes correctly when user does not follow the other',
      (WidgetTester tester) async {
    when(sessionController.isFollowing(any, any))
        .thenAnswer((_) => Future.value(false));

    await tester.pumpWidget(
      MaterialApp(
        home: FollowButton(
          dbController: dbController,
          sessionController: sessionController,
          posterId: 'poster_id',
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.star_border), findsOneWidget);
  });

  testWidgets(
      'FollowButton toggles following status when pressed and updates UI',
      (WidgetTester tester) async {
    when(sessionController.isFollowing(any, dbController))
        .thenAnswer((_) async => false);
    when(sessionController.followUser(any, dbController))
        .thenAnswer((_) => Future.value());
    when(sessionController.unfollowUser(any, dbController))
        .thenAnswer((_) => Future.value());

    await tester.pumpWidget(
      MaterialApp(
        home: FollowButton(
          dbController: dbController,
          sessionController: sessionController,
          posterId: 'poster_id',
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.star_border), findsOneWidget);
    verifyNever(sessionController.followUser(any, dbController));
    verifyNever(sessionController.followUser(any, dbController));

    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();
    verify(sessionController.followUser('poster_id', dbController)).called(1);

    expect(find.byIcon(Icons.star), findsOneWidget);

    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();
    verify(sessionController.unfollowUser('poster_id', dbController)).called(1);

    expect(find.byIcon(Icons.star_border), findsOneWidget);
  });
}
