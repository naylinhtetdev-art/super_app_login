import 'package:flutter/material.dart';
import 'package:super_app/model/search_filter_model.dart';

class SearchProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  // Filter List
  final List<SearchFilterModel> _filters = [
    SearchFilterModel(icon: Icons.person_outline, label: 'People'),
    SearchFilterModel(icon: Icons.calendar_today_outlined, label: 'Shops'),
    SearchFilterModel(icon: Icons.storefront_outlined, label: 'Shops'),
    SearchFilterModel(icon: Icons.build_outlined, label: 'Service'),
  ];
  List<SearchFilterModel> get filters => _filters;

  // Recent Searches
  List<String> _recentSearches = [
    'Best Mohinga in Yangon',
    'Thingyan 2026 events',
    'OLLIO Pay',
  ];
  List<String> get recentSearches => _recentSearches;

  // Trending List (Using TrendingModel)
  List<TrendingModel> _trendingList = [
    TrendingModel(rank: '1', tag: '#MyanmarCreators', posts: '12.5K posts'),
    TrendingModel(rank: '2', tag: '#LocalFoodie', posts: '8.2K posts'),
    TrendingModel(rank: '3', tag: '#YangonJobs', posts: '5.1K posts'),
    TrendingModel(
      rank: '4',
      tag: '#OLLIOCommunity',
      posts: 'Official Announcement',
    ),
  ];
  List<TrendingModel> get trendingList => _trendingList;

  // Recommended Users List (Using RecommendedUserModel)
  List<RecommendedUserModel> _recommendedUsers = [
    RecommendedUserModel(
      id: '1',
      name: 'Yona',
      avatarUrl: 'assets/images/user-ellipse-1.png',
    ),
    RecommendedUserModel(
      id: '2',
      name: 'Michel Jin',
      avatarUrl: 'assets/images/user-ellipse-2.png',
    ),
    RecommendedUserModel(
      id: '3',
      name: 'Yona',
      avatarUrl: 'assets/images/user-ellipse-1.png',
    ),
  ];
  List<RecommendedUserModel> get recommendedUsers => _recommendedUsers;

  List<SuggestedUserModel> _suggestedUsers = [
    SuggestedUserModel(
      id: '1',
      name: 'Yona',
      avatarUrl: 'assets/images/user-ellipse-1.png',
      members: '1.2K members',
    ),
    SuggestedUserModel(
      id: '2',
      name: 'Michel Jin',
      avatarUrl: 'assets/images/user-ellipse-2.png',
      members: '800 members',
    ),
    SuggestedUserModel(
      id: '3',
      name: 'Yona',
      avatarUrl: 'assets/images/user-ellipse-1.png',
      members: '1.2K members',
    ),
  ];
  List<SuggestedUserModel> get suggestedUsers => _suggestedUsers;

  void onSearchChanged(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> fetchInitialSearchData() async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: API Call Here
      await Future.delayed(const Duration(milliseconds: 800));
    } catch (e) {
      debugPrint("Error fetching data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void removeRecentSearch(String item) {
    _recentSearches.remove(item);
    notifyListeners();
  }

  void clearAllRecentSearches() {
    _recentSearches.clear();
    notifyListeners();
  }
}
