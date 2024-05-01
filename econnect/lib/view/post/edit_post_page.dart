import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/view/commons/bottom_navbar.dart';
import 'package:econnect/view/commons/header_widget.dart';
import 'package:econnect/view/post/widgets/delete_button.dart';
import 'package:econnect/view/post/widgets/description_widget.dart';
import 'package:econnect/view/post/widgets/display_image.dart';
import 'package:econnect/view/post/widgets/image_widget.dart';
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
                ),
                DeleteButton(
                  onPressed: () async {
                    await widget.dbController.deletePost(widget.post.postId);
                    Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
                  },
                ),
              ],
            ),
          )

        ],
      ),
    );
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }
}
