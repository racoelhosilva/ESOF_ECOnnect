import 'package:econnect/model/post.dart';
import 'package:econnect/view/commons/bottom_navbar.dart';
import 'package:econnect/view/commons/header_widget.dart';
import 'package:econnect/view/post/edit_post_page.dart';
import 'package:econnect/view/post/widgets/description_widget.dart';
import 'package:econnect/view/post/widgets/display_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
            initialDescription: 'Initial Description',
            post: mockPost,
          ),
        ),
      ),
    );

    expect(find.byType(BottomNavbar), findsOneWidget);
    expect(find.byType(DescriptionWidget), findsOneWidget);
    expect(find.byType(DisplayImage), findsOneWidget);
    expect(find.byType(HeaderWidget), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
  });
}
