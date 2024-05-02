import 'package:econnect/controller/database_controller.dart';
import 'package:flutter/material.dart';
import '../../../model/post.dart';

class SaveButton extends StatelessWidget {
  const SaveButton(
      {super.key,
      required this.onPressed,
      required this.dbController,
      required this.post,
      required this.postController});

  final DatabaseController dbController;
  final Post? post;
  final TextEditingController postController;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.outline,
        ),
        onPressed: () async {
          onPressed();
        },
        child: const Text(
          'Save',
          style: TextStyle(
            fontFamily: 'Karla',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
