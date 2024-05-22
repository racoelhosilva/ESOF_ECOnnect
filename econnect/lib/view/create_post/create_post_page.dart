import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/view/commons/bottom_navbar.dart';
import 'package:econnect/view/commons/main_header.dart';
import 'package:econnect/view/create_post/widgets/description_field.dart';
import 'package:econnect/view/create_post/widgets/image_editor.dart';
import 'package:econnect/view/create_post/widgets/post_button.dart';
import 'package:flutter/material.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage(
      {super.key, required this.dbController, required this.sessionController});

  final DatabaseController dbController;
  final SessionController sessionController;

  @override
  State<StatefulWidget> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _postController = TextEditingController();
  String? _imagePath;

  void setImagePath(String? newPath) {
    setState(() {
      _imagePath = newPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const MainHeader(),
          ImageEditor(_imagePath,
              setImagePath: setImagePath, proportion: 4 / 3),
          DescriptionField(controller: _postController),
          PostButton(
            dbController: widget.dbController,
            postController: _postController,
            imagePath: _imagePath,
            user: widget.sessionController.loggedInUser,
          ),
          const SizedBox(
            height: 100.0,
          ),
        ],
      ),
    );
  }
}
