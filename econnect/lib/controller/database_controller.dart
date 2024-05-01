import 'dart:io';

import 'package:econnect/model/database.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/model/user.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseController {
  const DatabaseController({required this.db});
  final Database db;

  Future<Post> createPost(User user, String imgPath, String description) async {
    final image = await db.storeImage(imgPath);
    final post = Post(
        user: user.id,
        image: await db.retrieveFileUrl(image),
        description: description,
        postDatetime: DateTime.now());
    await db.addPost(post);
    return post;
  }

  Future<List<Post>> getNextPosts(int numDocs) async =>
      await db.getNextPosts(numDocs);

  void resetPostsCursor() => db.resetPostsCursor();

  Future<List<Post>> getPostsFromUser(String userId) async =>
      await db.getPostsFromUser(userId);

  Future<User?> createUser(String id, String email, String username) async {
    final pictureAsset =
        await rootBundle.load('assets/png/default_profile.png');
    final directory = await getTemporaryDirectory();
    var pictureFile = File('${directory.path}/default_profile.png');
    pictureFile.writeAsBytesSync(pictureAsset.buffer.asUint8List());

    final profilePicture =
        await db.storeImage('${directory.path}/default_profile.png');
    final user = User(
      id: id,
      email: email,
      username: username,
      score: 0,
      isBlocked: false,
      registerDatetime: DateTime.now(),
      admin: false,
      profilePicture: await db.retrieveFileUrl(profilePicture),
    );
    await db.addUser(user);
    return user;
  }

  Future<User?> getUser(String id) async => await db.getUser(id);

  Future<User?> updateUser(User updatedUser, String imgPath) async {
    final image = await db.storeImage(imgPath);
    final finalUser = User(
      id: updatedUser.id,
      email: updatedUser.email,
      username: updatedUser.username,
      description: updatedUser.description,
      profilePicture: await db.retrieveFileUrl(image),
      score: updatedUser.score,
      isBlocked: updatedUser.isBlocked,
      registerDatetime: updatedUser.registerDatetime,
      admin: updatedUser.admin,
    );
    await db.updateUser(finalUser);
    return finalUser;
  }
}
