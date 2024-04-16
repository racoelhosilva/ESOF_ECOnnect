class Post {
  Post(
      {required this.user,
      required this.image,
      required this.description,
      required this.postDateTime});

  final String user;
  final String image;
  final String description;
  final DateTime postDateTime;
}
