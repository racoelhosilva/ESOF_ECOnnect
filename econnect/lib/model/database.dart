import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:econnect/model/post.dart';
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
    CollectionReference posts = _db.collection('posts');

    posts.add({
      'user': post.user,
      'image': post.image,
      'description': post.description,
      'postDatetime': post.postDatetime,
    });
  }

  Future<List<Post>> getPosts() async {
    final posts = _db.collection('posts');
    final snapshot = await posts.get();
    return snapshot.docs
        .map((post) => Post(
              user: post['user'],
              image: post['image'],
              description: post['description'],
              postDatetime: (post['postDatetime'] as Timestamp).toDate(),
            ))
        .toList();
  }
}
