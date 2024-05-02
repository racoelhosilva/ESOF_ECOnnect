import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:flutter/material.dart';

class FollowButton extends StatefulWidget {
  const FollowButton(
      {super.key,
      required this.dbController,
      required this.sessionController,
      required this.posterId});

  final DatabaseController dbController;
  final SessionController sessionController;
  final String posterId;

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    initFollowing();
  }

  Future<void> initFollowing() async {
    final newFollowing = await widget.sessionController
        .isFollowing(widget.posterId, widget.dbController);
    setState(() {
      isFollowing = newFollowing;
    });
  }

  void toggleFollow() {
    if (isFollowing) {
      widget.sessionController
          .unfollowUser(widget.posterId, widget.dbController);
    } else {
      widget.sessionController.followUser(widget.posterId, widget.dbController);
    }
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleFollow,
      child: Icon(
        isFollowing ? Icons.star : Icons.star_border,
        color: isFollowing
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onPrimaryContainer,
        size: 36.0,
      ),
    );
  }
}
