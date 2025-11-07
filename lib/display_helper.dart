import 'dart:io';

class DisplayHelper {
  static void clearScreen() {
    if (Platform.isWindows) {
      stdout.write('\x1B[2J\x1B[0;0H');
    } else {
      stdout.write('\x1B[2J\x1B[H');
    }
  }

  static void printHeader(String title) {
    print('\n=== $title ===\n');
  }

  static void printInfo(String message) => print('ℹ️  $message');
  static void printSuccess(String message) => print('✅  $message');
  static void printError(String message) => print('❌  $message');
  static void printWarning(String message) => print('⚠️  $message');
}