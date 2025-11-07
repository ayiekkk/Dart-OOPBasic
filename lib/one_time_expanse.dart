import 'expanse.dart';

class OneTimeExpense extends Expense {
  String occasion;

  OneTimeExpense({
    required this.occasion,
    required super.description,
    required super.amount,
    required super.category,
    super.notes,
  });

  factory OneTimeExpense.create({
    required String description,
    required double amount,
    required String category,
    required String occasion,
    String? notes,
  }) {
    return OneTimeExpense(
      occasion: occasion,
      description: description,
      amount: amount,
      category: category,
      notes: notes,
    );
  }

  @override
  void printDetails() {
    super.printDetails();
    print('Acara: $occasion');
  }
}