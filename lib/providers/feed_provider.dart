import 'package:flutter/material.dart';
import 'package:super_app/model/post_model.dart';

class FeedProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final List<PostModel> _posts = [
    PostModel(
      id: '1',
      userName: 'Mayar Chen',
      avatar: 'assets/images/user-ellipse-1.png',
      text:
          'သဘာဝတရားဖြင့် ရှင်သန်ခြင်းဆိုသည်မှာ သဘာဝနှင့် တသားတည်းနေထိုင်ကာ ကိုယ်စိတ်ကျန်းမာရေးကို တည်ဆောက်ခြင်း၊ သဘာဝပတ်ဝန်းကျင်ကို ထိန်းသိမ်းခြင်းနှင့် ရိုးရှင်းသောလူနေမှုဘဝကို ကျင့်သုံးခြင်းတို့ ဖြစ်သည်။ ၎င်းသည် လူသားတို့၏ စိတ်ဖိစီးမှုကို လျော့ကျစေပြီး ရေရှည်တည်တံ့သော ဘဝရပ်တည်မှုကို ဖြစ်ပေါ်စေသည်။',
      hashtags: '#Nature #Lifewithyou #Beautifulwithnaturalflower',
      images: ['assets/images/opst-img-1.png'],
      likes: 128,
      comments: 24,
      share: 12,
      views: 1000,
      timeAgo: '2h',
    ),

    PostModel(
      id: '2',
      userName: 'Yangon Guide',
      avatar: 'assets/images/user-ellipse-2.png',
      text:
          'သဘာဝတရားဖြင့် ရှင်သန်ခြင်းဆိုသည်မှာ သဘာဝနှင့် တသားတည်းနေထိုင်ကာ ကိုယ်စိတ်ကျန်းမာရေးကို တည်ဆောက်ခြင်း၊ သဘာဝပတ်ဝန်းကျင်ကို ထိန်းသိမ်းခြင်းနှင့် ရိုးရှင်းသောလူနေမှုဘဝကို ကျင့်သုံးခြင်းတို့ ဖြစ်သည်။ ၎င်းသည် လူသားတို့၏ စိတ်ဖိစီးမှုကို လျော့ကျစေပြီး ရေရှည်တည်တံ့သော ဘဝရပ်တည်မှုကို ဖြစ်ပေါ်စေသည်။',
      hashtags: '#Nature #Lifewithyou #Beautifulwithnaturalflower',
      images: ['assets/images/opst-img-1.png', 'assets/images/opst-img-1.png'],
      likes: 95,
      comments: 18,
      share: 120,
      views: 1500,
      timeAgo: '3h',
    ),

    PostModel(
      id: '3',
      userName: 'Travel Club',
      avatar: 'assets/images/user-ellipse-2.png',
      text: 'Weekend မှာ သွားလည်ဖို့ အကောင်းဆုံးနေရာလေးတွေပါ။',
      hashtags: '#Nature #Lifewithyou #Beautifulwithnaturalflower',
      images: [
        'assets/images/opst-img-1.png',
        'assets/images/opst-img-1.png',
        'assets/images/opst-img-1.png',
      ],
      likes: 245,
      comments: 36,
      share: 56,
      views: 10,
      timeAgo: '5h',
    ),

    PostModel(
      id: '4',
      userName: 'Nature Lovers',
      avatar: 'assets/images/user-ellipse-1.png',
      text: 'Nature lovers တွေအတွက် ဒီနေရာလေးကို recommend လုပ်ချင်ပါတယ်။',
      hashtags: '#Nature #Lifewithyou #Beautifulwithnaturalflower',
      images: [
        'assets/images/opst-img-1.png',
        'assets/images/opst-img-1.png',
        'assets/images/opst-img-1.png',
        'assets/images/opst-img-1.png',
      ],
      likes: 87,
      comments: 12,
      share: 101,
      views: 500,
      timeAgo: '8h',
    ),
  ];

  List<PostModel> get posts => List.unmodifiable(_posts);

  // -------------------------
  // Like Post
  // -------------------------

  void toggleLike(String postId) {
    final index = _posts.indexWhere((post) => post.id == postId);

    if (index == -1) return;

    final post = _posts[index];

    final updatedPost = post.copyWith(
      likes: post.isLiked ? post.likes - 1 : post.likes + 1,
      isLiked: !post.isLiked,
    );

    _posts[index] = updatedPost;

    notifyListeners();
  }

  // -------------------------
  // Add Post
  // -------------------------

  void addPost(PostModel post) {
    _posts.insert(0, post);

    notifyListeners();
  }

  void editPost(String postId) {
    //_posts.editWhere((post) => post.id == postId);

    notifyListeners();
  }

  // -------------------------
  // Refresh
  // -------------------------

  Future<void> refreshFeed() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();
  }
}
