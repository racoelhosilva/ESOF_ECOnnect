import 'package:econnect/model/post.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              post.user,
              style: Theme.of(context).textTheme.headlineMedium?.apply(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            post.title,
            style: Theme.of(context).textTheme.headlineLarge?.apply(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        Image.network(post.image),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(post.description),
        ),
      ],
    );
  }
}
