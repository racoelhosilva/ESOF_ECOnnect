class User {
  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.score,
    required this.isBlocked,
    required this.registerDatetime,
    required this.admin,
    required this.profilePicture,
    this.description,
  });

  final String id;
  final String username;
  final String email;
  final int score;
  final bool isBlocked;
  final DateTime registerDatetime;
  final bool admin;
  final String? description;
  final String profilePicture;
}
