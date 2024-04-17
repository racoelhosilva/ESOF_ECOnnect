import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/view/login/widgets/login_page_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.dbController,
    required this.sessionController,
    required this.emailController,
    required this.passwordController,
    required this.usernameController,
  });

  final DatabaseController dbController;
  final SessionController sessionController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {
    return LoginPageButton(
      color: Theme.of(context).colorScheme.outline,
      text: 'Submit',
      onPressed: () async {
        if (emailController.text.isEmpty &&
            passwordController.text.isEmpty &&
            usernameController.text.isEmpty) {
          Fluttertoast.showToast(
            msg: 'Please fill all the fields',
            backgroundColor: Theme.of(context).colorScheme.error,
          );
          return;
        }

        try {
          await sessionController.registerUser(emailController.text,
              passwordController.text, usernameController.text, dbController);
        } on FirebaseAuthException catch (e) {
          if (!context.mounted) {
            Logger().e(e);
            return;
          }

          switch (e.code) {
            case 'email-already-in-use':
              Fluttertoast.showToast(
                msg: 'Email is already in use',
                backgroundColor: Theme.of(context).colorScheme.error,
              );
              break;
            case 'invalid-email':
              Fluttertoast.showToast(
                msg: 'Invalid email',
                backgroundColor: Theme.of(context).colorScheme.error,
              );
              break;
            case 'weak-password':
              Fluttertoast.showToast(
                msg: 'Weak password',
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

        Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
      },
    );
  }
}
