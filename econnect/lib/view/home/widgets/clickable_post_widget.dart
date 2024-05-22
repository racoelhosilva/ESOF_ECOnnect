import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/view/home/widgets/post_card.dart';
import 'package:flutter/material.dart';

class ClickablePostCard extends StatelessWidget {
  const ClickablePostCard(
      {super.key,
      required this.post,
      required this.dbController,
      required this.sessionController});

  final Post post;
  final DatabaseController dbController;
  final SessionController sessionController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.pushNamed(context, "/postpage", arguments: post);
      },
      child: PostCard(
        dbController: dbController,
        sessionController: sessionController,
        post: post,
        isCommentsPage: false,
      ),
    );
  }
}
