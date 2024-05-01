import 'package:flutter/material.dart';

class DescriptionField extends StatelessWidget {
  final TextEditingController controller;

  const DescriptionField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Description', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: 'Palanquin Dark')),
          TextField(
            controller: controller,
            maxLength: 200,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              contentPadding: const EdgeInsets.all(10.0),
              hintText: 'Write a caption here...',
              hintStyle: const TextStyle(fontSize: 14.0, fontFamily: 'Palanquin Dark'),
            ),
          ),
        ],
      ),
    );
  }
}
