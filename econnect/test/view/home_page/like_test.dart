import 'package:econnect/model/post.dart';
import 'package:econnect/model/user.dart';
import 'package:econnect/view/home/widgets/app_like_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:like_button/like_button.dart';
import 'package:mockito/mockito.dart';
import '../settings/save_button_test.mocks.dart';

void main() {
  group('LikeWidget', () {
    testWidgets('Toggles like state when tapped', (WidgetTester tester) async {
      final mockDbController = MockDatabaseController();
      final mockSessionController = MockSessionController();
      final post = Post(
          postId: '1',
          likes: 0,
          user: '1',
          description: 'test',
          postDatetime: DateTime.now(),
          image: '');

      when(mockSessionController.loggedInUser).thenReturn(User(
          id: '1',
          email: 'test',
          username: 'test',
          profilePicture: 'test',
          score: 0,
          isBlocked: false,
          registerDatetime: DateTime.now(),
          admin: false));
      when(mockDbController.isLiked(any, any)).thenAnswer((_) async => false);
      when(mockDbController.addLike(any, any)).thenAnswer((_) async => true);
      when(mockDbController.removeLike(any, any)).thenAnswer((_) async => true);

      await tester.pumpWidget(MaterialApp(
        home: AppLikeButton(
          post: post,
          dbController: mockDbController,
          sessionController: mockSessionController,
        ),
      ));

      expect(find.byType(LikeButton), findsOneWidget);
      expect(find.text('0'), findsOneWidget);

      await tester.tap(find.byType(LikeButton));
      await tester.pump();

      verify(mockDbController.addLike(any, any)).called(1);
      expect(find.text('1'), findsOneWidget);
    });
  });
}
