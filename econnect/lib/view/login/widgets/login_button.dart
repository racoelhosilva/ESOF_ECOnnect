import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/view/login/widgets/login_page_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(
      {super.key,
      required this.dbController,
      required this.emailController,
      required this.passwordController});

  final DatabaseController dbController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return LoginPageButton(
      color: Theme.of(context).colorScheme.outline,
      text: 'Login',
      onPressed: () async {
        if (emailController.text.isEmpty && passwordController.text.isEmpty) {
          Fluttertoast.showToast(
            msg: 'Please fill all the fields',
            backgroundColor: Theme.of(context).colorScheme.error,
          );
          return;
        }

        final user = await dbController.getUserWithPassword(
          emailController.text,
          passwordController.text,
        );

        if (!context.mounted) {
          return;
        }

        if (user == null) {
          Fluttertoast.showToast(
            msg: 'User not found',
            backgroundColor: Theme.of(context).colorScheme.error,
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/home',
            (route) => false,
          );
        }
      },
    );
  }
}
