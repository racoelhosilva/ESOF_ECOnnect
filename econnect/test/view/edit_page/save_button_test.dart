import 'package:econnect/model/post.dart';
import 'package:econnect/view/post/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../controller/session_controller_test.mocks.dart';

/*void main() {
  late MockDatabaseController mockDbController;
  final Post mockPost = Post(
      postId: '123',
      image: 'image.jpg',
      user: "",
      description: "",
      postDatetime: DateTime.now());
  final TextEditingController mockController = TextEditingController();
  bool onPressedCalled = false;

  setUp(() {
    mockDbController = MockDatabaseController();
  });

  testWidgets('SaveButton onPressed callback test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SaveButton(
            dbController: mockDbController,
            postController: mockController,
            post: mockPost,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Save'));
    expect(onPressedCalled, true);
  });

  testWidgets('SaveButton saving post test', (WidgetTester tester) async {
    when(mockDbController.updatePost(any, any)).thenAnswer((_) async => true);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SaveButton(
            dbController: mockDbController,
            postController: mockController,
            post: mockPost,
            onPressed: () async {
              await mockDbController.updatePost(
                  mockPost.postId, mockController.text);
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Save'));

    await tester.pumpAndSettle();

    verify(mockDbController.updatePost(mockPost.postId, mockController.text))
        .called(1);
  });*/

