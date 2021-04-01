import 'package:flutter/foundation.dart';

class JenisKelaminProvider with ChangeNotifier {
  String _jenisKelamin;

  String get jenisKelamin => _jenisKelamin;

  set jenisKelamin(String value) {
    _jenisKelamin = value;
    notifyListeners();
  }
}
