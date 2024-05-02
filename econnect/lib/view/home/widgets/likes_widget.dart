import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/post.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class LikeWidget extends StatefulWidget {
  const LikeWidget(
      {super.key,
      required this.post,
      required this.dbController,
      required this.sessionController});

  final Post post;
  final DatabaseController dbController;
  final SessionController sessionController;

  @override
  State<StatefulWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  Future<bool?> _isLiked = Future.any([]);

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLiked = widget.dbController.isLiked(
          widget.sessionController.loggedInUser!.id, widget.post.postId);
    });
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    if (isLiked) {
      await widget.dbController.removeLike(
        widget.sessionController.loggedInUser!.id,
        widget.post.postId,
      );
      widget.post.likes--;
    } else {
      await widget.dbController.addLike(
        widget.sessionController.loggedInUser!.id,
        widget.post.postId,
      );
      widget.post.likes++;
    }

    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _isLiked,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return Row(
            children: [
              Text(
                widget.post.likes.toString(),
              ),
              LikeButton(
                onTap: onLikeButtonTapped,
                bubblesColor: BubblesColor(
                  dotPrimaryColor: Theme.of(context).colorScheme.inversePrimary,
                  dotSecondaryColor: Theme.of(context).colorScheme.onPrimary,
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.favorite,
                    color: isLiked
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context).colorScheme.outline,
                    size: 30.0,
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}
