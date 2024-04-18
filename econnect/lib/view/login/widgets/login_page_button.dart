import 'package:flutter/material.dart';

class LoginPageButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function() onPressed;

  const LoginPageButton({
    super.key,
    required this.color,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontFamily: 'Karla',
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
