import 'dart:io';

import 'package:econnect/model/database.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/model/user.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseController {
  const DatabaseController({required this.db});
  final Database db;

  Future<Post> createPost(
      String user, String imgPath, String description) async {
    final image = await db.storeImage(imgPath);
    final post = Post(
        user: user,
        image: await db.retrieveFileUrl(image),
        description: description,
        postDatetime: DateTime.now());
    await db.addPost(post);
    return post;
  }

  Future<List<Post>> getNextPosts(int numDocs) async =>
      await db.getNextPosts(numDocs);

  void resetPostsCursor() => db.resetPostsCursor();

  Future<User?> createUser(String id, String email, String username) async {
    // TODO: Remove this
    final pictureAsset = await rootBundle.load('assets/png/logo_white.png');
    final directory = await getTemporaryDirectory();
    var pictureFile = File('${directory.path}/logo_white.png');
    pictureFile.writeAsBytesSync(pictureAsset.buffer.asUint8List());

    final user = User(
      id: id,
      email: email,
      username: username,
      score: 0,
      isBlocked: false,
      registerDatetime: DateTime.now(),
      admin: false,
      profilePicture: await db.storeImage('${directory.path}/logo_white.png'),
    );
    await db.addUser(user);
    return user;
  }

  Future<User?> getUser(String id) async => await db.getUser(id);
}
