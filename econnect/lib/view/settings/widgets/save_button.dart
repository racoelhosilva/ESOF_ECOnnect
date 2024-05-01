import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/user.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatefulWidget {
  const SaveButton(
      {super.key,
      required this.dbController,
      required this.sessionController,
      required this.usernameController,
      required this.descriptionController,
      required this.newProfilePicturePath});

  final DatabaseController dbController;
  final SessionController sessionController;
  final TextEditingController usernameController;
  final TextEditingController descriptionController;
  final String? newProfilePicturePath;

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool _isLoading = false;

  void _onPressed(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    final oldUser = widget.sessionController.loggedInUser!;
    final newUser = User(
      id: oldUser.id,
      email: oldUser.email,
      username: widget.usernameController.text,
      description: widget.descriptionController.text,
      profilePicture: widget.newProfilePicturePath!,
      score: oldUser.score,
      isBlocked: oldUser.isBlocked,
      registerDatetime: oldUser.registerDatetime,
      admin: oldUser.admin,
    );
    await widget.sessionController.updateUser(newUser, widget.dbController);

    setState(() {
      _isLoading = false;
    });

    if (!context.mounted) {
      return;
    }

    var i = 2;
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/profile', arguments: newUser.id, (route) => i-- == 0);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.outline,
      ),
      onPressed: () => _onPressed(context),
      child: Text(
        'Save',
        style: TextStyle(
          fontFamily: 'Karla',
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
