import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostButton extends StatefulWidget {
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
  State<PostButton> createState() => _PostButtonState();
}

class _PostButtonState extends State<PostButton> {
  bool _isLoading = false;

  void _onPressed(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    if (widget.imagePath == null) {
      _showToast(context, 'Please select an image');
      return;
    }

    await widget.dbController.createPost(
        user: widget.user!,
        imgPath: widget.imagePath!,
        description: widget.postController.text);

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
