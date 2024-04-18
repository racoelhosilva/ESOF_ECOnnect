import 'dart:io';

import 'package:econnect/view/post/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'description_widget_test.dart';
import 'image_widget_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ImageWidget>()])
void main() {
  late ImageWidget mockImageWidget;

  setUp(() {
    mockImageWidget = MockImageWidget();
  });

  testWidgets('ImageWidget displays "No image selected" when no image is set',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ImageWidget(null, setImagePath: (_) {}),
      ),
    ));

    expect(find.text('No image selected'), findsOneWidget);
  });

  testWidgets('ImageWidget displays the selected image',
      (WidgetTester tester) async {
    // Set up a mock image path
    const String imagePath = 'mock_image_path.jpg';

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ImageWidget(imagePath, setImagePath: (_) {}),
      ),
    ));

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('ImageWidget calls setImagePath', (WidgetTester tester) async {
    String? filepath = null;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ImageWidget(filepath, setImagePath: (_) {}),
      ),
    ));

    await tester.tap(find.byTooltip('Pick Image from gallery'));

    verifyNever(mockImageWidget.setImagePath(filepath));
  });

  testWidgets(
      'ImageWidget calls setImagePath with non-null path when an image is selected from gallery',
      (WidgetTester tester) async {
    // Set up
    const String imagePath = 'test.png';

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ImageWidget(null, setImagePath: mockImageWidget.setImagePath),
      ),
    ));

    await tester.tap(find.byTooltip('Pick Image from gallery'));
    await tester.pumpAndSettle();

    verify(mockImageWidget.setImagePath(imagePath)).called(1);
  });
}
