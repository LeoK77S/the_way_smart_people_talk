import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_way_smart_people_talk/cipher.dart';

class GlobalAppProfile {
  static late SharedPreferences _preferences;
  static late CipherType cipherType;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
    cipherType = CipherType.values[_preferences.getInt('cipherType') ?? 0];
  }

  static saveCipherType(CipherType cipherType) {
    _preferences.setInt('cipherType', cipherType.index);
  }
}
