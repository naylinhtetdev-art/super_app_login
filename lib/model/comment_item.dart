class CommentItem {
  final String userName;
  final String avatar;
  final String text;
  final String timeAgo;
  final String? badge;
  int likes;
  bool isLiked;
  final int replyCount;

  CommentItem({
    required this.userName,
    required this.avatar,
    required this.text,
    required this.timeAgo,
    this.badge,
    required this.likes,
    this.isLiked = false,
    this.replyCount = 0,
  });
}
