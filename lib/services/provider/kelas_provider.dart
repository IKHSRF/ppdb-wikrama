import 'package:flutter/foundation.dart';

class KelasProvider with ChangeNotifier {
  String _kelas;

  String get kelas => _kelas;
  set kelas(String value) {
    _kelas = value;
    notifyListeners();
  }
}
