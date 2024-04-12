import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  final TextEditingController controller;

  const DescriptionWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
        border: Border.all(color: Colors.grey), // Border properties
      ),
      child: TextField(
        controller: controller,
        maxLines: null,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10.0), // Adjust the content padding as needed
          hintText: 'Write a caption here...',
          border: InputBorder.none, // Remove the default border of the TextField
        ),
      ),
    );
  }
}
