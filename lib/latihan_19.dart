import 'dart:io';

class BudgetCategory {
  String name;
  double limit;
  double spent = 0;

  BudgetCategory(this.name, this.limit);

  void addExpense(double amount) {
    spent += amount;
  }

  double get remaining => limit - spent;

  void showStatus() {
    print('--- ${name.toUpperCase()} ---');
    print('Limit: Rp${limit.toStringAsFixed(2)}');
    print('Dihabiskan: Rp${spent.toStringAsFixed(2)}');
    print('Sisa: Rp${remaining.toStringAsFixed(2)}');

    if (spent > limit) {
      print('⚠️  PERINGATAN: Pengeluaran melebihi limit!');
    } else if (spent > limit * 0.8) {
      print('⚠️  Hati-hati, hampir mencapai batas!');
    }
    print('');
  }
}

class BudgetManager {
  final List<BudgetCategory> _categories = [];

  void addCategory(String name, double limit) {
    _categories.add(BudgetCategory(name, limit));
  }

  void addExpense(String categoryName, double amount) {
    for (var c in _categories) {
      if (c.name.toLowerCase() == categoryName.toLowerCase()) {
        c.addExpense(amount);
        print('✅ Pengeluaran Rp${amount.toStringAsFixed(2)} ditambahkan ke ${c.name}.');
        return;
      }
    }
    print('❌ Kategori "$categoryName" tidak ditemukan.');
  }

  void showReport() {
    print('\n=== LAPORAN BUDGET BULANAN ===');
    for (var c in _categories) {
      c.showStatus();
    }
  }
}

void main() {
  final manager = BudgetManager();

  // Contoh kategori budget
  manager.addCategory('Makanan', 2000000);
  manager.addCategory('Transportasi', 1000000);
  manager.addCategory('Hiburan', 500000);

  // Contoh pengeluaran
  manager.addExpense('Makanan', 1500000);
  manager.addExpense('Transportasi', 850000);
  manager.addExpense('Hiburan', 550000);

  // Tampilkan laporan
  manager.showReport();
}