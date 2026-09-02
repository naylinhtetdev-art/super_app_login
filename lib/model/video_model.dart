// Video Data Model
class VideoModel {
  final String id;
  final String videoUrl;
  final String username;
  final String profileInitials;
  final String caption;
  final String audioTitle;
  int likes;
  int comments;
  int shares;
  bool isLiked;
  bool isFollowing;

  VideoModel({
    required this.id,
    required this.videoUrl,
    required this.username,
    required this.profileInitials,
    required this.caption,
    required this.audioTitle,
    required this.likes,
    required this.comments,
    required this.shares,
    this.isLiked = false,
    this.isFollowing = false,
  });
}
