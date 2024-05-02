import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/utils/download_image.dart';
import 'package:econnect/view/commons/bottom_navbar.dart';
import 'package:econnect/view/commons/header_widget.dart';
import 'package:econnect/view/create_post/widgets/image_editor.dart';
import 'package:econnect/view/create_post/widgets/description_field.dart';
import 'package:econnect/view/settings/widgets/save_button.dart';
import 'package:econnect/view/settings/widgets/username_field.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage(
      {super.key, required this.dbController, required this.sessionController});

  final DatabaseController dbController;
  final SessionController sessionController;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final TextEditingController _descriptionController;
  late final TextEditingController _usernameController;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    if (widget.sessionController.loggedInUser == null) {
      throw StateError('User not logged in');
    }

    _descriptionController = TextEditingController(
        text: widget.sessionController.loggedInUser!.description);
    _usernameController = TextEditingController(
        text: widget.sessionController.loggedInUser!.username);
    setInitialPagePath();
  }

  Future<void> setInitialPagePath() async {
    final initImagePath = await downloadImageToTemp(
        widget.sessionController.loggedInUser!.profilePicture);
    setImagePath(initImagePath);
  }

  void setImagePath(String newPath) {
    setState(() {
      _imagePath = newPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const HeaderWidget(),
          ImageEditor(
            _imagePath,
            setImagePath: setImagePath,
            proportion: 1,
          ),
          UsernameField(controller: _usernameController),
          DescriptionField(controller: _descriptionController),
          SaveButton(
            dbController: widget.dbController,
            sessionController: widget.sessionController,
            usernameController: _usernameController,
            descriptionController: _descriptionController,
            newProfilePicturePath: _imagePath,
          ),
          const SizedBox(
            height: 100.0,
          ),
        ],
      ),
    );
  }
}
