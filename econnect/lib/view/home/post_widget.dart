import 'package:econnect/model/post.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.post});

  final Post post;

  String formatTime(int value, String unit) {
    return '$value ${value == 1 ? unit : unit + 's'} ago';
  }

  String getTimeElapsed() {
    final now = DateTime.now();
    final difference = now.difference(post.postDatetime);

    if (difference.inDays > 7) {
      return formatTime((difference.inDays / 7 as int), 'week');
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
      margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                child: Icon(
                  LucideIcons.user,
                  size: 45,
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.user,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    getTimeElapsed(), // Display time elapsed
                  ),
                ],
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * (4 / 3),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Image.network(post.image, fit: BoxFit.cover),
          ),
          Text(
            post.description,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
