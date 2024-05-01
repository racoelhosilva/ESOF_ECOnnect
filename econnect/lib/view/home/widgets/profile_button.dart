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
          Navigator.pushNamed(context, '/profile', arguments: user);
        },
        icon: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          radius: 25,
          child: CachedNetworkImage(
            imageUrl: user.profilePicture,
            width: 50,
            height: 50,
          ),
        ));
  }
}
