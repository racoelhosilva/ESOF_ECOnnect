import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/view/home/widgets/edit_post_button.dart';
import 'package:lucide_icons/lucide_icons.dart';

void main() {
  group('EditPostButton', () {
    testWidgets('renders IconButton with pencil icon', (WidgetTester tester) async {
      final post = Post(
        postId: '1',
        description: 'This is a test post',
        user: '1',
        image: 'image.jpg',
        postDatetime: DateTime.now(),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditPostButton(post: post),
          ),
        ),
      );

      expect(find.byIcon(LucideIcons.pencil), findsOneWidget);
    });

    testWidgets('navigates to edit post screen when pressed', (WidgetTester tester) async {
      final post = Post(
        postId: '1',
        description: 'This is a test post',
        user: '1',
        image: 'image.jpg',
        postDatetime: DateTime.now(),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditPostButton(post: post),
          ),
          routes: {
            '/editpost': (context) => Container(), // Replace with your edit post screen widget
          },
        ),
      );

      await tester.tap(find.byIcon(LucideIcons.pencil));
      await tester.pumpAndSettle();

      expect(find.byType(Container), findsOneWidget); // Replace with your edit post screen widget
    });
  });
}