import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  void logout() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: logout,
      icon: const Icon(LucideIcons.logOut),
    );
  }
}