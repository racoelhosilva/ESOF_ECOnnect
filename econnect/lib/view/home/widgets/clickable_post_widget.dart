import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/view/home/widgets/post_widget.dart';
import 'package:flutter/material.dart';

class ClickablePostWidget extends StatelessWidget {
  const ClickablePostWidget(
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
      child: PostWidget(
        dbController: dbController,
        sessionController: sessionController,
        post: post,
      ),
    );
  }
}
