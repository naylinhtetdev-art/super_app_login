class StoryModel {
  final String id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  StoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isOnline = false,
  });
}

class ChatTileModel {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final String? avatarUrl;
  final String initials;
  final int unreadCount;
  final bool isVerified;
  final bool isOnline;
  final bool isShop;

  ChatTileModel({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.avatarUrl,
    required this.initials,
    this.unreadCount = 0,
    this.isVerified = false,
    this.isOnline = false,
    this.isShop = false,
  });
}

// Inquiry Data Model
class InquiryModel {
  final String id;
  final String itemTitle;
  final String buyerName;
  final String itemImageUrl;
  final String inquiryText;
  final bool isNew;

  InquiryModel({
    required this.id,
    required this.itemTitle,
    required this.buyerName,
    required this.itemImageUrl,
    required this.inquiryText,
    this.isNew = false,
  });
}
