import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/model/user.dart';
import 'package:econnect/view/home/widgets/profile_button.dart';
import 'package:flutter/material.dart';

class PostCardHeader extends StatelessWidget {
  const PostCardHeader({
    super.key,
    required this.post,
    required this.user,
    required this.dbController,
  });

  final Post post;
  final User user;
  final DatabaseController dbController;

  String formatTime(int value, String unit) {
    return '$value ${value == 1 ? unit : '${unit}s'} ago';
  }

  String getTimeElapsed() {
    final now = DateTime.now();
    final difference = now.difference(post.postDatetime);

    if (difference.inDays > 7) {
      return formatTime(difference.inDays ~/ 7, 'week');
    } else if (difference.inDays > 0) {
      return formatTime(difference.inDays, 'day');
    } else if (difference.inHours > 0) {
      return formatTime(difference.inHours, 'hour');
    } else if (difference.inMinutes > 0) {
      return formatTime(difference.inMinutes, 'minute');
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileButton(
          userId: user.id,
          dbController: dbController,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.username,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              getTimeElapsed(), // Display time elapsed
            ),
          ],
        )
      ],
    );
  }
}
