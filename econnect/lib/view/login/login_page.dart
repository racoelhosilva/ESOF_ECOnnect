import 'package:econnect/view/login/widget/login_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset('assets/png/logo_white.png',
                  height: 250, fit: BoxFit.contain)),
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
          Center(
              child: LoginButton(
            color: Theme.of(context).colorScheme.outline,
            text: 'Login',
            onPressed: () {},
          ))
        ],
      ),
    );
  }
}
