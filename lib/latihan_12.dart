class Expense {
  String description;
  double amount;
  String category;
  DateTime date;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
  });

  void printDetails() {
    print('Deskripsi: $description');
    print('   Jumlah: \$${amount.toStringAsFixed(2)}');
    print('   Kategori: $category');
    print('   Tanggal: ${date.toLocal()}');
  }
}

class BusinessExpense extends Expense {
  String client;
  bool isReimbursable;

  BusinessExpense({
    required super.description,
    required super.amount,
    required super.category,
    required this.client,
    this.isReimbursable = true,
  }) : super(
    date: DateTime.now(),
  );

  @override
  void printDetails() {
    print('💼 PENGELUARAN BISNIS');
    super.printDetails();
    print('   Klien: $client');
    print('   Bisa di-reimburse: ${isReimbursable ? "Ya ✅" : "Tidak ❌"}');
  }
}

void main() {
  var expense = BusinessExpense(
    description: 'Makan siang klien',
    amount: 85.0,
    category: 'Makan',
    client: 'PT Acme',
    isReimbursable: true,
  );

  expense.printDetails();
}