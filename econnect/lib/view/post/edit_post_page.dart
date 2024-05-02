import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/view/commons/bottom_navbar.dart';
import 'package:econnect/view/commons/header_widget.dart';
import 'package:econnect/view/post/widgets/delete_button.dart';
import 'package:econnect/view/post/widgets/description_widget.dart';
import 'package:econnect/view/post/widgets/display_image.dart';
import 'package:econnect/view/post/widgets/save_button.dart';
import 'package:flutter/material.dart';

class EditPostPage extends StatefulWidget {
  const EditPostPage({
    super.key,
    required this.dbController,
    required this.post,
  });

  final DatabaseController dbController;
  final Post post;

  @override
  State<StatefulWidget> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  late TextEditingController _postController;

  @override
  void initState() {
    super.initState();
    _postController = TextEditingController(text: widget.post.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const HeaderWidget(),
          DisplayImage(imagePath: widget.post.image),
          DescriptionWidget(controller: _postController),
          SaveButton(
            dbController: widget.dbController,
            postController: _postController,
            post: widget.post,
          ),
        ],
      ),
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom != 0
          ? null
          : DeleteButton(
              onPressed: () async {
                await widget.dbController.deletePost(widget.post.postId);
                if (!context.mounted) {
                  return;
                }
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/home', (_) => false);
              },
            ),
    );
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }
}
