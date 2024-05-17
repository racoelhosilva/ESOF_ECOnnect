import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    super.key,
    required this.fieldName,
    required this.controller,
    this.maxLength,
  });

  final String fieldName;
  final TextEditingController controller;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        maxLength: maxLength,
        controller: controller,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: 'Karla',
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: fieldName,
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
