import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:econnect/view/commons/logo_widget.dart';

void main() {
  testWidgets('LogoWidget displays "ECOnnect" text with correct style', (WidgetTester tester) async {
    // Build the LogoWidget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LogoWidget(),
        ),
      ),
    );

    final textFinder = find.text('ECOnnect');

    expect(textFinder, findsOneWidget);

    final textWidget = tester.widget<Text>(textFinder);
    expect(textWidget.style!.fontFamily, 'K2D');
    expect(textWidget.style!.fontSize, 40);
    expect(textWidget.style!.fontWeight, FontWeight.bold);
    expect(textWidget.textAlign, TextAlign.center);
  });
}
