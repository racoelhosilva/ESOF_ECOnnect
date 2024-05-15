import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/comment.dart';
import 'package:econnect/view/home/widgets/profile_button.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.comment,
    required this.dbController,
  });

  final Comment comment;
  final DatabaseController dbController;

  String formatTime(int value, String unit) {
    return '$value ${value == 1 ? unit : '${unit}s'} ago';
  }

  String getTimeElapsed() {
    final now = DateTime.now();
    final difference = now.difference(comment.commentDatetime);

    if (difference.inDays > 7) {
      return formatTime((difference.inDays ~/ 7), 'week');
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileButton(
            userId: comment.userId,
            dbController: dbController,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        comment.username,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      textAlign: TextAlign.end,
                      getTimeElapsed(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ],
                ),
                Text(
                  comment.comment,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
