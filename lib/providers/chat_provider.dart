import 'package:flutter/material.dart';
import 'package:super_app/model/chat_model.dart';

class ChatProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  // Mock Stories Data
  List<ChatModel> stories = [
    ChatModel(
      id: '1',
      name: 'Kyaw Myint',
      imageUrl: 'assets/images/user-ellipse-1.png',
      isOnline: true,
      avatarUrl: '',
      isAddStory: false,
    ),
    ChatModel(
      id: '2',
      name: 'Daw Mya',
      imageUrl: 'assets/images/user-ellipse-2.png',
      isOnline: true,
      avatarUrl: '',
      isAddStory: false,
    ),
    ChatModel(
      id: '3',
      name: 'Thandar',
      imageUrl: 'assets/images/user-ellipse-1.png',
      isOnline: true,
      avatarUrl: '',
      isAddStory: false,
    ),
    ChatModel(
      id: '4',
      name: 'Zin',
      imageUrl: 'assets/images/user-ellipse-2.png',
      isOnline: false,
      avatarUrl: '',
      isAddStory: false,
    ),
  ];

  // Mock Chats Data
  List<ChatTileModel> chats = [
    ChatTileModel(
      id: 'c1',
      name: 'Priya Nair',
      lastMessage: 'Saturday morning work for you?',
      time: '2m',
      initials: 'PN',
      unreadCount: 2,
      isVerified: true,
      isOnline: true,
    ),
    ChatTileModel(
      id: 'c2',
      name: 'Jonah Reyes',
      lastMessage: "I'll bring the spare board.",
      time: '18m',
      initials: 'JR',
      isOnline: true,
    ),
    ChatTileModel(
      id: 'c3',
      name: 'Mei Watanabe',
      lastMessage: 'Sent over the sketches for the cover — let ...',
      time: '3h',
      initials: 'MW',
      unreadCount: 1,
    ),
    ChatTileModel(
      id: 'c4',
      name: 'Sofia Okafor',
      lastMessage: 'Recipe is in my Quick, I promise it works!',
      time: '1d',
      initials: 'SO',
    ),
    ChatTileModel(
      id: 'c5',
      name: 'Ma Su Mon',
      lastMessage: 'Are we still meeting for lunch near Sule?',
      time: 'Yesterday',
      avatarUrl: 'assets/images/user-ellipse-1.png',
      initials: 'MS',
      isOnline: true,
    ),
    ChatTileModel(
      id: 'c6',
      name: 'Ko Phyo Electronics',
      lastMessage: 'Your order has been confirmed. Thank you!',
      time: 'Yesterday',
      avatarUrl: 'assets/images/user-ellipse-2.png',
      initials: 'KP',
      isShop: true,
    ),
  ];

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // API Integration အတွက် Method
  Future<void> fetchChats() async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: Call API Here (e.g., await http.get(...))
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      // Handle Error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<InquiryModel> inquiries = [
    InquiryModel(
      id: '1',
      itemTitle: 'Traditional Silk Dress',
      buyerName: 'Aung Aung',
      itemImageUrl: 'assets/images/opst-img-1.png',
      inquiryText: '"Is this available in size M? Can you ship to Mandalay?"',
      isNew: true,
    ),
    InquiryModel(
      id: '2',
      itemTitle: 'Used Laptop',
      buyerName: 'Kyaw Kyaw',
      itemImageUrl: 'assets/images/opst-img-1.png',
      inquiryText: '"Yes, it comes with warranty. Can we meet tomorrow?"',
      isNew: false,
    ),
  ];
}
