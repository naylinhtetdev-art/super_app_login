import 'package:flutter/material.dart';
import 'package:super_app/model/service_model.dart';

class ServiceProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _notificationCount = 3;
  int get notificationCount => _notificationCount;

  List<CategoryModel> miniApps = [
    CategoryModel(
      id: '1',
      title: 'Food',
      iconPath: 'assets/icons/icons-food.png',
    ),
    CategoryModel(
      id: '2',
      title: 'Mart',
      iconPath: 'assets/icons/icons-mart.png',
    ),
    CategoryModel(
      id: '3',
      title: 'Ride',
      iconPath: 'assets/icons/icons-ride.png',
    ),
    CategoryModel(
      id: '4',
      title: 'Food',
      iconPath: 'assets/icons/icons-food.png',
    ),
    CategoryModel(
      id: '5',
      title: 'Mart',
      iconPath: 'assets/icons/icons-mart.png',
    ),
    CategoryModel(
      id: '6',
      title: 'Ride',
      iconPath: 'assets/icons/icons-ride.png',
    ),
  ];

  List<CategoryModel> payBills = [
    CategoryModel(id: '1', title: 'Electricity', iconPath: ''),
    CategoryModel(id: '2', title: 'Water', iconPath: ''),
    CategoryModel(id: '3', title: 'Internet', iconPath: ''),
    CategoryModel(id: '4', title: 'Top-up', iconPath: ''),
  ];
  List<CategoryModel> localServices = [
    CategoryModel(id: '1', title: 'Cleaning', iconPath: ''),
    CategoryModel(id: '2', title: 'Handyman', iconPath: ''),
    CategoryModel(id: '3', title: 'Laundry', iconPath: ''),
  ];
  List<ProductModel> products = [
    ProductModel(
      id: 'p1',
      title: 'Shwebo Pawsan Rice (5kg)',
      imageUrl: 'assets/shops/shop-image-1.png',
      price: 18500,
    ),
    ProductModel(
      id: 'p2',
      title: 'Fresh Water Spinach',
      imageUrl: 'assets/shops/shop-image-2.png',
      price: 1200,
      tag: 'TRENDING',
    ),
  ];

  int _selectedCategoryIndex = 0;
  int get selectedCategoryIndex => _selectedCategoryIndex;

  // Categories List
  final List<Map<String, dynamic>> shopCategories = [
    {'id': '1', 'title': 'Fresh Produce', 'icon': Icons.eco_outlined},
    {
      'id': '2',
      'title': 'Daily Essentials',
      'icon': Icons.shopping_basket_outlined,
    },
    {'id': '3', 'title': 'Local Specialty', 'icon': Icons.storefront_outlined},
  ];

  void selectCategory(int index) {
    _selectedCategoryIndex = index;

    notifyListeners();
  }

  // API Call Function (Future Integration)
  Future<void> fetchHomeData() async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: Call API Here (e.g. await http.get(...))
      // Mock delay
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      // Handle Error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addToCart(String productId) {
    // Cart Logic
    notifyListeners();
  }
}
