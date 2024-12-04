extension StringExtension on String {
  String reverse() {
    return split('').reversed.join();
  }
}