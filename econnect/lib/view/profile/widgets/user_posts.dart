import 'package:cached_network_image/cached_network_image.dart';
import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/model/post.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class UserPosts extends StatelessWidget {
  const UserPosts(
      {super.key,
      required this.dbController,
      required this.sessionController,
      required this.userId});

  final DatabaseController dbController;
  final SessionController sessionController;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: dbController.getPostsFromUser(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final posts = snapshot.data;
          return GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: .75,
            children: [
              if (userId == sessionController.loggedInUser!.id)
                GestureDetector(
                    onTap: () async {
                      Navigator.pushNamed(context, "/createpost");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.width * 4 / 9,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        LucideIcons.plus,
                        size: 48,
                        color: Colors.grey,
                      ),
                    )),
              ...?posts?.map((post) {
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    imageUrl: post.image,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width * 4 / 9,
                  ),
                );
              })
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
