import 'dart:convert';
import 'dart:io';
import 'expanse.dart';

class ExpenseManager {
  final List<Expense> _expenses = [];

  bool get isEmpty => _expenses.isEmpty;
  int get count => _expenses.length;
  double get totalSpending =>
      _expenses.fold(0, (sum, e) => sum + e.amount);
  double get totalUnpaid =>
      _expenses.where((e) => !e.isPaid).fold(0, (sum, e) => sum + e.amount);

  List<Expense> get allExpenses => List.unmodifiable(_expenses);
  List<Expense> get unpaid => _expenses.where((e) => !e.isPaid).toList();

  List<Expense> get sortedByDateDesc =>
      List.from(_expenses)..sort((a, b) => b.date.compareTo(a.date));

  List<Expense> get sortedByAmountDesc =>
      List.from(_expenses)..sort((a, b) => b.amount.compareTo(a.amount));

  Set<String> get allCategories =>
      _expenses.map((e) => e.category).toSet();

  void addExpense(Expense expense) => _expenses.add(expense);

  void deleteExpense(int id) => _expenses.removeWhere((e) => e.id == id);

  Expense? getExpenseById(int id) =>
      _expenses.firstWhere((e) => e.id == id, orElse: () => throw StateError('Expense not found'));

  List<Expense> getByCategory(String category) =>
      _expenses.where((e) => e.category == category).toList();

  List<Expense> search(String query) => _expenses
      .where((e) =>
          e.description.toLowerCase().contains(query.toLowerCase()) ||
          e.category.toLowerCase().contains(query.toLowerCase()))
      .toList();

  void updateExpense(
    int id, {
    String? description,
    double? amount,
    String? category,
    String? notes,
  }) {
    final expense = getExpenseById(id);
    if (expense != null) {
      if (description != null) expense.description = description;
      if (amount != null) expense.amount = amount;
      if (category != null) expense.category = category;
      if (notes != null) expense.notes = notes;
    }
  }

  void markAsPaid(int id, String method) {
    final expense = getExpenseById(id);
    if (expense != null) {
      expense.isPaid = true;
      expense.paymentMethod = method;
    }
  }

  // 🧾 Laporan
  void printSummary() {
    print('📘 Ringkasan Pengeluaran');
    print('Total Pengeluaran: \$${totalSpending.toStringAsFixed(2)}');
    print('Belum Dibayar: \$${totalUnpaid.toStringAsFixed(2)}');
  }

  void printCategoryReport() {
    print('\n📂 Rincian per Kategori:');
    for (final category in allCategories) {
      final total = getByCategory(category)
          .fold(0.0, (sum, e) => sum + e.amount);
      print('- $category: \$${total.toStringAsFixed(2)}');
    }
  }

  void printMonthlyReport() {
    print('\n🗓️ Laporan Bulanan:');
    final grouped = <String, double>{};
    for (final e in _expenses) {
      final key = '${e.date.year}-${e.date.month.toString().padLeft(2, '0')}';
      grouped[key] = (grouped[key] ?? 0) + e.amount;
    }
    grouped.forEach((k, v) => print('$k: \$${v.toStringAsFixed(2)}'));
  }

  // 💾 Simpan dan muat dari file
  Future<void> saveToFile() async {
    final file = File('expenses.json');
    final data = _expenses.map((e) => e.toJson()).toList();
    await file.writeAsString(jsonEncode(data));
  }

  Future<void> loadFromFile() async {
    final file = File('expenses.json');
    if (!await file.exists()) return;

    final content = await file.readAsString();
    final List list = jsonDecode(content);
    _expenses.clear();
    _expenses.addAll(list.map((e) => Expense.fromJson(e)));
  }
}