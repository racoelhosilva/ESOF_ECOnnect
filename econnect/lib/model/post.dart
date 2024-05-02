class Post {
  Post(
      {required this.user,
      required this.image,
      required this.description,
      required this.postDatetime,
      this.likes = 0});

  final String postId;
  final String user;
  final String image;
  final String description;
  final DateTime postDatetime;
  int likes;
}
