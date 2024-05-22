import 'package:econnect/view/commons/main_header.dart';
import 'package:econnect/view/commons/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Main header displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MainHeader(),
        ),
      ),
    );

    expect(find.byType(BackButton), findsOneWidget);
    expect(find.byType(Expanded), findsOneWidget);
    expect(find.byType(AppLogo), findsOneWidget);
  });
}
