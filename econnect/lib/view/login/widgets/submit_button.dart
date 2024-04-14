import 'package:econnect/view/login/widgets/login_page_button.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginPageButton(
      color: Theme.of(context).colorScheme.outline,
      text: 'Submit',
      onPressed: () {
        Navigator.popAndPushNamed(context, '/home');
      },
    );
  }
}
