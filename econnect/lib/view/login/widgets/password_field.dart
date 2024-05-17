import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: widget.controller,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: 'Karla',
        ),
        obscureText: _isObscured,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            icon: _isObscured
                ? const Icon(LucideIcons.eye)
                : const Icon(LucideIcons.eyeOff),
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: "Password",
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 20,
            fontFamily: 'Karla',
          ),
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
