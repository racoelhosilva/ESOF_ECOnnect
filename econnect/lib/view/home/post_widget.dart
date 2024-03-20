import 'package:econnect/model/post.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(post.user),
        Text(post.title),
        Image.network(post.image),
        Text(post.description),
      ],
    );
  }
}