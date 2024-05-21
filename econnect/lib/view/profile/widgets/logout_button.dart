import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/view/profile/widgets/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
    required this.sessionController,
  });

  final SessionController sessionController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: (context) =>
            LogoutDialog(sessionController: sessionController),
      ),
      icon: const Icon(LucideIcons.logOut),
    );
  }
}
