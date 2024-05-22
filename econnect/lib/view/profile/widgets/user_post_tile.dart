import 'package:cached_network_image/cached_network_image.dart';
import 'package:econnect/model/post.dart';
import 'package:flutter/material.dart';

class UserPostTile extends StatelessWidget {
  const UserPostTile({
    super.key,
    required this.userIsOwner,
    required this.post,
  });

  final bool userIsOwner;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/postpage", arguments: post);
      },
      onDoubleTap: () async {
        if (userIsOwner) {
          Navigator.pushNamed(context, "/editpost", arguments: post);
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 2,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: CachedNetworkImage(
          imageUrl: post.image,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.width * 4 / 9,
        ),
      ),
    );
  }
}
