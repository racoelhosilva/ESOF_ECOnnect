import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/view/commons/bottom_navbar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage(
      {super.key, required this.dbController, required this.sessionController});

  final DatabaseController dbController;
  final SessionController sessionController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(),
      body: ListView(
        children: const [
          Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: BackButton(),
              )
            ],
          )
        ],
      ),
      extendBody: true,
    );
  }
}
