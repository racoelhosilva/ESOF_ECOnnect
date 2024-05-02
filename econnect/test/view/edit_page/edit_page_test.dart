import 'package:econnect/model/post.dart';
import 'package:econnect/view/commons/bottom_navbar.dart';
import 'package:econnect/view/commons/header_widget.dart';
import 'package:econnect/view/create_post/edit_post_page.dart';
import 'package:econnect/view/create_post/widgets/description_field.dart';
import 'package:econnect/view/create_post/widgets/display_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mockito/mockito.dart';
import '../../controller/session_controller_test.mocks.dart';

void main() {
  late MockDatabaseController mockDbController;
  final Post mockPost = Post(
      postId: '123',
      image: "",
      user: '',
      description: '',
      postDatetime: DateTime.now());

  setUp(() {
    mockDbController = MockDatabaseController();
  });

  testWidgets('EditPostPage contains SaveButton and DeleteButton',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EditPostPage(
            dbController: mockDbController,
            post: mockPost,
          ),
        ),
      ),
    );

    expect(find.byType(BottomNavbar), findsOneWidget);
    expect(find.byType(DescriptionField), findsOneWidget);
    expect(find.byType(DisplayImage), findsOneWidget);
    expect(find.byType(HeaderWidget), findsOneWidget);
    expect(find.byIcon(LucideIcons.trash2), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
  });

  testWidgets('EditPostPage calls deletePost when delete button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EditPostPage(
            dbController: mockDbController,
            post: mockPost,
          ),
        ),
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => Container(),
          );
        },
      ),
    );

    await tester.tap(find.byIcon(LucideIcons.trash2));
    await tester.pumpAndSettle();

    verify(mockDbController.deletePost('123')).called(1);
  });

  testWidgets('EditPostPage calls savePost when save button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EditPostPage(
            dbController: mockDbController,
            post: mockPost,
          ),
        ),
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => Container(),
          );
        },
      ),
    );

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    verify(mockDbController.updatePost(mockPost.postId, mockPost.description))
        .called(1);
  });
}
