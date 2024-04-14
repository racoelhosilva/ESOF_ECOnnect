import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/model/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class Database {
  final _db = FirebaseFirestore.instance;
  final _storageRef = FirebaseStorage.instance.ref();

  Future<String> storeImage(String path) async {
    final name = 'img/${const Uuid().v4()}.png';
    try {
      await _storageRef.child(name).putFile(File(path));
    } on FirebaseException catch (e) {
      Logger().e("An error occurred while uploading file: $e");
      rethrow;
    }
    return name;
  }

  Future<String> retrieveFileUrl(String name) {
    try {
      return _storageRef.child(name).getDownloadURL();
    } on FirebaseException catch (e) {
      Logger().e("An error occurred while retrieving file: $e");
      rethrow;
    }
  }

  void addPost(Post post) {
    final posts = _db.collection('posts');

    posts.add({
      'user': post.user,
      'title': post.title,
      'image': post.image,
      'description': post.description,
    });
  }

  Future<List<Post>> getPosts() async {
    final posts = _db.collection('posts');
    final snapshot = await posts.get();

    return snapshot.docs
        .map((post) => Post(
            user: post['user'],
            title: post['title'],
            image: post['image'],
            description: post['description']))
        .toList();
  }

  Future<bool> addUser(User user) async {
    if (user.password == null) {
      Logger().e(
          "Failed to insert user with email ${user.email} on the database: Password is null\n");
      return false;
    }

    final users = _db.collection('users');

    final filteredUsers =
        await users.where('email', isEqualTo: user.email).get();
    if (filteredUsers.docs.isNotEmpty) {
      Logger().e(
          "Failed to insert user with email ${user.email} on the database: Alrady exists\n");
      return false;
    }

    users.add({
      'username': user.username,
      'email': user.email,
      'password': user.password,
      'description': user.description,
      'profilePicture': user.profilePicture,
      'score': user.score,
      'isBlocked': user.isBlocked,
      'registerDatetime': user.registerDatetime,
      'isAdmin': user.admin,
    });
    return true;
  }

  Future<User?> getUser(String email) async {
    final users = _db.collection('users');

    final filteredUsers = await users.where('email', isEqualTo: email).get();
    if (filteredUsers.docs.isEmpty) {
      return null;
    }

    final user = filteredUsers.docs[0];
    return User(
      username: user['username'],
      email: user['email'],
      description: user['description'],
      profilePicture: user['profilePicture'],
      score: user['score'],
      isBlocked: user['isBlocked'],
      registerDatetime: user['registerDatetime'],
      admin: user['isAdmin'],
    );
  }

  Future<User?> getUserWithPassword(
    String email,
    String password,
  ) async {
    final users = _db.collection('users');

    final filteredUsers = await users.where('email', isEqualTo: email).get();
    if (filteredUsers.docs.isEmpty) {
      Logger().e("No user found with email $email");
      return null;
    }

    final user = filteredUsers.docs[0];

    if (user['password'] != password) {
      TODO: Logger().e("Password does not match for user with email $email");
      return null;
    }

    return User(
      username: user['username'],
      email: user['email'],
      password: user['password'],
      description: user['description'],
      profilePicture: user['profilePicture'],
      score: user['score'],
      isBlocked: user['isBlocked'],
      registerDatetime: (user['registerDatetime'] as Timestamp).toDate(),
      admin: user['isAdmin'],
    );
  }
}
