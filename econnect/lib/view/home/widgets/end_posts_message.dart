import 'package:flutter/material.dart';

class EndPostsMessage extends StatelessWidget {
  const EndPostsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Text(
          'You\'re all caught up!',
          style: TextStyle(
              fontSize: 24.0,
              fontFamily: 'Karla',
              color: Theme.of(context).colorScheme.onBackground),
          textAlign: TextAlign.center,
        )),
        Center(
            child: Text(
          'There are no more posts to see!',
          style: TextStyle(
              fontSize: 16.0,
              fontFamily: 'Karla',
              color: Theme.of(context).colorScheme.onBackground),
          textAlign: TextAlign.center,
        )),
      ],
    );
  }
}
