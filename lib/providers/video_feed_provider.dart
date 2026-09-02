// State Management Provider
import 'package:flutter/material.dart';
import 'package:super_app/model/video_model.dart';

class VideoFeedProvider extends ChangeNotifier {
  int _selectedTabIndex = 2; // Default: 'For you'
  int get selectedTabIndex => _selectedTabIndex;

  final List<VideoModel> _videos = [
    VideoModel(
      id: '1',
      videoUrl: 'assets/videos/videos-image-1.png', // Dummy Image
      username: '@tomaslind',
      profileInitials: 'TL',
      caption: 'Empty streets, full send. Sunday mornings are undefeated.',
      audioTitle: 'Khruangbin — Evan Finds the Third Room',
      likes: 18000,
      comments: 312,
      shares: 96,
    ),
    VideoModel(
      id: '2',
      videoUrl: 'assets/videos/videos-image-2.png', // Dummy Image
      username: '@sofiao',
      profileInitials: 'SO',
      caption: 'Four ingredients, twelve hours, one very good loaf.',
      audioTitle: 'Original audio — sofiao',
      likes: 18000,
      comments: 187,
      shares: 240,
    ),
    VideoModel(
      id: '3',
      videoUrl: 'assets/videos/videos-image-1.png', // Dummy Image
      username: '@tomaslind',
      profileInitials: 'TL',
      caption: 'Empty streets, full send. Sunday mornings are undefeated.',
      audioTitle: 'Khruangbin — Evan Finds the Third Room',
      likes: 18000,
      comments: 312,
      shares: 96,
    ),
    VideoModel(
      id: '4',
      videoUrl: 'assets/videos/videos-image-2.png', // Dummy Image
      username: '@sofiao',
      profileInitials: 'SO',
      caption: 'Four ingredients, twelve hours, one very good loaf.',
      audioTitle: 'Original audio — sofiao',
      likes: 18000,
      comments: 187,
      shares: 240,
    ),
  ];

  List<VideoModel> get videos => _videos;

  void setTab(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  void toggleLike(int index) {
    _videos[index].isLiked = !_videos[index].isLiked;
    if (_videos[index].isLiked) {
      _videos[index].likes++;
    } else {
      _videos[index].likes--;
    }
    notifyListeners();
  }

  void toggleFollow(int index) {
    _videos[index].isFollowing = !_videos[index].isFollowing;
    notifyListeners();
  }
}
