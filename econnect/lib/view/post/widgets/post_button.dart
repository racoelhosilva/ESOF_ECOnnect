import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostButton extends StatelessWidget {
  const PostButton(
      {super.key,
      required this.dbController,
      required this.postController,
      required this.imagePath,
      required this.user});

  final DatabaseController dbController;
  final TextEditingController postController;
  final String? imagePath;
  final User? user;

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

          await dbController.createPost(
              user: user!.username,
              imgPath: imagePath!,
              description: postController.text);

          if (!context.mounted) {
            return;
          }

          Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
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
