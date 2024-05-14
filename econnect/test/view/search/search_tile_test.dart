import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/user.dart';
import 'package:econnect/view/profile/widgets/follow_button.dart';
import 'package:econnect/view/search/widgets/search_result_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'search_tile_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DatabaseController>(),
  MockSpec<SessionController>(),
])

void main() {
  late DatabaseController dbController;
  late SessionController sessionController;

  setUp(() => {
    dbController = MockDatabaseController(),
    sessionController = MockSessionController(),
  });

  testWidgets('Renders subcomponents correctly', (WidgetTester tester) async {
    final user = User(
      id: '123456789',
      username: 'johndoe',
      email: 'johndoe@example.com',
      score: 100,
      isBlocked: false,
      registerDatetime: DateTime.now(),
      admin: false,
      profilePicture: 'https://example.com/profile.jpg',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SearchResultTile(
            dbController: dbController,
            sessionController: sessionController,
            user: user,
          ),
        ),
      ),
    );
    
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.text(user.username), findsOneWidget);
    expect(find.byType(FollowButton), findsOneWidget);
  });

  testWidgets('Goes to profile picture when tile is tapped', (WidgetTester tester) async {
    final user = User(
      id: '123456789',
      username: 'johndoe',
      email: 'johndoe@example.com',
      score: 100,
      isBlocked: false,
      registerDatetime: DateTime.now(),
      admin: false,
      profilePicture: 'https://example.com/profile.jpg',
    );

    await tester.pumpWidget(
      MaterialApp(
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/profile':
              return MaterialPageRoute<Widget>(
                settings: settings,
                builder: (_) => Text('User ${settings.arguments} Page'),
              );
            case '/':
              return MaterialPageRoute<Widget>(
                settings: settings,
                builder: (_) => Scaffold(
                  body: SearchResultTile(
                    dbController: dbController,
                    sessionController: sessionController,
                    user: user,
                  ),
                )
              );
            default:
              throw Exception('Route not found');
          }
        }
      ),
    );

    await tester.tap(find.byType(SearchResultTile));
    await tester.pumpAndSettle();

    expect(find.text('User ${user.id} Page'), findsOneWidget);
  });
}