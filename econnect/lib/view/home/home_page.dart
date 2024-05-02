import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/view/commons/bottom_navbar.dart';
import 'package:econnect/view/commons/logo_widget.dart';
import 'package:econnect/view/home/widgets/end_message.dart';
import 'package:econnect/view/home/widgets/post_widget.dart';
import 'package:econnect/view/post/edit_post_page.dart';
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
    _clearPosts();
    _loadMorePosts();
    _scrollController.addListener(_loadMorePostsAtEnd);
  }

  void _clearPosts() {
    setState(() {
      _posts.clear();
    });
    widget.dbController.resetPostsCursor();
  }

  Future<void> _loadMorePosts() async {
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

  Future<void> _loadMorePostsAtEnd() async {
    if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent &&
        !_atEnd) {
      _loadMorePosts();
    }
  }

  Future<void> _onRefresh() async {
    _clearPosts();
    await _loadMorePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(
        specialActions: {
          '/home': () {
            _scrollController
                .jumpTo(_scrollController.position.minScrollExtent);
            _refreshIndicatorKey.currentState?.show();
          }
        },
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _onRefresh,
        child: ListView(
          controller: _scrollController,
          children: [
            const LogoWidget(),
            ...(_posts.map(
              (post) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPostPage(
                          post: post,
                          dbController: widget.dbController,
                          initialDescription: post.description),
                    ),
                  );
                },
                child: PostWidget(post: post),
              ),
            )),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
            if (_atEnd) const EndMessage(),
          ],
        ),
      ),
      extendBody: true,
    );
  }
}
