import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function() onPressed;

  const LoginButton({
    super.key,
    required this.color,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      child: Text(
        text,
        style: const TextStyle(
            fontFamily: 'Karla',
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}