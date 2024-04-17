import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/view/login/widgets/login_page_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(
      {super.key,
      required this.dbController,
      required this.sessionController,
      required this.emailController,
      required this.passwordController});

  final DatabaseController dbController;
  final SessionController sessionController;
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

        try {
          await sessionController.loginUser(
              emailController.text, passwordController.text, dbController);
        } on FirebaseAuthException catch (e) {
          if (!context.mounted) {
            Logger().e(e);
            return;
          }

          switch (e.code) {
            case 'invalid-email':
              Fluttertoast.showToast(
                msg: 'Invalid email',
                backgroundColor: Theme.of(context).colorScheme.error,
              );
              break;
            case 'invalid-credential':
              Fluttertoast.showToast(
                msg: 'User not found',
                backgroundColor: Theme.of(context).colorScheme.error,
              );
              break;
            case 'wrong-password':
              Fluttertoast.showToast(
                msg: 'Wrong password',
                backgroundColor: Theme.of(context).colorScheme.error,
              );
              break;
            default:
              Logger().e(e);
              Fluttertoast.showToast(
                msg: 'Unknown error',
                backgroundColor: Theme.of(context).colorScheme.error,
              );
          }
          return;
        }

        if (!context.mounted) {
          return;
        }

        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      },
    );
  }
}
