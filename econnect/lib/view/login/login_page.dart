import 'package:econnect/view/login/widget/login_button.dart';
import 'package:econnect/view/login/widget/login_text_field.dart';
import 'package:econnect/view/login/widget/register_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          const Center(
            child: SizedBox(
              width: 270,
              child: Column(
                children: [
                  LoginTextField(fieldName: 'E-mail'),
                  LoginTextField(fieldName: 'Password'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RegisterButton(),
                      LoginButton(),
                    ],
                  )
                ],
              ),
            )
          ),
          ],
        ),
      ),
    );
  }
}
