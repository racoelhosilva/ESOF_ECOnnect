import 'package:cached_network_image/cached_network_image.dart';
import 'package:econnect/model/user.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/profile', arguments: user.id);
        },
        icon: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          clipBehavior: Clip.hardEdge,
          child: CachedNetworkImage(
            imageUrl: user.profilePicture,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ));
  }
}
