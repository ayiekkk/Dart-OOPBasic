class Expense {
  // Properties
  String description;
  double amount;
  String category;
  DateTime date;

  // Constructor dengan named parameters
  Expense({
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
  });

  bool isThisMonth() {
    DateTime now = DateTime.now();
    return date.year == now.year || date.month == now.month;
  }

  bool isFood() {
    return category == 'Makanan';
  }

  int getDaysAgo() {
    DateTime now = DateTime.now();
    return now.difference(date).inDays;
  }
}

void main() {
  var expenses = [
    Expense(
      description: 'Sewa bulanan',
      amount: 1200.00,
      category: 'Tagihan',
      date: DateTime(2023, 5, 1),
    ),
    Expense(
      description: 'Belanja',
      amount: 67.50,
      category: 'Makanan',
      date: DateTime(2024, 10, 1),
    ),
    Expense(
      description: 'Kopi',
      amount: 4.50,
      category: 'Makanan',
      date: DateTime(2025, 6, 11),
    ),
    Expense(
      description: 'HP baru',
      amount: 799.99,
      category: 'Elektronik',
      date: DateTime.now(),
    ),
    Expense(
      description: 'Bensin',
      amount: 45.00,
      category: 'Transport',
      date: DateTime.now(),
    ),
  ];

  for (var expense in expenses) {
    print('${expense.description} -Date: ${expense.date.day}/${expense.date.month}/${expense.date.year}');
    
    print('${expense.isThisMonth()}');

    print('${expense.getDaysAgo()} days ago');
    }

    
  }

