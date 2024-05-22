import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/view/profile/widgets/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_dialog_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SessionController>(),
])
void main() {
  late SessionController sessionController;

  setUp(() {
    sessionController = MockSessionController();
  });

  testWidgets('Logout dialog renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LogoutDialog(sessionController: sessionController),
        ),
      ),
    );

    expect(find.text('Logout'), findsNWidgets(2));
    expect(find.text('Are you sure you want to logout?'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets(
      'Logout dialog calls logout method and navigates to login page when logout button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/login': (context) => const Text('Login Page'),
          '/': (context) => LogoutDialog(sessionController: sessionController),
        },
      ),
    );

    await tester.tap(find.byKey(const Key('dialog_logout_button')));
    await tester.pumpAndSettle();

    verify(sessionController.logout()).called(1);
    expect(find.text('Login Page'), findsOneWidget);
  });

  testWidgets('closes dialog when cancel button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LogoutDialog(sessionController: sessionController),
        ),
      ),
    );

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
  });
}
