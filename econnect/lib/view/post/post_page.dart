import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/comment.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/view/commons/header_widget.dart';
import 'package:econnect/view/home/widgets/post_widget.dart';
import 'package:econnect/view/post/widgets/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PostPage extends StatefulWidget {
  const PostPage({
    super.key,
    required this.dbController,
    required this.sessionController,
    required this.post,
  });

  final DatabaseController dbController;
  final SessionController sessionController;
  final Post post;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Comment> _comments = [];
  bool _isLoading = false;
  bool _atEnd = false;
  String? _cursor;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreCommentsAtEnd);
    _loadMoreComments();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMoreComments() async {
    if (_isLoading || _atEnd) return;

    setState(() {
      _isLoading = true;
    });

    final (nextComments, newCursor) = await widget.dbController.getNextComments(
      widget.post.postId,
      _cursor,
      3,
    );

    setState(() {
      _cursor = newCursor;
      _isLoading = false;
      _atEnd = newCursor == null;
      _comments.addAll(nextComments);
    });
  }

  Future<void> _loadMoreCommentsAtEnd() async {
    if (_scrollController.offset !=
            _scrollController.position.maxScrollExtent ||
        _isLoading ||
        _atEnd) {
      return;
    }

    await _loadMoreComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController,
              children: [
                const HeaderWidget(),
                PostWidget(
                  post: widget.post,
                  dbController: widget.dbController,
                  sessionController: widget.sessionController,
                ),
                // Display comments here
                for (final comment in _comments)
                  CommentWidget(
                    comment: comment,
                    dbController: widget.dbController,
                  ),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator()),
                if (_atEnd && _comments.isNotEmpty)
                  const Text(
                    'End of comments',
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextField(
              controller: _textEditingController,
              maxLength: 200,
              decoration: InputDecoration(
                counterText: '',
                suffixIcon: IconButton(
                  icon: const Icon(LucideIcons.send),
                  onPressed: () async {
                    if (_textEditingController.text.isNotEmpty) {
                      await widget.dbController.addComment(
                        widget.sessionController.loggedInUser!.id,
                        widget.post.postId,
                        _textEditingController.text,
                      );

                      setState(() {
                        _textEditingController.clear();
                        _comments.clear();
                        _cursor = null;
                        _atEnd = false;
                      });

                      await _loadMoreComments();
                    }
                  },
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.background,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.all(10.0),
                hintText: 'Write your comment here...',
                hintStyle: const TextStyle(
                    fontSize: 14.0, fontFamily: 'Palanquin Dark'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
