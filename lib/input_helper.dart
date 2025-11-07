import 'dart:io';

class InputHelper {
  static String readString(String prompt) {
    stdout.write('$prompt: ');
    return stdin.readLineSync()!.trim();
  }

  static int readInt(String prompt, {int? min, int? max}) {
    while (true) {
      stdout.write('$prompt: ');
      final input = stdin.readLineSync();
      final value = int.tryParse(input ?? '');
      if (value != null &&
          (min == null || value >= min) &&
          (max == null || value <= max)) {
        return value;
      }
      print('❌ Input tidak valid, coba lagi.');
    }
  }

  static double readDouble(String prompt, {double? min}) {
    while (true) {
      stdout.write('$prompt: ');
      final input = stdin.readLineSync();
      final value = double.tryParse(input ?? '');
      if (value != null && (min == null || value >= min)) {
        return value;
      }
      print('❌ Masukkan angka yang valid.');
    }
  }

  static bool readYesNo(String prompt) {
    stdout.write('$prompt (y/n): ');
    final input = stdin.readLineSync()!.trim().toLowerCase();
    return input == 'y' || input == 'ya';
  }

  static String readChoice(String title, List<String> options) {
    print('$title:');
    for (var i = 0; i < options.length; i++) {
      print('  ${i + 1}. ${options[i]}');
    }
    final choice = readInt('Pilih', min: 1, max: options.length);
    return options[choice - 1];
  }

  static void pause() {
    stdout.write('\nTekan Enter untuk lanjut...');
    stdin.readLineSync();
  }
}