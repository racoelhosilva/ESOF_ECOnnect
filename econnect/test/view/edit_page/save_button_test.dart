import 'package:econnect/view/create_post/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:econnect/model/post.dart';

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

  testWidgets('SaveButton contains save button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SaveButton(
            dbController: dbController,
            post: Post(
                postId: '1',
                user: '',
                image: '',
                description: '',
                postDatetime: DateTime.now()),
            postController: postController,
          ),
        ),
      ),
    );

    expect(find.text('Save'), findsOneWidget);
  });

  testWidgets('SaveButton updates post', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/',
        routes: {
          '/home': (_) => const Scaffold(),
        },
        home: Scaffold(
          body: SaveButton(
            dbController: dbController,
            post: Post(
                postId: '1',
                user: '',
                image: '',
                description: '',
                postDatetime: DateTime.now()),
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
