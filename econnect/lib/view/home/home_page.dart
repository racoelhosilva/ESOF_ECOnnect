import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/view/commons/bottom_navbar.dart';
import 'package:econnect/view/commons/logo_widget.dart';
import 'package:econnect/view/home/post_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.dbController});

  final DatabaseController dbController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final List<Post> _posts = [];
  final _scrollController = ScrollController();
  bool _isLoading = false;
  bool _atEnd = false;
  final postsToLoad = 8;

  @override
  void initState() {
    super.initState();
    _loadPostsFromDb().then((_) => setState(() {}));
    _scrollController.addListener(_loadMoreAtTheEnd);
  }

  Future<void> _loadPostsFromDb() async {
    _posts
      ..clear()
      ..addAll(await widget.dbController.getNextPosts(postsToLoad))
      ..sort(
          (post1, post2) => post2.postDatetime.compareTo(post1.postDatetime));
  }

  Future<void> _loadMoreAtTheEnd() async {
    if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent &&
        !_atEnd) {
      setState(() {
        _isLoading = true;
      });
      final nextPosts = await widget.dbController.getNextPosts(postsToLoad);
      setState(() {
        _atEnd = nextPosts.isEmpty;
        _posts.addAll(nextPosts);
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {},
        child: ListView(
          controller: _scrollController,
          children: [
            const LogoWidget(),
            ...(_posts.map((post) => PostWidget(post: post))),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
            if (_atEnd) ...[
              Center(
                  child: Text(
                'You\'re all caught up!',
                style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Karla',
                    color: Theme.of(context).colorScheme.onBackground),
                textAlign: TextAlign.center,
              )),
              Center(
                  child: Text(
                'There are no more posts to see!',
                style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Karla',
                    color: Theme.of(context).colorScheme.onBackground),
                textAlign: TextAlign.center,
              )),
            ],
          ],
        ),
      ),
      extendBody: true,
    );
  }
}
