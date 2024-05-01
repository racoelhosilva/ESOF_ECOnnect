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
        shrinkWrap: true,
        children: [
          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/png/logo_white.png', // TODO: change image to user pfp
                  fit: BoxFit.cover,
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: BackButton(),
              ),
            ],
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Username 123",
                style: TextStyle(
                    fontFamily: "Karla",
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Changing the world one action at a time. Join me on my journey so we can change the world together!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Karla",
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 3,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(15, (index) {
              return Center(
                child: Text(
                  'Item $index',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              );
            }),
          ),
        ],
      ),
      extendBody: true,
    );
  }
}
