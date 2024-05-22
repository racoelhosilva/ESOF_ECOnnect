import 'package:econnect/model/post.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class EditPostButton extends StatelessWidget {
  const EditPostButton({
    super.key,
    required this.post,
  });

  final Post post;

  void _onPressed(BuildContext context) {
    Navigator.pushNamed(context, '/editpost', arguments: post);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _onPressed(context),
      icon: const Icon(LucideIcons.pencil),
    );
  }
}