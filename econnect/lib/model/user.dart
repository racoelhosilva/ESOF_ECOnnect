class User {
  const User(
      {required this.username,
      required this.email,
      required this.score,
      required this.isBlocked,
      required this.registerDatetime,
      required this.admin,
      this.password,
      this.description,
      this.profilePicture});

  final String username;
  final String email;
  final String? password;
  final int score;
  final bool isBlocked;
  final DateTime registerDatetime;
  final bool admin;
  final String? description;
  final String? profilePicture;
}
