import 'package:econnect/view/login/widgets/register_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Button redirects to register page', (tester) async {
    await tester.pumpWidget(
      MaterialApp(routes: {
        '/': (_) => const RegisterButton(),
        '/register': (_) => const Scaffold(body: Text('Register Page')),
      }),
    );

    expect(find.text('Register Page'), findsNothing);

    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    expect(find.text('Register Page'), findsOneWidget);
  });
}
