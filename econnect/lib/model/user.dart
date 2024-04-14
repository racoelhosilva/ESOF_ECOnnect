class User {
  const User(
      {required this.username,
      required this.email,
      required this.password,
      required this.description,
      required this.profilePicture,
      required this.score,
      required this.isBlocked,
      required this.registerDatetime,
      required this.admin});

  final String username;
  final String email;
  final String password;
  final String description;
  final String profilePicture;
  final int score;
  final bool isBlocked;
  final DateTime registerDatetime;
  final bool admin;
}
