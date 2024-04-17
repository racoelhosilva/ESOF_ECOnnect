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

  Future<void> addPost(Post post) async {
    final posts = _db.collection('posts');

    await posts.add({
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
            title: '',
            image: post['image'],
            description: post['description']))
        .toList();
  }

  Future<void> addUser(User user) async {
    final users = _db.collection('users');

    final dbUser = users.doc(user.id);

    if ((await dbUser.get()).exists) {
      throw StateError("User with id ${user.id} already exists");
    }

    await dbUser.set({
      'id': user.id,
      'username': user.username,
      'email': user.email,
      'description': user.description,
      'profilePicture': user.profilePicture,
      'score': user.score,
      'isBlocked': user.isBlocked,
      'registerDatetime': user.registerDatetime,
      'isAdmin': user.admin,
    });
  }

  Future<User?> getUser(String id) async {
    final users = _db.collection('users');

    final dbUser = await users.doc(id).get();
    if (!dbUser.exists) {
      return null;
    }

    return User(
      id: dbUser['id'],
      username: dbUser['username'],
      email: dbUser['email'],
      description: dbUser['description'],
      profilePicture: dbUser['profilePicture'],
      score: dbUser['score'],
      isBlocked: dbUser['isBlocked'],
      registerDatetime: (dbUser['registerDatetime'] as Timestamp).toDate(),
      admin: dbUser['isAdmin'],
    );
  }
}
