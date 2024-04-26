import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'O',
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
