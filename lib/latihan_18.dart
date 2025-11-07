class CategoryManager {
  final List<String> _categories = ['Makanan', 'Transportasi', 'Tagihan'];

  void addCategory(String category) {
    _categories.add(category);
  }
  void removeCategory(String category) {
    _categories.remove(category);
  }
  List<String> get allCategories => List.unmodifiable(_categories);
}