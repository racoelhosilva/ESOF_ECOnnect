import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/profile');
        },
        icon: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          radius: 25,
          child: Image.asset(
            'assets/png/logo_white.png',
            width: 50,
            height: 50,
          ),
        ));
  }
}
