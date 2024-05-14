class Comment {
  Comment({
    required this.commentId,
    required this.userId,
    required this.username,
    required this.profilePicture,
    required this.postId,
    required this.comment,
    required this.commentDatetime,
  });

  final String commentId;
  final String userId;
  final String username;
  final String profilePicture;
  final String postId;
  final String comment;
  final DateTime commentDatetime;
}
