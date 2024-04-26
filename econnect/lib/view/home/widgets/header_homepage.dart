import 'package:econnect/view/commons/logo_widget.dart';
import 'package:econnect/view/home/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class HeaderHomepage extends StatelessWidget {
  const HeaderHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.center,
          child: LogoWidget(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: const ProfileWidget(),
            ),
          ),
        ),
      ],
    );
  }
}
