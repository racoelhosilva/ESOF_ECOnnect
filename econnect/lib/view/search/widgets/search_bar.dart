import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onTextChanged;

  const SearchWidget({
    super.key,
    required this.controller,
    required this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          prefixIcon: Icon(
            LucideIcons.search,
            size: 24,
          ),
          hintText: "Search for users",
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        onChanged: onTextChanged,
      ),
    );
  }
}
