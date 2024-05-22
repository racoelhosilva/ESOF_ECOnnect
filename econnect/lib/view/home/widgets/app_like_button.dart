import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/post.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class AppLikeButton extends StatefulWidget {
  const AppLikeButton({
    super.key,
    required this.post,
    required this.dbController,
    required this.sessionController,
  });

  final Post post;
  final DatabaseController dbController;
  final SessionController sessionController;

  @override
  State<StatefulWidget> createState() => _AppLikeButtonState();
}

class _AppLikeButtonState extends State<AppLikeButton> {
  bool _isLiked = false;
  bool _isClicked = false;

  @override
  void initState() {
    super.initState();
    _initLike();
  }

  Future<void> _initLike() async {
    final newLike = await widget.dbController.isLiked(
      widget.sessionController.loggedInUser!.id,
      widget.post.postId,
    );
    setState(() {
      _isLiked = newLike;
    });
  }

  Future<bool> _onLikeButtonTapped(bool isLiked) async {
    if (_isClicked) {
      return isLiked;
    }

    _isClicked = true;

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

    _isClicked = false;

    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        LikeButton(
          isLiked: _isLiked,
          onTap: _isClicked ? null : _onLikeButtonTapped,
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
          likeCount: widget.post.likes,
          countBuilder: (int? count, bool isLiked, String text) {
            var color = Theme.of(context).colorScheme.onPrimaryContainer;
            return Text(
              text,
              style: TextStyle(color: color, fontSize: 16.0),
            );
          },
          countPostion: CountPostion.left,
        ),
      ],
    );
  }
}
