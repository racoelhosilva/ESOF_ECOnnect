import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/logo_white.png', fit: BoxFit.contain)
          ),
          Center(
            child: Text(
              'ECOnnect',
              style: Theme.of(context).textTheme.headlineLarge?.apply(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
