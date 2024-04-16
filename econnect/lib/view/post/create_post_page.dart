import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/database.dart';
import 'package:econnect/view/commons/header_widget.dart';
import 'package:econnect/view/post/widgets/description_widget.dart';
import 'package:econnect/view/post/widgets/image_widget.dart';
import 'package:econnect/view/post/widgets/post_button.dart';
import 'package:flutter/material.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _postController = TextEditingController();
  final DatabaseController _dbController = DatabaseController(db: Database());
  String? _imagePath;

  void setImagePath(String? newPath) {
    setState(() {
      _imagePath = newPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const HeaderWidget(),
          ImageWidget(_imagePath, setImagePath: setImagePath),
          DescriptionWidget(controller: _postController),
          PostButton(
            dbController: _dbController,
            postController: _postController,
            imagePath: _imagePath,
          ),
        ],
      ),
    );
  }
}
