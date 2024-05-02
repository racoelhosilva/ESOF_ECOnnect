import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/view/login/widgets/login_page_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SubmitButton extends StatefulWidget {
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
  State<StatefulWidget> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool _isLoading = false;

  dynamic _onPressed(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    if (widget.emailController.text.isEmpty &&
        widget.passwordController.text.isEmpty &&
        widget.usernameController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please fill all the fields',
        backgroundColor: Theme.of(context).colorScheme.error,
      );
      return;
    }

    try {
      await widget.sessionController.registerUser(
          widget.emailController.text,
          widget.passwordController.text,
          widget.usernameController.text,
          widget.dbController);
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) {
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
          Fluttertoast.showToast(
            msg: 'Unknown error',
            backgroundColor: Theme.of(context).colorScheme.error,
          );
      }
      return;
    }

    setState(() {
      _isLoading = false;
    });

    if (!context.mounted) {
      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return LoginPageButton(
      color: Theme.of(context).colorScheme.outline,
      text: 'Submit',
      onPressed: () => _onPressed(context),
    );
  }
}
