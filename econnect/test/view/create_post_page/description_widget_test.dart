import 'package:econnect/view/create_post/widgets/image_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';

class MockImagePicker extends Mock implements ImagePicker {}

void main() {
  group('ImageWidget', () {
    testWidgets('Creates widget without errors', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ImageEditor(
          null,
          setImagePath: (_) {},
          proportion: 10,
        ),
      ));

      expect(find.byType(ImageEditor), findsOneWidget);
    });
  });
}
