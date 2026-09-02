class UserModel {
  final String id;
  final String name;
  final String username;
  final String avatarUrl;
  final String coverUrl;
  final String bio;
  final int followers;
  final int following;
  final int postsCount;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.coverUrl,
    required this.bio,
    required this.followers,
    required this.following,
    required this.postsCount,
  });
}

class UserPostModel {
  final String id;
  final String userName;
  final String userAvatar;
  final String timeAgo;
  final String content;
  final String hashtags;
  final String? imageUrl;

  UserPostModel({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.timeAgo,
    required this.content,
    required this.hashtags,
    this.imageUrl,
  });
}
