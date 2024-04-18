import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/view/commons/bottom_navbar.dart';
import 'package:econnect/view/home/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.dbController});

  final DatabaseController dbController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  final List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    _loadPostsFromDb().then((_) => setState(() {}));
  }

  Future<void> _loadPostsFromDb() async {
    _posts.addAll(await widget.dbController.getPosts());
    Logger().i(_posts);
  }

  Future<void> _takePicture() async {
    if (!_picker.supportsImageSource(ImageSource.camera)) {
      return;
    }
    final file = await _picker.pickImage(source: ImageSource.camera);
    if (file != null) {
      final post = await widget.dbController
          .createPost("user", "title", file.path, "description");
      setState(() {
        _posts.add(post);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavbar(),
      body: ListView(children: [
        Center(
          child: Text(
            'ECOnnect',
            style: Theme.of(context).textTheme.headlineLarge?.apply(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        ...(_posts.map((post) => PostWidget(post: post))),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        child: const Icon(Icons.camera),
      ),
    );
  }
}
