import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/user.dart';
import 'package:econnect/view/profile/widgets/follow_button.dart';
import 'package:econnect/view/profile/widgets/logout_button.dart';
import 'package:econnect/view/profile/widgets/profile_description.dart';
import 'package:econnect/view/profile/widgets/profile_image.dart';
import 'package:econnect/view/profile/widgets/settings_button.dart';
import 'package:econnect/view/profile/widgets/user_posts.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.dbController,
    required this.sessionController,
    required this.userId,
  });

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
                      ProfileImage(
                        imageUrl: user.profilePicture,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        alignment: Alignment.topLeft,
                        child: const BackButton(),
                      ),
                      if (user.id == widget.sessionController.loggedInUser!.id)
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: const SettingsButton(),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: LogoutButton(
                                      sessionController:
                                          widget.sessionController),
                                )
                              ],
                            ))
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              user.username,
                              style: const TextStyle(
                                fontFamily: "Karla",
                                color: Colors.white,
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                              ),
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
                  ProfileDescription(description: user.description),
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
