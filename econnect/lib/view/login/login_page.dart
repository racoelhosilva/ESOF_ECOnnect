import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          Center(
            child: Text(
              'ECOnnect',
              style: Theme.of(context).textTheme.headlineLarge?.apply(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}


// bababooeyjfbkbbjkgfbgfbgbgfbgbf