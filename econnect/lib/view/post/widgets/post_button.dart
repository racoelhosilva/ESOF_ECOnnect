import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostButton extends StatefulWidget {
  const PostButton({
    super.key,
    required this.dbController,
    required this.postController,
    required this.imagePath,
    required this.user,
  });

  final DatabaseController dbController;
  final TextEditingController postController;
  final String? imagePath;
  final User? user;

  @override
  State<StatefulWidget> createState() => PostButtonState();
}

class PostButtonState extends State<PostButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 4.0),
      child: Stack(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.outline,
            ),
            onPressed: isLoading
                ? null
                : () async {
                    if (widget.imagePath == null) {
                      _showToast(context, 'Please select an image');
                      return;
                    }

                    setState(() {
                      isLoading = true;
                    });

                    await widget.dbController.createPost(
                      widget.user!.username,
                      widget.imagePath!,
                      widget.postController.text,
                    );

                    setState(() {
                      isLoading = false;
                    });

                    if (!context.mounted) {
                      return;
                    }

                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/home', (_) => false);
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
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Theme.of(context).colorScheme.background,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
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
