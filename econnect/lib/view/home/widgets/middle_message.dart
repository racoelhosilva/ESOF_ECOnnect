import 'package:flutter/material.dart';

class MiddleMessage extends StatelessWidget {
  const MiddleMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Text(
          'There is nothing more from the people you follow!',
          style: TextStyle(
              fontSize: 24.0,
              fontFamily: 'Karla',
              color: Theme.of(context).colorScheme.onBackground),
          textAlign: TextAlign.center,
        )),
        Center(
            child: Text(
          'Check more posts from strangers!',
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