import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static const String _sessionBox = 'sessionBox';
  static const String _isLoggedInKey = 'isLoggedIn';

  // hive box instance
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_sessionBox);
  }

  // Save login status
  static void setLoggedIn(bool value) {
    var box = Hive.box(_sessionBox);
    box.put(_isLoggedInKey, value);
  }

  // Get login status
  static bool isLoggedIn() {
    var box = Hive.box(_sessionBox);
    return box.get(_isLoggedInKey, defaultValue: false);
  }
}