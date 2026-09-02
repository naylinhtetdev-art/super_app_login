class CategoryModel {
  final String id;
  final String title;
  final String iconPath;

  CategoryModel({
    required this.id,
    required this.title,
    required this.iconPath,
  });
}

class ProductModel {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final String tag;

  ProductModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.tag = '',
  });
}
