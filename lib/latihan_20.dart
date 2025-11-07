import 'dart:convert';
import 'dart:io';

class BudgetCategory {
  String name;
  double limit;
  double spent = 0;

  BudgetCategory(this.name, this.limit);

  void addExpense(double amount) => spent += amount;

  double get remaining => limit - spent;

  Map<String, dynamic> toJson() => {
        'name': name,
        'limit': limit,
        'spent': spent,
      };

  BudgetCategory.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        limit = json['limit'],
        spent = json['spent'];
}

class User {
  String username;
  String password;
  List<BudgetCategory> categories = [];

  User(this.username, this.password);

  void addCategory(String name, double limit) {
    categories.add(BudgetCategory(name, limit));
  }

  void addExpense(String categoryName, double amount) {
    for (var c in categories) {
      if (c.name.toLowerCase() == categoryName.toLowerCase()) {
        c.addExpense(amount);
        print('✅ Rp${amount.toStringAsFixed(2)} ditambahkan ke kategori ${c.name}.');
        return;
      }
    }
    print('❌ Kategori "$categoryName" tidak ditemukan.');
  }

  void showReport() {
    print('\n=== LAPORAN BUDGET ${username.toUpperCase()} ===');
    for (var c in categories) {
      print('\n--- ${c.name.toUpperCase()} ---');
      print('Limit: Rp${c.limit.toStringAsFixed(2)}');
      print('Dihabiskan: Rp${c.spent.toStringAsFixed(2)}');
      print('Sisa: Rp${c.remaining.toStringAsFixed(2)}');

      if (c.spent > c.limit) {
        print('⚠️  MELEBIHI LIMIT!');
      } else if (c.spent > c.limit * 0.8) {
        print('⚠️  Hati-hati, hampir mencapai batas!');
      }
    }
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'categories': categories.map((c) => c.toJson()).toList(),
      };

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'],
        categories = (json['categories'] as List)
            .map((c) => BudgetCategory.fromJson(c))
            .toList();
}

class BudgetApp {
  Map<String, User> users = {};
  User? currentUser;
  final String dataFile = 'budget_data.json';

  BudgetApp() {
    _loadData();
  }

  void _loadData() {
    final file = File(dataFile);
    if (!file.existsSync()) return;
    final content = file.readAsStringSync();
    final data = jsonDecode(content);

    users = {
      for (var u in data)
        u['username']: User.fromJson(Map<String, dynamic>.from(u))
    };
  }

  void _saveData() {
    final file = File(dataFile);
    final data = users.values.map((u) => u.toJson()).toList();
    file.writeAsStringSync(JsonEncoder.withIndent('  ').convert(data));
  }

  void register() {
    stdout.write('Masukkan username: ');
    final username = stdin.readLineSync()!;
    if (users.containsKey(username)) {
      print('❌ Username sudah digunakan.');
      return;
    }

    stdout.write('Masukkan password: ');
    final password = stdin.readLineSync()!;
    users[username] = User(username, password);
    _saveData();
    print('✅ Akun berhasil dibuat.');
  }

  bool login() {
    stdout.write('Username: ');
    final username = stdin.readLineSync()!;
    stdout.write('Password: ');
    final password = stdin.readLineSync()!;

    if (users.containsKey(username) && users[username]!.password == password) {
      currentUser = users[username];
      print('\n👋 Selamat datang, ${currentUser!.username}!');
      return true;
    }
    print('❌ Username atau password salah.');
    return false;
  }

  void userMenu() {
    while (true) {
      print('''
      
=== MENU USER (${currentUser!.username}) ===
1. Tambah kategori
2. Tambah pengeluaran
3. Lihat laporan
4. Logout
''');

      stdout.write('Pilih menu: ');
      final choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          stdout.write('Nama kategori: ');
          final name = stdin.readLineSync()!;
          stdout.write('Limit: ');
          final limit = double.parse(stdin.readLineSync()!);
          currentUser!.addCategory(name, limit);
          _saveData();
          break;
        case '2':
          stdout.write('Kategori: ');
          final cat = stdin.readLineSync()!;
          stdout.write('Jumlah pengeluaran: ');
          final amount = double.parse(stdin.readLineSync()!);
          currentUser!.addExpense(cat, amount);
          _saveData();
          break;
        case '3':
          currentUser!.showReport();
          break;
        case '4':
          currentUser = null;
          print('👋 Logout berhasil.');
          return;
        default:
          print('❌ Pilihan tidak valid.');
      }
    }
  }

  void start() {
    while (true) {
      print('''
=== SISTEM BUDGET MULTI-USER ===
1. Daftar akun
2. Login
3. Keluar
''');

      stdout.write('Pilih menu: ');
      final choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          register();
          break;
        case '2':
          if (login()) userMenu();
          break;
        case '3':
          print('👋 Terima kasih sudah menggunakan BudgetApp.');
          _saveData();
          return;
        default:
          print('❌ Pilihan tidak valid.');
      }
    }
  }
}

void main() {
  final app = BudgetApp();
  app.start();
}