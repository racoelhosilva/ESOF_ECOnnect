import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../model/post.dart';

class SaveButton extends StatelessWidget {
  const SaveButton(
      {super.key,
        required this.dbController,
        required this.post,
        required this.postController
      });


  final DatabaseController dbController;
  final Post? post;
  final TextEditingController postController;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.outline,
        ),
        onPressed: () async {

          await dbController.updatePost(post?.postId, postController.text);

          if (!context.mounted) {
            return;
          }

          Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
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
