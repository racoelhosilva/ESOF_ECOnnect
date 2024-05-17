import 'package:flutter/material.dart';

class ProfileDescription extends StatelessWidget {
  const ProfileDescription({super.key, required this.description});

  final String? description;

  @override
  Widget build(BuildContext context) {
    if (description == null || description!.isEmpty) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 20.0,
            top: 4.0,
            bottom: 4.0,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Description",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: "Karla",
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 4.0,
            bottom: 12.0,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              description!,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontFamily: "Karla",
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
