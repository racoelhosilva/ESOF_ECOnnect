import 'package:flutter/material.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({super.key});

  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(user.profilePicture),
      ),
      title: Text(user.username),
      subtitle: Text(user.description ?? ""),
      trailing: FollowButton(
          dbController: widget.dbController,
          sessionController: widget.sessionController,
          userId: user.id),
      onTap: () {
        Navigator.pushNamed(context, "/profile", arguments: user.id);
      },
    );
  }
}
