class RecurringExpense {
  String description;
  double amount;
  String category;
  String frequency;

  RecurringExpense({
    required this.description,
    required this.amount,
    required this.category,
    required this.frequency,
  });

  void printDetails() {
    print('$category - $description');
    print('Biaya: Rp ${amount.toStringAsFixed(2)} / $frequency');
  }

  double yearlyTotal() {
    switch (frequency.toLowerCase()) {
      case 'bulanan':
        return amount * 12;
      case 'harian':
        return amount * 365;
      default:
        return amount;
    }
  }
}

class SubscriptionExpense extends RecurringExpense {
  String provider;
  String plan;
  DateTime startDate;
  DateTime? endDate;

  SubscriptionExpense({
    required super.description,
    required super.amount,
    required this.provider,
    required this.plan,
    required this.startDate,
    this.endDate,
  }) : super(
    category: 'Langganan',
    frequency: 'bulanan',
  );

  bool isActive() {
    DateTime now = DateTime.now();
    if (endDate == null) return true;  // Tidak ada end date = aktif
    return now.isBefore(endDate!);
  }

  int getRemainingMonths() {
    if (endDate == null) return -1;  // Unlimited
    DateTime now = DateTime.now();
    if (now.isAfter(endDate!)) return 0;

    int months = (endDate!.year - now.year) * 12 +
                 (endDate!.month - now.month);
    return months;
  }

  double getTotalCost() {
    if (endDate == null) {
      // Jika tidak ada end date, hitung untuk 1 tahun
      return yearlyTotal();
    }

    int months = (endDate!.year - startDate.year) * 12 +
                 (endDate!.month - startDate.month);
    return amount * months;
  }

  @override
  void printDetails() {
    print('📱 LANGGANAN');
    print('$description ($provider - $plan)');
    print('Biaya: Rp ${amount.toStringAsFixed(2)}/bulan');
    print('Mulai: ${startDate.toString().split(' ')[0]}');

    if (endDate != null) {
      print('Berakhir: ${endDate.toString().split(' ')[0]}');
      print('Sisa: ${getRemainingMonths()} bulan');
    } else {
      print('Berakhir: Tidak pernah (berkelanjutan)');
    }

    print('Status: ${isActive() ? "Aktif ✅" : "Expired ❌"}');
    print('Total biaya: Rp ${getTotalCost().toStringAsFixed(2)}');
  }
}

void main() {
  var netflix = SubscriptionExpense(
    description: 'Netflix Premium',
    amount: 186000,
    provider: 'Netflix',
    plan: 'Premium 4K',
    startDate: DateTime(2024, 1, 1),
    endDate: null,  // Berkelanjutan
  );

  var trial = SubscriptionExpense(
    description: 'Adobe Creative Cloud',
    amount: 800000,
    provider: 'Adobe',
    plan: 'Semua Apps',
    startDate: DateTime(2025, 9, 1),
    endDate: DateTime(2025, 12, 31),
  );

  netflix.printDetails();
  print('');
  trial.printDetails();
}