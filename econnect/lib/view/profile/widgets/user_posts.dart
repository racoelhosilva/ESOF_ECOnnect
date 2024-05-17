import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/view/profile/widgets/user_post_tile.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class UserPosts extends StatefulWidget {
  const UserPosts({
    super.key,
    required this.dbController,
    required this.sessionController,
    required this.userId,
    required this.parentScrollController,
  });

  final DatabaseController dbController;
  final SessionController sessionController;
  final String userId;
  final ScrollController parentScrollController;

  @override
  State<UserPosts> createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  final List<Post> _posts = [];
  bool _isLoading = false;
  bool _atEnd = false;
  String? _cursor;
  final _postsToLoad = 9;

  @override
  void initState() {
    super.initState();
    _loadMorePosts();
    widget.parentScrollController.addListener(_loadMorePostsAtEnd);
  }

  Future<void> _loadMorePosts() async {
    setState(() {
      _isLoading = true;
    });
    final (newPosts, newCursor) = await widget.dbController
        .getNextPostsFromUser(widget.userId, _postsToLoad, _cursor);
    setState(() {
      _posts.addAll(newPosts);
      _cursor = newCursor;
      _atEnd = newCursor == null;
      _isLoading = false;
    });
  }

  Future<void> _loadMorePostsAtEnd() async {
    if (widget.parentScrollController.offset ==
            widget.parentScrollController.position.maxScrollExtent &&
        !_isLoading &&
        !_atEnd) {
      await _loadMorePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(
              left: 16.0, right: 20.0, top: 4.0, bottom: 12.0),
          child: Text(
            "Recent Activity",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: "Karla",
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 3,
          childAspectRatio: .75,
          children: [
            if (widget.userId == widget.sessionController.loggedInUser!.id)
              GestureDetector(
                onTap: () async {
                  Navigator.pushNamed(context, "/createpost");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width * 4 / 9,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.plus,
                        size: 48,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "New Post",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ..._posts.map((post) {
              return UserPostTile(
                userLoggedIn: widget.userId == widget.sessionController.loggedInUser!.id,
                post: post,
              );
            }),
          ],
        ),
        if (_isLoading)
          const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
