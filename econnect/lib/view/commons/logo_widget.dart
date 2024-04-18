import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'ECOnnect',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'K2D',
        color: Theme.of(context).colorScheme.primaryContainer,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
