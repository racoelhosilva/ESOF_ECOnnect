import 'package:econnect/view/login/widgets/login_button.dart';
import 'package:econnect/view/login/widgets/login_text_field.dart';
import 'package:econnect/view/login/widgets/register_button.dart';
import 'package:econnect/view/login/widgets/password_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Center(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          shrinkWrap: true,
          children: [
            Image.asset('assets/png/logo_white.png',
                height: 250, fit: BoxFit.contain),
            Center(
              child: Text(
                'ECOnnect',
                style: TextStyle(
                    fontFamily: 'K2D',
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            const Center(
                child: SizedBox(
              width: 270,
              child: Column(
                children: [
                  LoginTextField(fieldName: 'E-mail'),
                  PasswordField(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RegisterButton(),
                      LoginButton(),
                    ],
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
