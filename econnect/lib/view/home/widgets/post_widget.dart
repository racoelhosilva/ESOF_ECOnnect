import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/model/user.dart';
import 'package:econnect/view/home/widgets/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.post, required this.dbController});

  final Post post;
  final DatabaseController dbController;

  String formatTime(int value, String unit) {
    return '$value ${value == 1 ? unit : '${unit}s'} ago';
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
    return FutureBuilder<User?>(
      future: dbController.getUser(post.user),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return Container();
            // TODO: write throw StateError('User with id ${post.user} not found');
          }
          return Container(
            margin: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ProfileButton(
                      user: snapshot.data!,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.username,
                          overflow: TextOverflow.ellipsis,
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
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: post.image,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(LucideIcons.alertCircle),
                  ),
                ),
                Text(
                  post.description,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
