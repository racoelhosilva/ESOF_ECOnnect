import 'package:econnect/view/profile/widgets/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/view/profile/widgets/logout_button.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mockito/annotations.dart';

import 'logout_button_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SessionController>(),
])
void main() {
  group('LogoutButton', () {
    late SessionController sessionController;

    setUp(() {
      sessionController = MockSessionController();
    });

    testWidgets('Logout button displays the logout icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: LogoutButton(sessionController: sessionController),
        ),
      ));

      final iconFinder = find.byIcon(LucideIcons.logOut);
      expect(iconFinder, findsOneWidget);
    });

    testWidgets('LogoutButton opens the logout dialog when pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: LogoutButton(sessionController: sessionController),
        ),
      ));

      final buttonFinder = find.byType(IconButton);
      expect(buttonFinder, findsOneWidget);

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      final dialogFinder = find.byType(LogoutDialog);
      expect(dialogFinder, findsOneWidget);
    });
  });
}
