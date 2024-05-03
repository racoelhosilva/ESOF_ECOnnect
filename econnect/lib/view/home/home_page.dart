import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/view/commons/bottom_navbar.dart';
import 'package:econnect/view/home/widgets/end_message.dart';
import 'package:econnect/view/home/widgets/middle_message.dart';
import 'package:econnect/view/home/widgets/post_widget.dart';
import 'package:econnect/view/home/widgets/home_page_header.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key, required this.dbController, required this.sessionController});

  final DatabaseController dbController;
  final SessionController sessionController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final List<PostWidget> _followingPosts = [], _othersPosts = [];
  final _scrollController = ScrollController();
  bool _isLoading = false;
  bool _atEnd1 = false, _atEnd2 = false;
  final postsToLoad = 8;
  String? _cursor;

  @override
  void initState() {
    super.initState();
    _clearPosts();
    _loadMorePostsFromFollowing();
    _scrollController.addListener(_loadMorePostsAtEnd);
  }

  void _clearPosts() {
    setState(() {
      _cursor = null;
      _atEnd1 = _atEnd2 = false;
      _followingPosts.clear();
      _othersPosts.clear();
    });
  }

  Future<void> _loadMorePostsFromFollowing() async {
    setState(() {
      _isLoading = true;
    });
    final (nextPosts, newCursor) =
        await widget.dbController.getNextPostsOfFollowing(
      _cursor,
      postsToLoad,
      widget.sessionController.loggedInUser!.id,
    );
    setState(() {
      _cursor = newCursor;
      _atEnd1 = newCursor == null;
      _followingPosts.addAll(
        nextPosts.map<PostWidget>(
          (post) => PostWidget(
            post: post,
            dbController: widget.dbController,
            sessionController: widget.sessionController,
          ),
        ),
      );
      _isLoading = false;
    });
    if (_atEnd1) {
      await _loadMorePostsFromOthers();
    }
  }

  Future<void> _loadMorePostsFromOthers() async {
    setState(() {
      _isLoading = true;
    });
    final (nextPosts, newCursor) =
        await widget.dbController.getNextPostsOfNonFollowing(
      _cursor,
      postsToLoad,
      widget.sessionController.loggedInUser!.id,
    );
    setState(() {
      _cursor = newCursor;
      _atEnd2 = newCursor == null;
      _othersPosts.addAll(
        nextPosts.map<PostWidget>(
          (post) => PostWidget(
            post: post,
            dbController: widget.dbController,
            sessionController: widget.sessionController,
          ),
        ),
      );
      _isLoading = false;
    });
  }

  Future<void> _loadMorePostsAtEnd() async {
    if (_scrollController.offset !=
        _scrollController.position.maxScrollExtent) {
      return;
    }
    if (!_atEnd1) {
      _loadMorePostsFromFollowing();
    } else if (!_atEnd2) {
      _loadMorePostsFromOthers();
    }
  }

  Future<void> _onRefresh() async {
    _clearPosts();
    await _loadMorePostsFromFollowing();
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
            HomePageHeader(
              dbController: widget.dbController,
              sessionController: widget.sessionController,
            ),
            ..._followingPosts,
            if (_atEnd1 && _followingPosts.isNotEmpty) const MiddleMessage(),
            ..._othersPosts,
            if (_atEnd2) const EndMessage(),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
      extendBody: true,
    );
  }
}
