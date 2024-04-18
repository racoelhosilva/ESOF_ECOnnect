import 'package:econnect/view/commons/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:econnect/view/commons/header_widget.dart';

void main() {
  testWidgets('HeaderWidget displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: HeaderWidget(),
        ),
      ),
    );

    expect(find.byType(BackButton), findsOneWidget);

    expect(find.byType(Expanded), findsOneWidget);
    expect(find.byType(LogoWidget), findsOneWidget);
  });
}
