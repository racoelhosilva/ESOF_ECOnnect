import 'package:cached_network_image/cached_network_image.dart';
import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/user.dart';
import 'package:econnect/view/profile/widgets/follow_button.dart';
import 'package:econnect/view/profile/widgets/settings_button.dart';
import 'package:econnect/view/profile/widgets/user_posts.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage(
      {super.key,
      required this.dbController,
      required this.sessionController,
      required this.userId});

  final DatabaseController dbController;
  final SessionController sessionController;
  final String userId;

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<User?> _userFuture = Future.any([]);
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _userFuture = widget.dbController.getUser(widget.userId);
    });
  }

  Future<void> _onRefresh() async {
    setState(() {
      _userFuture = widget.dbController.getUser(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          User user = snapshot.data!;
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: Scaffold(
              body: ListView(
                controller: _scrollController,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Stack(
                    children: [
                      Container(
                        foregroundDecoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xff1e1e1e),
                                Color(0x601e1e1e),
                                Color(0x001e1e1e),
                                Color(0x001e1e1e),
                                Color(0x601e1e1e),
                                Color(0xff1e1e1e),
                              ],
                              stops: [
                                0.0,
                                0.15,
                                0.25,
                                0.75,
                                0.85,
                                1.0
                              ]),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: user.profilePicture,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        alignment: Alignment.topLeft,
                        child: const BackButton(),
                      ),
                      if (user.id == widget.sessionController.loggedInUser!.id)
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          alignment: Alignment.topRight,
                          child: const SettingsButton(),
                        ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            user.username,
                            style: const TextStyle(
                              fontFamily: "Karla",
                              color: Colors.white,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (user.id !=
                              widget.sessionController.loggedInUser!.id)
                            FollowButton(
                              dbController: widget.dbController,
                              sessionController: widget.sessionController,
                              userId: widget.userId,
                            ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 16.0, right: 20.0, top: 4.0, bottom: 4.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Description",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Karla",
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 4.0, bottom: 12.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: user.description != null &&
                                user.description!.isNotEmpty
                            ? Text(
                                user.description!,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontFamily: "Karla",
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              )
                            : null),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 16.0, right: 20.0, top: 4.0, bottom: 12.0),
                    child: Text(
                      "Recent Activity",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "Karla",
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  UserPosts(
                    dbController: widget.dbController,
                    sessionController: widget.sessionController,
                    userId: widget.userId,
                    parentScrollController: _scrollController,
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
