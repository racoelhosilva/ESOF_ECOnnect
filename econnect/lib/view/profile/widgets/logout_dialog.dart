import 'package:econnect/controller/session_controller.dart';
import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({
    super.key,
    required this.sessionController,
  });

  final SessionController sessionController;

  void logout(BuildContext context) {
    sessionController.logout();
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          key: const Key('dialog_logout_button'),
          onPressed: () => logout(context),
          child: const Text('Logout'),
        )
      ],
    );
  }
}
