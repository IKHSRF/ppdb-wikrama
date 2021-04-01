import 'package:flutter/foundation.dart';

class TanggalLahirProvider with ChangeNotifier {
  String _tanggalLahir;

  String get tanggalLahir => _tanggalLahir;

  set tanggalLahir(String value) {
    _tanggalLahir = value;
    notifyListeners();
  }
}
