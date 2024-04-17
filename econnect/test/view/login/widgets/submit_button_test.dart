import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/view/login/widgets/submit_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'submit_button_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DatabaseController>(),
  MockSpec<SessionController>(),
  MockSpec<TextEditingController>(),
  MockSpec<NavigatorObserver>(onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  group('SubmitButton Widget Tests', () {
    late MockDatabaseController dbController;
    late MockSessionController sessionController;
    late MockTextEditingController emailController;
    late MockTextEditingController passwordController;
    late MockTextEditingController usernameController;

    setUp(() {
      dbController = MockDatabaseController();
      sessionController = MockSessionController();
      emailController = MockTextEditingController();
      passwordController = MockTextEditingController();
      usernameController = MockTextEditingController();
    });

    testWidgets('Empty username, email and password fields',
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();

      when(usernameController.text).thenReturn('');
      when(emailController.text).thenReturn('');
      when(passwordController.text).thenReturn('');

      await tester.pumpWidget(MaterialApp(
        routes: {
          '/': (context) => SubmitButton(
                dbController: dbController,
                sessionController: sessionController,
                usernameController: usernameController,
                emailController: emailController,
                passwordController: passwordController,
              ),
          '/home': (context) => const Scaffold(body: Text('Home')),
        },
        navigatorObservers: [mockObserver],
      ));

      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      verifyNever(sessionController.registerUser(any, any, any, any));
      verify(mockObserver.didPush(any, any)).called(1);
    });

    testWidgets('Not register if credentials are invalid',
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();

      when(usernameController.text).thenReturn('username');
      when(emailController.text).thenReturn('invalid@example.com');
      when(passwordController.text).thenReturn('password');
      when(sessionController.registerUser(any, any, any, any))
          .thenThrow(FirebaseAuthException(code: 'invalid-email'));

      await tester.pumpWidget(MaterialApp(
        routes: {
          '/': (context) => SubmitButton(
                dbController: dbController,
                sessionController: sessionController,
                usernameController: usernameController,
                emailController: emailController,
                passwordController: passwordController,
              ),
          '/home': (context) => const Scaffold(body: Text('Home')),
        },
        navigatorObservers: [mockObserver],
      ));

      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      verify(sessionController.registerUser(any, any, any, any));
      verify(mockObserver.didPush(any, any)).called(1);
    });

    testWidgets('Successful register moves to the next screen',
        (WidgetTester tester) async {
      when(usernameController.text).thenReturn('username');
      when(emailController.text).thenReturn('valid@example.com');
      when(passwordController.text).thenReturn('password');
      when(sessionController.registerUser(any, any, any, any))
          .thenAnswer((_) => Future(() {}));

      await tester.pumpWidget(MaterialApp(
        routes: {
          '/': (context) => SubmitButton(
                dbController: dbController,
                sessionController: sessionController,
                usernameController: usernameController,
                emailController: emailController,
                passwordController: passwordController,
              ),
          '/home': (context) => const Scaffold(body: Text('Home')),
        },
      ));

      expect(find.text('Home'), findsNothing);

      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      verify(sessionController.registerUser(any, any, any, any));
      expect(find.text('Home'), findsOneWidget);
    });
  });
}
