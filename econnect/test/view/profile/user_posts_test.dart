import 'package:cached_network_image/cached_network_image.dart';
import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/view/profile/widgets/user_posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_posts_test.mocks.dart';

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

  testWidgets('UserPosts renders correctly with posts',
      (WidgetTester tester) async {
    final List<Post> mockPosts = [
      Post(
        user: 'user_id_1',
        image: 'post_image_1',
        description: 'Description for post 1',
        postDatetime: DateTime.now(),
      ),
      Post(
        user: 'user_id_2',
        image: 'post_image_2',
        description: 'Description for post 2',
        postDatetime: DateTime.now(),
      ),
    ];

    when(dbController.getPostsFromUser(any)).thenAnswer((_) async => mockPosts);

    await tester.pumpWidget(
      MaterialApp(
        home: UserPosts(
          dbController: dbController,
          sessionController: sessionController,
          userId: 'user_id',
        ),
      ),
    );

    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsNWidgets(mockPosts.length));
  });

  testWidgets('UserPosts shows loading spinner when fetching posts',
      (WidgetTester tester) async {
    when(dbController.getPostsFromUser(any)).thenAnswer(
        (_) async => Future.delayed(const Duration(seconds: 2), () => []));

    await tester.pumpWidget(
      MaterialApp(
        home: UserPosts(
          dbController: dbController,
          sessionController: sessionController,
          userId: 'user_id',
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('UserPosts renders correctly when no posts are available',
      (WidgetTester tester) async {
    when(dbController.getPostsFromUser(any)).thenAnswer((_) async => []);

    await tester.pumpWidget(
      MaterialApp(
        home: UserPosts(
          dbController: dbController,
          sessionController: sessionController,
          userId: 'user_id',
        ),
      ),
    );

    expect(find.byType(CachedNetworkImage), findsNothing);
  });
}
