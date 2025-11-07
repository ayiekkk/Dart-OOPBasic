class Budget {
  String category;
  double limit;
  int month;
  int year;
  int day;

  Budget(this.category, this.limit,this.day, this.month, this.year);
      

  Budget.monthly(this.category, this.limit)
    : day = DateTime.now().day, 
      month = DateTime.now().month,
      year = DateTime.now().year;

  void printDetails() {
    print('$category: \$${limit.toStringAsFixed(2)} pada tanggal $day/$month/$year');
  }
}

void main() {
  var foodBudget = Budget.monthly('Makanan', 500.0);
  var rentBudget = Budget('Sewa', 1200.0, 1, 10, 2025);

  foodBudget.printDetails();
  rentBudget.printDetails();
}
