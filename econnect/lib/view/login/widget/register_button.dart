import 'package:econnect/view/login/widget/login_page_button.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginPageButton(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      text: 'Register',
      onPressed: () {},
    );
  }
}
