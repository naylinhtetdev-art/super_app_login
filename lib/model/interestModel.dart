class InterestModel {
  final String title;
  final String imagePath; // PNG Image Path ထည့်ရန်
  bool isSelected;

  InterestModel({
    required this.title,
    required this.imagePath,
    this.isSelected = false,
  });
}
