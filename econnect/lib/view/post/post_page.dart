import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/comment.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/view/commons/header_widget.dart';
import 'package:econnect/view/home/widgets/post_widget.dart';
import 'package:econnect/view/post/widgets/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:uuid/uuid.dart';

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
  final List<CommentWidget> _comments = [];
  bool _isLoading = false;
  bool _atEnd = false;
  String? _cursor;
  PostWidget? postWidget;

  @override
  void initState() {
    super.initState();
    postWidget = PostWidget(
      post: widget.post,
      dbController: widget.dbController,
      sessionController: widget.sessionController,
      isCommentsPage: true,
    );
    _clearComments();
    _loadMoreComments();
    _scrollController.addListener(_loadMoreCommentsAtEnd);
  }

  Future<void> _loadMoreComments() async {
    if (_isLoading || _atEnd) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final (nextComments, newCursor) = await widget.dbController.getNextComments(
      widget.post.postId,
      _cursor,
      5,
    );

    setState(() {
      _cursor = newCursor;
      _atEnd = newCursor == null;
      _comments.addAll(
        nextComments.map<CommentWidget>(
          (comment) => CommentWidget(
            comment: comment,
            dbController: widget.dbController,
          ),
        ),
      );
      _isLoading = false;
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

  void _clearComments() {
    setState(() {
      _cursor = null;
      _atEnd = false;
      _comments.clear();
    });
  }

  Future<void> _onRefresh() async {
    _clearComments();
    await _loadMoreComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                controller: _scrollController,
                children: [
                  const HeaderWidget(),
                  if (postWidget != null) postWidget!,
                  ..._comments,
                  if (_isLoading)
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
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

                          FocusManager.instance.primaryFocus?.unfocus();

                          setState(
                            () {
                              _comments.insert(
                                0,
                                CommentWidget(
                                  comment: Comment(
                                    commentId: const Uuid().v4(),
                                    userId: widget
                                        .sessionController.loggedInUser!.id,
                                    username: widget.sessionController
                                        .loggedInUser!.username,
                                    profilePicture: widget.sessionController
                                        .loggedInUser!.profilePicture,
                                    postId: '',
                                    comment: _textEditingController.text,
                                    commentDatetime: DateTime.now(),
                                  ),
                                  dbController: widget.dbController,
                                ),
                              );
                            },
                          );
                          _textEditingController.clear();
                        } else {
                          Fluttertoast.showToast(
                            msg: 'Comment cannot be empty',
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                          );
                        }
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.all(10.0),
                    hintText: 'Write your comment here...',
                    hintStyle: const TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Palanquin Dark',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
