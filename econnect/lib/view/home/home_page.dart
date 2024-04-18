import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/view/commons/bottom_navbar.dart';
import 'package:econnect/view/commons/logo_widget.dart';
import 'package:econnect/view/home/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.dbController});

  final DatabaseController dbController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    _loadPostsFromDb().then((_) => setState(() {}));
  }

  Future<void> _loadPostsFromDb() async {
    _posts
      ..clear()
      ..addAll(await widget.dbController.getPosts())
      ..sort(
          (post1, post2) => post2.postDatetime.compareTo(post1.postDatetime));
    Logger().i(_posts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(),
      body: ListView(
        children: [
          const LogoWidget(),
          ...(_posts.map((post) => PostWidget(post: post))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(LucideIcons.copyPlus),
        onPressed: () async {
          Navigator.of(context).pushNamed('/createpost').then(
            (value) async {
              await _loadPostsFromDb();
              setState(() {});
            },
          );
        },
      ),
      extendBody: true,
    );
  }
}
