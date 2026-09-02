import 'package:flutter/material.dart';
import 'package:super_app/model/user_model.dart';

class ProfileProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  final UserModel? _user = UserModel(
    id: '1',
    name: 'Min Thant',
    username: '@minthant_99',
    avatarUrl: 'assets/images/user-ellipse-1.png',
    coverUrl: 'assets/images/opst-img-1.png',
    bio: 'Introduce your bio',
    followers: 12400,
    following: 842,
    postsCount: 19,
  );
  UserModel? get user => _user;

  // Mock Posts Data
  final List<UserPostModel> _posts = [
    UserPostModel(
      id: 'p1',
      userName: 'Min Thant',
      userAvatar: 'assets/images/user-ellipse-1.png',
      timeAgo: '2m ago',
      content:
          'သဘာဝတရားဖြင့် ရှင်သန်ခြင်းဆိုသည်မှာ သဘာဝနှင့် တသားတည်းနေထိုင်ကာ ကိုယ်စိတ်ကျန်းမာရေးကို တည်ဆောက်ခြင်း၊ သဘာဝပတ်ဝန်းကျင်ကို ထိန်းသိမ်းခြင်းနှင့် ရိုးရှင်းသောလူနေမှုဘဝကို ကျင့်သုံးခြင်းတို့ ဖြစ်သည်။ ၎င်းသည် လူသားတို့၏ စိတ်ဖိစီးမှုကို လျှော့ကျစေပြီး ရေရှည်တည်တံ့သော ဘဝရပ်တည်မှုကို ဖြစ်ပေါ်စေသည်။',
      hashtags: '#Nature #Lifewithyou #Beautifulwithnaturalflower',
      imageUrl: 'assets/images/opst-img-1.png',
    ),
  ];
  List<UserPostModel> get posts => _posts;

  void setTab(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  // Future API Integration Logic
  Future<void> fetchProfileData() async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: Call API Here (e.g. await http.get(...))
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      // Handle Exception
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
