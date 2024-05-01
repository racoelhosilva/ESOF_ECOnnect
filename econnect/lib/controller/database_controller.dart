import 'package:econnect/model/database.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/model/user.dart';
import 'package:uuid/uuid.dart';

class DatabaseController {
  const DatabaseController({required this.db});
  final Database db;

  Future<void> createPost(
  {required String user, required String imgPath, required String description}) async {
    final image = await db.storeImage(imgPath);
    final post = Post(
        postId: const Uuid().v4(),
        user: user,
        image: await db.retrieveFileUrl(image),
        description: description,
        postDatetime: DateTime.now());

    await db.addPost(post);
    return;
  }

  Future<void> updatePost(String? postId, String postDescription) async =>
    await db.updatePost(postId!, postDescription);

  Future<void> deletePost(String? postId) async =>
      await db.deletePost(postId!);
  

  Future<List<Post>> getNextPosts(int numDocs) async =>
      await db.getNextPosts(numDocs);

  void resetPostsCursor() => db.resetPostsCursor();

  Future<User?> createUser(String id, String email, String username) async {
    final user = User(
      id: id,
      email: email,
      username: username,
      score: 0,
      isBlocked: false,
      registerDatetime: DateTime.now(),
      admin: false,
      profilePicture: "",
    );
    await db.addUser(user);
    return user;
  }

  Future<User?> getUser(String id) async => await db.getUser(id);
}
