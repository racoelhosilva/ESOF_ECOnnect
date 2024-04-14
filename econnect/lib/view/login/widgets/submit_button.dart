import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/view/login/widgets/login_page_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.dbController, required this.emailController, required this.passwordController, required this.usernameController,});

  final DatabaseController dbController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {
    return LoginPageButton(
      color: Theme.of(context).colorScheme.outline,
      text: 'Submit',
      onPressed: () async {
        if (emailController.text.isEmpty && passwordController.text.isEmpty && usernameController.text.isEmpty) {
          Fluttertoast.showToast(
            msg: 'Please fill all the fields',
            backgroundColor: Theme.of(context).colorScheme.error,
          );
          return;
        }

        final user = await dbController.createUser(
          emailController.text,
          usernameController.text,
          passwordController.text,
        );

        if (!context.mounted) {
          return;
        }

        if (user == null) {
          Fluttertoast.showToast(
            msg: 'User already exists',
            backgroundColor: Theme.of(context).colorScheme.error,
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
        }
      },
    );
  }
}
