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
    required this.initialDescription,
    required this.post,
  });

  final DatabaseController dbController;
  final String initialDescription;
  final Post post;

  @override
  State<StatefulWidget> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  late TextEditingController _postController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _postController = TextEditingController(text: widget.initialDescription);
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
          SizedBox(
            width: 270,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SaveButton(
                  dbController: widget.dbController,
                  postController: _postController,
                  post: widget.post,
                  onPressed: _handleSave,
                ),
                DeleteButton(
                  onPressed: _handleDelete,
                ),
              ],
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Future<void> _handleSave() async {
    setState(() {
      _isLoading = true;
    });
    await widget.dbController
        .updatePost(widget.post.postId, _postController.text);

    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
    }
  }

  Future<void> _handleDelete() async {
    setState(() {
      _isLoading = true;
    });
    await widget.dbController.deletePost(widget.post.postId);

    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
    }
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }
}
