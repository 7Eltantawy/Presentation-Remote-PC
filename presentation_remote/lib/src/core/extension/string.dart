extension StringExtension on String {
  bool isIP() {
    if (!_ipv4Maybe.hasMatch(this)) {
      return false;
    }
    final parts = split('.');
    parts.sort((a, b) => int.parse(a) - int.parse(b));
    return int.parse(parts[3]) <= 255;
  }
}

final RegExp _ipv4Maybe =
    RegExp(r'^(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)$');
