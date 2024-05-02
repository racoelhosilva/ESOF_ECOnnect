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

  testWidgets('FollowButton initializes correctly based on following status',
      (WidgetTester tester) async {
    when(sessionController.isFollowing(any, any)).thenAnswer((_) async => true);

    await tester.pumpWidget(
      MaterialApp(
        home: FollowButton(
          dbController: dbController,
          sessionController: sessionController,
          posterId: 'poster_id',
        ),
      ),
    );

    expect(find.byIcon(Icons.star), findsOneWidget);
  });

  testWidgets('FollowButton toggles following status and updates UI',
      (WidgetTester tester) async {
    when(sessionController.isFollowing(any, any))
        .thenAnswer((_) async => false);

    await tester.pumpWidget(
      MaterialApp(
        home: FollowButton(
          dbController: dbController,
          sessionController: sessionController,
          posterId: 'poster_id',
        ),
      ),
    );

    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.star), findsOneWidget);
  });
}
