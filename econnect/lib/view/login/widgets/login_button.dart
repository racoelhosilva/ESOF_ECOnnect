import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/view/login/widgets/login_page_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({
    super.key,
    required this.dbController,
    required this.sessionController,
    required this.emailController,
    required this.passwordController,
  });

  final DatabaseController dbController;
  final SessionController sessionController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<StatefulWidget> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool _isLoading = false;

  dynamic _onPressed(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    if (widget.emailController.text.isEmpty ||
        widget.passwordController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please fill all the fields',
        backgroundColor: Theme.of(context).colorScheme.error,
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      await widget.sessionController.loginUser(widget.emailController.text,
          widget.passwordController.text, widget.dbController);
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) {
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
          Fluttertoast.showToast(
            msg: 'Unknown error',
            backgroundColor: Theme.of(context).colorScheme.error,
          );
      }

      setState(() {
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = false;
    });

    if (!context.mounted) {
      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        width: 100,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return LoginPageButton(
      color: Theme.of(context).colorScheme.outline,
      text: 'Login',
      onPressed: () => _onPressed(context),
    );
  }
}
