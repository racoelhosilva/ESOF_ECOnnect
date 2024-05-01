import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  void _onPressed() {
    // salvar settings
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.outline,
      ),
      onPressed: () {
        // salvar settings
      },
      child: const Text(
        'Save',
        style: TextStyle(
          fontFamily: 'Karla',
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
