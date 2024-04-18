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
        image: await db.retrieveFileUrl(image),
        description: description,
        postDatetime: DateTime.now());
    db.addPost(post);
    return post;
  }

  Future<List<Post>> getPosts() async => db.getPosts();

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
