import 'package:flutter/material.dart';

class FollowButton extends StatefulWidget {
  const FollowButton({super.key});

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool isFollowing = false;

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
    // Call your toggleFollow function here
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toggleFollow();
      },
      child: Icon(
        isFollowing ? Icons.star : Icons.star_border,
        color: isFollowing
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onPrimaryContainer,
        size: 28.0,
      ),
    );
  }
}
