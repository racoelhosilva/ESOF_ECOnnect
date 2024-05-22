import 'package:econnect/model/comment.dart';
import 'package:econnect/view/home/widgets/profile_button.dart';
import 'package:econnect/view/post/widgets/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../login/widgets/login_button_test.mocks.dart';

void main() {
  late MockDatabaseController mockDatabaseController;
  late Comment testComment;

  setUp(() {
    mockDatabaseController = MockDatabaseController();
    testComment = Comment(
      commentId: 'comment1',
      userId: 'user1',
      username: 'testuser',
      profilePicture: 'profilePicUrl',
      postId: 'post1',
      comment: 'This is a test comment',
      commentDatetime: DateTime.now().subtract(const Duration(minutes: 5)),
    );
  });

  testWidgets('CommentWidget initializes and displays comment details',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CommentWidget(
          comment: testComment,
          dbController: mockDatabaseController,
        ),
      ),
    );

    expect(find.text('testuser'), findsOneWidget);
    expect(find.text('This is a test comment'), findsOneWidget);
    expect(find.text('5 minutes ago'), findsOneWidget);
  });

  testWidgets('CommentWidget displays ProfileButton',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CommentWidget(
          comment: testComment,
          dbController: mockDatabaseController,
        ),
      ),
    );

    expect(find.byType(ProfileButton), findsOneWidget);
  });
}
