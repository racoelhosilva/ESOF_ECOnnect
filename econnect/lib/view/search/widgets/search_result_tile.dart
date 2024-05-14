import 'package:cached_network_image/cached_network_image.dart';
import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/user.dart';
import 'package:econnect/view/profile/widgets/follow_button.dart';
import 'package:flutter/material.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({
    super.key,
    required this.dbController,
    required this.sessionController,
    required this.user,
  });

  final DatabaseController dbController;
  final SessionController sessionController;
  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(user.profilePicture),
      ),
      title: Text(user.username),
      subtitle: Text(user.description ?? ""),
      trailing: FollowButton(
        dbController: dbController,
        sessionController: sessionController,
        userId: user.id,
      ),
      onTap: () {
        Navigator.pushNamed(context, "/profile", arguments: user.id);
      },
    );
  }
}
