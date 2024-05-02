import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/view/post/widgets/save_button.dart';

import '../../controller/session_controller_test.mocks.dart';
void main() {
  late MockDatabaseController dbController;
  late TextEditingController postController;

  setUp(() {
    dbController = MockDatabaseController();
    postController = TextEditingController();
  });

  tearDown(() {
    postController.dispose();
  });

  testWidgets('SaveButton displays CircularProgressIndicator when isLoading is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SaveButton(
            dbController: dbController,
            post: null,
            postController: postController,
          ),
        ),
      ),
    );
    

    await tester.tap(find.text('Save'));
    await tester.pump();
    final CircularProgressIndicator circularProgressIndicator =
        tester.widget<CircularProgressIndicator>(find.byType(CircularProgressIndicator));

    expect(circularProgressIndicator, isNotNull);
  });

  testWidgets('SaveButton updates post',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SaveButton(
            dbController: dbController,
            post: Post(postId: '1', user: '', image: '', description: '', postDatetime: DateTime.now()),
            postController: postController,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(postController.text, '');
  });

  
}