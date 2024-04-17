import 'package:econnect/view/login/widgets/login_page_button.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginPageButton(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      text: 'Register',
      onPressed: () {
        Navigator.of(context).pushNamed('/register');
      },
    );
  }
}
