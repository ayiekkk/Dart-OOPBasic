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
    print('   Deskripsi: $description');
    print('   Jumlah: Rp ${amount.toStringAsFixed(2)}');
    print('   Kategori: $category');
    print('   Tanggal: ${date.toString().split(' ')[0]}');
  }
}

class TravelExpense extends Expense {
  String destination;
  int tripDuration;

  TravelExpense({
    required super.description,
    required super.amount,
    required this.destination,
    required this.tripDuration,
    DateTime? date,
  }) : super(
    category: 'Perjalanan',
    date: date ?? DateTime.now(),
  );

  double getDailyCost() {
    if (tripDuration == 0) return amount;
    return amount / tripDuration;
  }

  bool isInternational() {
    // Cek sederhana - bisa diperbaiki dengan list negara
    return destination.contains('Jepang') ||
           destination.contains('Singapura') ||
           destination.contains('Malaysia') ||
           destination.contains('Korea');
  }

  @override
  void printDetails() {
    print('✈️ PENGELUARAN PERJALANAN');
    super.printDetails();
    print('   Destinasi: $destination');
    print('   Durasi: $tripDuration hari');
    print('   Biaya harian: Rp ${getDailyCost().toStringAsFixed(2)}');
    print('   Internasional: ${isInternational() ? "Ya 🌍" : "Tidak 🏠"}');
  }
}

void main() {
  var trip = TravelExpense(
    description: 'Liburan Tokyo',
    amount: 25000000.0,
    destination: 'Tokyo, Jepang',
    tripDuration: 7,
  );

  trip.printDetails();
}