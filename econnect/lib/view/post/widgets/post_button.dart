import 'package:econnect/controller/database_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostButton extends StatelessWidget {
  const PostButton(
      {super.key,
      required this.dbController,
      required this.postController,
      required this.imagePath});

  final DatabaseController dbController;
  final TextEditingController postController;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.outline,
        ),
        onPressed: () async {
          if (imagePath == null) {
            _showToast(context, 'Please select an image');
            return;
          }

          final post = await dbController.createPost(
            "user",
            "title",
            imagePath!,
            postController.text,
          );

          Navigator.pop(context);
        },
        child: const Text(
          'Publish',
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

  void _showToast(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Theme.of(context).colorScheme.error,
    );
  }
}
