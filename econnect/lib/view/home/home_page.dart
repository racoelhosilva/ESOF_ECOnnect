import 'dart:io';

import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/database.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/view/home/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  final List<Post> _posts = [];
  final DatabaseController _dbController = DatabaseController(db: Database());

  void _takePicture() async {
    if (!_picker.supportsImageSource(ImageSource.camera)) {
      return;
    }
    final file = await _picker.pickImage(source: ImageSource.camera);
    if (file != null) {
      final post = await _dbController.createPost("user", "title", file.path, "description");
      setState(() {
        _posts.add(post);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Center(
          child: Text(
            'ECOnnect',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        ...(_posts.map((post) => PostWidget(post: post)).toList()),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        child: const Icon(Icons.camera),
      ),
    );
  }
}
