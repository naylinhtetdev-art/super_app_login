import 'package:flutter/material.dart';
import 'package:super_app/model/story_model.dart';

class StoryProvider extends ChangeNotifier {
  List<StoryModel> _stories = [];
  bool _isLoading = false;

  List<StoryModel> get stories => _stories;
  bool get isLoading => _isLoading;

  StoryProvider() {
    fetchStories();
  }

  Future<void> fetchStories() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock API delay

      List<StoryModel> apiStories = [
        StoryModel(
          id: '1',
          name: 'My Story',
          profileUrl: 'assets/images/user-ellipse-1.png',
          //storyUrlList: 'assets/storys/story-1.png',
          stories: [
            StoryItemModel(
              imageUrl: "assets/storys/story-1.png",
              timeAgo: "1m ago",
            ),
            StoryItemModel(
              imageUrl: "assets/storys/story-1.png",
              timeAgo: "5m ago",
            ),
          ],
        ),
        StoryModel(
          id: '2',
          name: 'Mya',
          profileUrl: 'assets/images/user-ellipse-2.png',
          stories: [
            StoryItemModel(
              imageUrl: "assets/storys/story-2.png",
              timeAgo: "10m ago",
            ),
          ],
        ),
        StoryModel(
          id: '3',
          name: 'Su Su',
          profileUrl: 'assets/images/user-ellipse-1.png',
          stories: [
            StoryItemModel(
              imageUrl: "assets/storys/story-3.png",
              timeAgo: "15m ago",
            ),
            StoryItemModel(
              imageUrl: "assets/storys/story-1.png",
              timeAgo: "15m ago",
            ),
            StoryItemModel(
              imageUrl: "assets/storys/story-3.png",
              timeAgo: "15m ago",
            ),
          ],
        ),
        StoryModel(
          id: '4',
          name: 'Htet',
          profileUrl: 'assets/images/user-ellipse-2.png',
          stories: [
            StoryItemModel(
              imageUrl: "assets/storys/story-1.png",
              timeAgo: "20m ago",
            ),
          ],
        ),
        StoryModel(
          id: '5',
          name: 'Aung',
          profileUrl: 'assets/storys/story-1.png',
          stories: [
            StoryItemModel(
              imageUrl: "assets/storys/story-2.png",
              timeAgo: "25m ago",
            ),
          ],
        ),
      ];

      // "Add Story" Button
      _stories = [
        StoryModel(
          id: '0',
          name: 'Add Story',
          profileUrl: 'assets/images/story-plus-filled.png',
          stories: [],
          isAddStory: true,
        ),
        ...apiStories,
      ];
    } catch (e) {
      debugPrint('Error fetching stories: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
