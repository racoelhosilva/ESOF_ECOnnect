import 'package:econnect/view/commons/app_logo.dart';
import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 32, // Setting fixed width for BackButton
          child: BackButton(),
        ),
        const Expanded(
          child: AppLogo(),
        ),
        SizedBox(
          width: 32, // Adding a widget at the end with the same size
          child: Container(),
        ),
      ],
    );
  }
}
