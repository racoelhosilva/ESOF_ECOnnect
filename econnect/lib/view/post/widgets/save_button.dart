import 'package:econnect/controller/database_controller.dart';
import 'package:flutter/material.dart';

import '../../../model/post.dart';

class SaveButton extends StatefulWidget {
  const SaveButton(
      {super.key,
        required this.dbController,
        required this.post,
        required this.postController});

  final DatabaseController dbController;
  final Post? post;
  final TextEditingController postController;

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool _isLoading = false;

  void _onPressed(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    await widget.dbController.updatePost(
      widget.post?.postId,
      widget.postController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (!context.mounted) {
      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      margin: const EdgeInsets.only(top: 4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.outline,
        ),
        onPressed: () => _onPressed(context),
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