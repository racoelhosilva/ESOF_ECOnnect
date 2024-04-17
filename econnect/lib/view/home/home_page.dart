import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/database.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/view/commons/logo_widget.dart';
import 'package:econnect/view/home/post_widget.dart';
import 'package:econnect/view/post/create_post_page.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Post> _posts = [];
  final DatabaseController _dbController = DatabaseController(db: Database());

  @override
  void initState() {
    super.initState();
    _loadPostsFromDb().then((_) => setState(() {}));
  }

  Future<void> _loadPostsFromDb() async {
    _posts
      ..clear()
      ..addAll(await _dbController.getPosts())
      ..sort(
          (post1, post2) => post2.postDatetime.compareTo(post1.postDatetime));
    Logger().i(_posts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const LogoWidget(),
          ...(_posts.map((post) => PostWidget(post: post))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(LucideIcons.copyPlus),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostPage()),
          );
          await _loadPostsFromDb();
          setState(() {});
        },
      ),
    );
  }
}
