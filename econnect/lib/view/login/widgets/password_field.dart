import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        style: const TextStyle(
            color: Colors.black, fontSize: 20, fontFamily: 'Karla'),
        obscureText: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "Password",
          hintStyle: const TextStyle(
              color: Colors.grey, fontSize: 20, fontFamily: 'Karla'),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
      ),
    );
  }
}
