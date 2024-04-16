import 'package:econnect/view/commons/logo_widget.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 32, // Setting fixed width for BackButton
          child: BackButton(),
        ),
        const Expanded(
          child: LogoWidget(),
        ),
        SizedBox(
          width: 32, // Adding a widget at the end with the same size
          child: Container(),
        ),
      ],
    );
  }
}
