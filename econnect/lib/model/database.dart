import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/model/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import 'comment.dart';

class Database {
  Database(FirebaseFirestore firestore, FirebaseStorage storage)
      : _db = firestore,
        _storageRef = storage.ref();

  final FirebaseFirestore _db;
  final Reference _storageRef;

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
      'image': post.image,
      'description': post.description,
      'postDatetime': post.postDatetime,
      'likes': 0,
    });
  }

  Future<void> updatePost(String postId, String postDescription) async {
    Logger().i('Updating post with id $postId, $postDescription');
    await _db
        .collection('posts')
        .doc(postId)
        .update({'description': postDescription});
  }

  Future<void> deletePost(String postId) async {
    Logger().i('Deleting post with id $postId');
    await _db.collection('posts').doc(postId).delete();
    await _db
        .collection('likes')
        .where('post', isEqualTo: postId)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
    await _db
        .collection('comments')
        .where('post', isEqualTo: postId)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  Future<(List<Post>, String?)> getNextPosts(
      String? cursor, int numDocs) async {
    final posts = _db.collection('posts');
    Query<Map<String, dynamic>> query =
        posts.orderBy('postDatetime', descending: true);
    if (cursor != null) {
      final fromDoc = await posts.doc(cursor).get();
      query = query.startAfterDocument(fromDoc);
    }
    query = query.limit(numDocs);
    final snapshot = await query.get();
    return (
      snapshot.docs
          .map((post) => Post(
                postId: post.id,
                user: post['user'],
                image: post['image'],
                description: post['description'],
                postDatetime: (post['postDatetime'] as Timestamp).toDate(),
                likes: post['likes'],
              ))
          .toList(),
      snapshot.docs.isNotEmpty ? snapshot.docs.last.id : null,
    );
  }

  Future<(List<Post>, String?)> getNextPostsOfFollowing(
      String userId, int numDocs, String? cursor) async {
    final posts = _db.collection('posts');
    final following = await getFollowing(userId);
    if (following.isEmpty) {
      return (<Post>[], null);
    }

    Query<Map<String, dynamic>> query = posts
        .where('user', whereIn: following)
        .orderBy('user')
        .orderBy('postDatetime', descending: true);
    if (cursor != null) {
      final fromDoc = await posts.doc(cursor).get();
      query = query.startAfterDocument(fromDoc);
    }
    query = query.limit(numDocs);
    final snapshot = await query.get();
    return (
      snapshot.docs
          .map((post) => Post(
              postId: post.id,
              user: post['user'],
              image: post['image'],
              description: post['description'],
              postDatetime: (post['postDatetime'] as Timestamp).toDate(),
              likes: post['likes']))
          .toList(),
      snapshot.docs.isNotEmpty ? snapshot.docs.last.id : null,
    );
  }

  Future<(List<Post>, String?)> getNextPostsOfNonFollowing(
      String userId, int numDocs, String? cursor) async {
    final posts = _db.collection('posts');
    final following = await getFollowing(userId);

    Query<Map<String, dynamic>> query = following.isNotEmpty
        ? posts
            .where('user', whereNotIn: following)
            .orderBy('user')
            .orderBy('postDatetime', descending: true)
        : posts.orderBy('postDatetime', descending: true);

    if (cursor != null) {
      final fromDoc = await posts.doc(cursor).get();
      query = query.startAfterDocument(fromDoc);
    }
    query = query.limit(numDocs);
    final snapshot = await query.get();
    return (
      snapshot.docs
          .map((post) => Post(
                postId: post.id,
                user: post['user'],
                image: post['image'],
                description: post['description'],
                postDatetime: (post['postDatetime'] as Timestamp).toDate(),
                likes: post['likes'],
              ))
          .toList(),
      snapshot.docs.isNotEmpty ? snapshot.docs.last.id : null,
    );
  }

  Future<(List<Post>, String?)> getNextPostsFromUser(
      String userId, int numDocs, String? cursor) async {
    final posts = _db.collection('posts');
    var query = posts
        .where('user', isEqualTo: userId)
        .orderBy('postDatetime', descending: true);

    if (cursor != null) {
      final fromDoc = await posts.doc(cursor).get();
      query = query.startAfterDocument(fromDoc);
    }
    query = query.limit(numDocs);
    final snapshot = await query.get();
    return (
      snapshot.docs
          .map((post) => Post(
                postId: post.id,
                user: post['user'],
                image: post['image'],
                description: post['description'],
                postDatetime: (post['postDatetime'] as Timestamp).toDate(),
                likes: post['likes'],
              ))
          .toList(),
      snapshot.docs.isNotEmpty ? snapshot.docs.last.id : null,
    );
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

  Future<void> addLike(String userId, String postId) async {
    final likes = _db.collection('likes');
    final posts = _db.collection('posts');

    final dbLike = await likes
        .where('user', isEqualTo: userId)
        .where('post', isEqualTo: postId)
        .get();
    if (dbLike.docs.isEmpty) {
      await likes.add({
        'user': userId,
        'post': postId,
      });
      await posts.doc(postId).update({'likes': FieldValue.increment(1)});
    }
  }

  Future<void> removeLike(String userId, String postId) async {
    final likes = _db.collection('likes');
    final posts = _db.collection('posts');

    final dbLike = await likes
        .where('user', isEqualTo: userId)
        .where('post', isEqualTo: postId)
        .get();
    if (dbLike.docs.isNotEmpty) {
      await dbLike.docs.first.reference.delete();
      await posts.doc(postId).update({'likes': FieldValue.increment(-1)});
    }
  }

  Future<bool> isLiked(String userId, String postId) async {
    final likes = _db.collection('likes');

    final dbLike = await likes
        .where('user', isEqualTo: userId)
        .where('post', isEqualTo: postId)
        .get();
    return dbLike.docs.isNotEmpty;
  }

  Future<void> updateUser(User updatedUser) async {
    final users = _db.collection('users');

    final dbUser = users.doc(updatedUser.id);

    if (!(await dbUser.get()).exists) {
      throw StateError("User with id ${updatedUser.id} not found");
    }

    await dbUser.update({
      'username': updatedUser.username,
      'email': updatedUser.email,
      'description': updatedUser.description,
      'profilePicture': updatedUser.profilePicture,
      'score': updatedUser.score,
      'isBlocked': updatedUser.isBlocked,
      'registerDatetime': updatedUser.registerDatetime,
      'isAdmin': updatedUser.admin,
    });
  }

  Future<void> addFollow(String userId1, String userId2) async {
    final follows = _db.collection('follows');

    final dbFollow = await follows
        .where('follower', isEqualTo: userId1)
        .where('followed', isEqualTo: userId2)
        .get();

    if (dbFollow.docs.isNotEmpty) {
      throw StateError("User $userId1 already follows $userId2");
    }

    await follows.add({
      'follower': userId1,
      'followed': userId2,
    });
  }

  Future<void> removeFollow(String userId1, String userId2) async {
    final follows = _db.collection('follows');

    final dbFollow = await follows
        .where('follower', isEqualTo: userId1)
        .where('followed', isEqualTo: userId2)
        .get();

    if (dbFollow.docs.isEmpty) {
      throw StateError("User $userId1 does not follow $userId2");
    }

    await dbFollow.docs[0].reference.delete();
  }

  Future<List<String>> getFollowing(String userId) async {
    final follows = _db.collection('follows');

    final dbFollow = await follows.where('follower', isEqualTo: userId).get();

    return dbFollow.docs.map<String>((follows) => follows['followed']).toList();
  }

  Future<bool> isFollowing(String userId1, String userId2) async {
    final follows = _db.collection('follows');

    final dbFollow = await follows
        .where('follower', isEqualTo: userId1)
        .where('followed', isEqualTo: userId2)
        .get();

    return dbFollow.docs.isNotEmpty;
  }

  Future<void> addComment(String userId, String postId, String content) async {
    final comments = _db.collection('comments');

    await comments.add({
      'user': userId,
      'post': postId,
      'content': content,
      'commentDatetime': DateTime.now(),
    });
  }

  Future<void> deleteComment(String commentId) async {
    final comments = _db.collection('comments');

    await comments.doc(commentId).delete();
  }

  Future<(List<Comment>, String?)> getNextComments(
      String postId, String? cursor, int numDocs) async {
    final comments = _db.collection('comments');
    final users = _db.collection('users');

    Query<Map<String, dynamic>> query = comments
        .where('post', isEqualTo: postId)
        .orderBy('commentDatetime', descending: true);

    if (cursor != null) {
      final fromDoc = await comments.doc(cursor).get();
      query = query.startAfterDocument(fromDoc);
    }
    query = query.limit(numDocs);
    final snapshot = await query.get();

    final List<Comment> commentsList = [];
    await Future.forEach(
      snapshot.docs,
      (commentDoc) async {
        final userData = await users.doc(commentDoc['user']).get();
        commentsList.add(
          Comment(
            commentId: commentDoc.id,
            userId: commentDoc['user'],
            username: userData['username'],
            profilePicture: userData['profilePicture'],
            postId: commentDoc['post'],
            comment: commentDoc['content'],
            commentDatetime:
                (commentDoc['commentDatetime'] as Timestamp).toDate(),
          ),
        );
      },
    );

    return (
      commentsList,
      snapshot.docs.isNotEmpty ? snapshot.docs.last.id : null
    );
  }

  Future<List<User>> searchUsers(String query, int numUsers) async {
    final users = _db.collection('users');
    final snapshot = await users
        .orderBy('username')
        .startAt([query])
        .endAt(['$query\uf8ff'])
        .limit(numUsers)
        .get();
    return snapshot.docs
        .map((user) => User(
              id: user['id'],
              username: user['username'],
              email: user['email'],
              description: user['description'],
              profilePicture: user['profilePicture'],
              score: user['score'],
              isBlocked: user['isBlocked'],
              registerDatetime:
                  (user['registerDatetime'] as Timestamp).toDate(),
              admin: user['isAdmin'],
            ))
        .toList();
  }
}
