class PostModel {
  final String id;
  final String userName;
  final String avatar;
  final String text;
  final String hashtags;
  final List<String> images;
  final int likes;
  final int comments;
  final int share;
  final int views;
  final String timeAgo;
  final bool isLiked;

  const PostModel({
    required this.id,
    required this.userName,
    required this.avatar,
    required this.text,
    required this.hashtags,
    this.images = const [],
    this.likes = 0,
    this.comments = 0,
    this.share = 0,
    this.views = 0,
    this.timeAgo = 'Just now',
    this.isLiked = false,
  });

  PostModel copyWith({
    String? id,
    String? userName,
    String? avatar,
    String? text,
    String? hashtags,
    List<String>? images,
    int? likes,
    int? comments,
    int? share,
    int? views,
    String? timeAgo,
    bool? isLiked,
  }) {
    return PostModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      avatar: avatar ?? this.avatar,
      text: text ?? this.text,
      hashtags: hashtags ?? this.hashtags,
      images: images ?? this.images,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      share: share ?? this.share,
      views: views ?? this.views,
      timeAgo: timeAgo ?? this.timeAgo,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
