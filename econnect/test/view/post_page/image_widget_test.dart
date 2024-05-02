import 'package:econnect/view/create_post/widgets/image_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'image_widget_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ImageEditor>()])
void main() {
  late ImageEditor mockImageWidget;

  setUp(() {
    mockImageWidget = MockImageEditor();
  });

  testWidgets('ImageWidget displays "No image selected" when no image is set',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ImageEditor(null, setImagePath: (_) {}, proportion: 10),
      ),
    ));

    expect(find.text('No image selected'), findsOneWidget);
  });

  testWidgets('ImageWidget displays the selected image',
      (WidgetTester tester) async {
    const String imagePath = 'mock_image_path.jpg';

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ImageEditor(
          imagePath,
          setImagePath: (_) {},
          proportion: 10,
        ),
      ),
    ));

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets(
      'ImageWidget calls setImagePath with non-null path when an image is selected from gallery',
      (WidgetTester tester) async {
    const String imagePath = 'test.png';

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ImageEditor(
          null,
          setImagePath: mockImageWidget.setImagePath,
          proportion: 10,
        ),
      ),
    ));

    await tester.tap(find.byTooltip('Pick Image from gallery'));
    await tester.pumpAndSettle();

    verify(mockImageWidget.setImagePath(imagePath)).called(1);
  });
}
