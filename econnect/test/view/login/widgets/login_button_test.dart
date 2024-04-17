import 'dart:math';

import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/view/login/widgets/login_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart';

import 'login_button_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DatabaseController>(),
  MockSpec<SessionController>(),
  MockSpec<TextEditingController>(),
  MockSpec<NavigatorObserver>(onMissingStub: OnMissingStub.returnDefault),
])

void main() {
  group('LoginButton Widget Tests', () {
    late MockDatabaseController dbController;
    late MockSessionController sessionController;
    late MockTextEditingController emailController;
    late MockTextEditingController passwordController;

    setUpAll(() {
      dbController = MockDatabaseController();
      sessionController = MockSessionController();
      emailController = MockTextEditingController();
      passwordController = MockTextEditingController();
    });

    testWidgets('Empty email and password fields', (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      
      when(emailController.text).thenReturn('');
      when(passwordController.text).thenReturn('');
    
      await tester.pumpWidget(MaterialApp(
          routes: {
            '/': (context) => LoginButton(
              dbController: dbController,
              sessionController: sessionController,
              emailController: emailController,
              passwordController: passwordController,
            ),  
            '/home': (context) => const Scaffold(body: Text('Home')),
          },
      ));

      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      verifyNever(sessionController.loginUser(any, any, any));  
      verifyNever(mockObserver.didPush(any, any));
    });

    testWidgets('Not log in if credentials are invalid', (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      
      when(emailController.text).thenReturn('invalid@example.com');
      when(passwordController.text).thenReturn('password');
      when(sessionController.loginUser(any, any, any)).thenThrow(FirebaseAuthException(code: 'invalid-credential'));
    
      await tester.pumpWidget(MaterialApp(
          routes: {
            '/': (context) => LoginButton(
              dbController: dbController,
              sessionController: sessionController,
              emailController: emailController,
              passwordController: passwordController,
            ),  
            '/home': (context) => const Scaffold(body: Text('Home')),
          },
      ));

      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      verify(sessionController.loginUser(any, any, any));  
      verifyNever(mockObserver.didPush(any, any));
    });
      
    testWidgets('Successful login moves to the next screen', (WidgetTester tester) async {
      when(emailController.text).thenReturn('valid@example.com');
      when(passwordController.text).thenReturn('password');
      when(sessionController.loginUser(any, any, any)).thenAnswer((_) => Future(() {}));
      
      await tester.pumpWidget(MaterialApp(
        routes: {
          '/': (context) => LoginButton(
            dbController: dbController,
            sessionController: sessionController,
            emailController: emailController,
            passwordController: passwordController,
          ),  
          '/home': (context) => const Scaffold(body: Text('Home')),
        },
      ));

      expect(find.text('Home'), findsNothing);

      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      verify(sessionController.loginUser(any, any, any));
      expect(find.text('Home'), findsOneWidget);
    });
  });  
}
