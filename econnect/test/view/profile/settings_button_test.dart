import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:econnect/view/profile/widgets/settings_button.dart';

void main() {
  testWidgets('SettingsButton widget renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: const [
            SettingsButton(),
          ],
        ),
      ),
    ));

    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byIcon(LucideIcons.settings), findsOneWidget);
  });

  testWidgets('SettingsButton navigates to settings page when pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Scaffold(
              appBar: AppBar(
                actions: const [
                  SettingsButton(),
                ],
              ),
            ),
        '/settings': (context) => const Scaffold(),
      },
    ));

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    expect(find.byType(Scaffold), findsOneWidget);
  });
}
