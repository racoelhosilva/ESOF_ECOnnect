import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/view/commons/bottom_navbar.dart';
import 'package:econnect/view/commons/header_widget.dart';
import 'package:econnect/view/create_post/widgets/description_widget.dart';
import 'package:econnect/view/create_post/widgets/image_widget.dart';
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
  final TextEditingController _descriptionController = TextEditingController();
  String? _imagePath;

  void setImagePath(String? newPath) {
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
          ImageWidget(_imagePath, setImagePath: setImagePath),
          DescriptionWidget(controller: _descriptionController),
          ElevatedButton(
            onPressed: () {
              // salvar settings
            },
            child: const Text('Save'),
          ),
        ],
      ),
      extendBody: true,
    );
  }
}
