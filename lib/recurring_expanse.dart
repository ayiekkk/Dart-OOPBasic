import 'expanse.dart';

class RecurringExpense extends Expense {
  String frequency;

  RecurringExpense({
    required this.frequency,
    required super.description,
    required super.amount,
    required super.category,
    super.notes,
  });

  factory RecurringExpense.create({
    required String description,
    required double amount,
    required String category,
    required String frequency,
    String? notes,
  }) {
    return RecurringExpense(
      frequency: frequency,
      description: description,
      amount: amount,
      category: category,
      notes: notes,
    );
  }

  @override
  void printDetails() {
    super.printDetails();
    print('Frekuensi: $frequency');
  }
}