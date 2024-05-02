import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, '/settings');
      },
      icon: const Icon(LucideIcons.settings),
    );
  }
}
