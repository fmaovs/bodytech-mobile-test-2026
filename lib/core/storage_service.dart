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

  static Future<void> savePokemonData(List<dynamic> data) async{
    final box = Hive.box('sessionBox');
    await box.put('cached_pokemon', data);
  }

  static List<dynamic>? getCachedPokemon() {
    final box = Hive.box('sessionBox');
    return box.get('cached_pokemon');
  }

  static Future<void> savePokemonDetail(int id, Map<String, dynamic> detailData) async {
    final box = Hive.box('sessionBox');
    await box.put('detail_$id', detailData);
  }

  static Map<String, dynamic>? getPokemonDetail(int id) {
    final box = Hive.box('sessionBox');
    final data = box.get('detail_$id');
    return data != null ? Map<String, dynamic>.from(data) : null;
  }
}