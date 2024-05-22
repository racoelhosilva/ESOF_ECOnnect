import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/comment.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/model/user.dart';
import 'package:econnect/view/commons/main_header.dart';
import 'package:econnect/view/home/widgets/post_card.dart';
import 'package:econnect/view/post/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'comment_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DatabaseController>(),
  MockSpec<SessionController>(),
])
void main() {
  late MockDatabaseController mockDatabaseController;
  late MockSessionController mockSessionController;
  late Post testPost;

  setUp(() {
    mockDatabaseController = MockDatabaseController();
    mockSessionController = MockSessionController();
    testPost = Post(
      postId: '1',
      user: 'user1',
      image: 'profilePicUrl',
      description: 'This is a test post',
      postDatetime: DateTime.now(),
    );

    when(mockSessionController.loggedInUser).thenReturn(
      User(
        id: 'user1',
        email: 'test@test.com',
        score: 0,
        isBlocked: false,
        registerDatetime: DateTime.now(),
        admin: false,
        username: 'testuser',
        profilePicture: 'profilePicUrl',
      ),
    );

    when(mockDatabaseController.getNextComments('1', any, 1)).thenAnswer(
      (_) => Future.value(
        (
          [
            Comment(
              commentId: 'comment1',
              userId: 'user1',
              username: 'testuser',
              profilePicture: 'profilePicUrl',
              postId: '1',
              comment: 'This is a test comment',
              commentDatetime: DateTime.now(),
            )
          ],
          '1'
        ),
      ),
    );
  });

  testWidgets('PostPage displays comment input', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PostPage(
          dbController: mockDatabaseController,
          sessionController: mockSessionController,
          post: testPost,
        ),
      ),
    );

    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('PostPage displays header', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PostPage(
          dbController: mockDatabaseController,
          sessionController: mockSessionController,
          post: testPost,
        ),
      ),
    );

    expect(find.byType(MainHeader), findsOneWidget);
  });

  testWidgets('PostPage displays post widget', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PostPage(
          dbController: mockDatabaseController,
          sessionController: mockSessionController,
          post: testPost,
        ),
      ),
    );

    expect(find.byType(PostCard), findsOneWidget);
  });
}
