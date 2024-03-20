import 'package:econnect/model/database.dart';
import 'package:econnect/model/post.dart';
import 'package:logger/logger.dart';

class DatabaseController {
  const DatabaseController({required this.db});

  final Database db;

  Future<Post> createPost(String user, String title, String imgPath,
    String description) async {
    final image = await db.storeImage(imgPath);
    Logger().i(image);
    final post = Post(
      user: user,
      title: title,
      image: await db.retrieveFileUrl(image),
      description: description
    );
    db.addPost(post);
    return post;
  }
}