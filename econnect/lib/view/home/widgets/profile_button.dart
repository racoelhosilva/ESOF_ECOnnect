import 'package:cached_network_image/cached_network_image.dart';
import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/model/user.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton(
      {super.key, required this.userId, required this.dbController});

  final String userId;
  final DatabaseController dbController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: dbController.getUser(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            throw StateError('User with id $userId not found');
          } else {
            final user = snapshot.data!;
            return IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile', arguments: userId);
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
              ),
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
