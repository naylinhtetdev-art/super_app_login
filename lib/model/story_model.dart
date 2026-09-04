class StoryModel {
  final String id;
  final String name;
  final String profileUrl;
  final List<StoryItemModel> stories;
  final bool isAddStory;
  final bool hasUnseenStory;

  StoryModel({
    required this.id,
    required this.name,
    required this.stories,
    required this.profileUrl,
    this.isAddStory = false,
    this.hasUnseenStory = true,
  });

  // API response (JSON) မှ Data ပြောင်းရန် factory method
  // factory StoryModel.fromJson(Map<String, dynamic> json) {
  //   return StoryModel(
  //     id: json['id']?.toString() ?? '',
  //     name: json['name'] ?? '',
  //     stories: (json['stories'] as List?)
  //         ?.map((e) => StoryItemModel.fromJson(e))
  //         .toList() ??
  //         [],
  //     profileUrl: json['profile_url'] ?? json['profile'] ?? '',
  //     isAddStory: false,
  //     hasUnseenStory: json['has_unseen_story'] ?? false,
  //   );
  // }
}

class StoryItemModel {
  final String imageUrl;
  final String timeAgo;

  StoryItemModel({required this.imageUrl, required this.timeAgo});
}
