import 'package:cached_network_image/cached_network_image.dart';
import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/user.dart';
import 'package:econnect/view/commons/bottom_navbar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage(
      {super.key, required this.dbController, required this.sessionController, required this.user});

  final DatabaseController dbController;
  final SessionController sessionController;
  final User user;

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
                child: CachedNetworkImage(
                  imageUrl: user.profilePicture,
                  fit: BoxFit.cover,
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: BackButton(),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                user.username,
                style: const TextStyle(
                    fontFamily: "Karla",
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: user.description != null && user.description!.isNotEmpty ? 
              Text(user.description!, textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: "Karla",
                color: Colors.white,
                fontSize: 14.0,
              ),
            )
            : null
          ),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
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
