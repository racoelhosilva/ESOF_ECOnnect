import 'package:econnect/utils/password_encryption.dart';
import 'package:econnect/model/database.dart';
import 'package:econnect/model/post.dart';
import 'package:econnect/model/user.dart';

class DatabaseController {
  const DatabaseController({required this.db});

  final Database db;

  Future<Post> createPost(
      String user, String title, String imgPath, String description) async {
    final image = await db.storeImage(imgPath);
    final post = Post(
        user: user,
        title: title,
        image: await db.retrieveFileUrl(image),
        description: description);
    db.addPost(post);
    return post;
  }

  Future<List<Post>> getPosts() async => db.getPosts();

  Future<User?> createUser(
      String email, String username, String password) async {
    final user = User(
      email: email,
      username: username,
      password: encryptPassword(password),
      score: 0,
      isBlocked: false,
      registerDatetime: DateTime.now(),
      admin: false,
    );
    return await db.addUser(user) ? user : null;
  }

  Future<User?> getUser(String email) async => await db.getUser(email);

  Future<User?> getUserWithPassword(String email, String password) async =>
      await db.getUserWithPassword(email, encryptPassword(password));
}
