import 'package:intl/intl.dart';

class Expense {
  static int _nextId = 1;

  int id;
  String description;
  double amount;
  String category;
  String? notes;
  DateTime date;
  bool isPaid;
  String? paymentMethod;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
    this.notes,
    DateTime? date,
    this.isPaid = false,
    this.paymentMethod,
  })  : id = _nextId++,
        date = date ?? DateTime.now();

  factory Expense.create({
    required String description,
    required double amount,
    required String category,
    String? notes,
  }) {
    return Expense(
      description: description,
      amount: amount,
      category: category,
      notes: notes,
    );
  }

  String get summary =>
      '#$id | ${DateFormat('dd/MM/yyyy').format(date)} | $category | '
      '\$${amount.toStringAsFixed(2)} | ${isPaid ? "✅ Lunas" : "❌ Belum"} | $description';

  void printDetails() {
    print('ID: $id');
    print('Deskripsi: $description');
    print('Jumlah: \$${amount.toStringAsFixed(2)}');
    print('Kategori: $category');
    print('Tanggal: ${DateFormat('dd/MM/yyyy').format(date)}');
    print('Status: ${isPaid ? "Sudah Dibayar" : "Belum Dibayar"}');
    if (paymentMethod != null) print('Metode: $paymentMethod');
    if (notes != null) print('Catatan: $notes');
  }

  // 🧮 Tambahan fitur analisis
  int getQuarter() => ((date.month - 1) / 3).floor() + 1;

  bool isWeekend() =>
      date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'amount': amount,
        'category': category,
        'notes': notes,
        'date': date.toIso8601String(),
        'isPaid': isPaid,
        'paymentMethod': paymentMethod,
      };

  static Expense fromJson(Map<String, dynamic> json) {
    final expense = Expense(
      description: json['description'],
      amount: json['amount'],
      category: json['category'],
      notes: json['notes'],
      date: DateTime.parse(json['date']),
      isPaid: json['isPaid'] ?? false,
      paymentMethod: json['paymentMethod'],
    );
    expense.id = json['id'];
    _nextId = expense.id + 1;
    return expense;
  }
}