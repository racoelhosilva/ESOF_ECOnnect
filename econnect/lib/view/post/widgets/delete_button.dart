import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      child: const Icon(LucideIcons.trash2),
    );
  }
}
