import 'dart:io';

import 'package:econnect/model/database.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/model/user.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseController {
  const DatabaseController({required this.db});
  final Database db;

  Future<void> createPost(
      {required User user,
      required String imgPath,
      required String description}) async {
    final image = await db.storeImage(imgPath);
    final post = Post(
        postId: const Uuid().v4(),
        user: user.id,
        image: await db.retrieveFileUrl(image),
        description: description,
        postDatetime: DateTime.now());

    await db.addPost(post);
    return;
  }

  Future<void> updatePost(String? postId, String postDescription) async =>
      await db.updatePost(postId!, postDescription);

  Future<void> deletePost(String? postId) async => await db.deletePost(postId!);

  Future<(List<Post>, String?)> getNextPosts(
          String? cursor, int numDocs) async =>
      await db.getNextPosts(cursor, numDocs);

  Future<(List<Post>, String?)> getNextPostsOfFollowing(
          String? cursor, int numDocs, String userId) async =>
      await db.getNextPostsOfFollowing(cursor, numDocs, userId);

  Future<(List<Post>, String?)> getNextPostsOfNonFollowing(
          String? cursor, int numDocs, String userId) async =>
      await db.getNextPostsOfNonFollowing(cursor, numDocs, userId);

  Future<List<Post>> getPostsFromUser(String userId) async =>
      await db.getPostsFromUser(userId);

  Future<void> addLike(String userId, String postId) async =>
      await db.addLike(userId, postId);

  Future<void> removeLike(String userId, String postId) async =>
      await db.removeLike(userId, postId);

  Future<bool> isLiked(String userId, String postId) async =>
      await db.isLiked(userId, postId);

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

  Future<void> addFollow(String followerId, String followedId) async {
    await db.addFollow(followerId, followedId);
  }

  Future<void> removeFollow(String followerId, String followedId) async {
    await db.removeFollow(followerId, followedId);
  }

  Future<List<String>> getFollowing(String userId) async =>
      await db.getFollowing(userId);

  Future<bool> isFollowing(String followerId, String followedId) async =>
      await db.isFollowing(followerId, followedId);
}
