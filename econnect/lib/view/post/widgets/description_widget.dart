import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  final TextEditingController controller;

  const DescriptionWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        maxLength: 200,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          contentPadding: const EdgeInsets.all(10.0),
          hintText: 'Write a caption here...',
        ),
      ),
    );
  }
}
