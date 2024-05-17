import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/model/user.dart';
import 'package:econnect/view/home/widgets/app_like_button.dart';
import 'package:econnect/view/home/widgets/post_card_header.dart';
import 'package:econnect/view/home/widgets/post_image.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.dbController,
    required this.sessionController,
  });

  final Post post;
  final DatabaseController dbController;
  final SessionController sessionController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: dbController.getUser(post.user),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            throw StateError('User with id ${post.user} not found');
          }
          return Container(
            margin: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostCardHeader(post: post, user: snapshot.data!, dbController: dbController),
                PostImage(postImageUrl: post.image),
                AppLikeButton(
                  post: post,
                  dbController: dbController,
                  sessionController: sessionController,
                ),
                Text(
                  post.description,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * (5 / 3),
            child: const CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
