// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:mc_hub/infrastructure/macro/run_macro.dart';

class AppPreferences {
  static final asyncPrefs = SharedPreferencesAsync();

  static Future<void> setPreferences(String key, String value) async {
    await asyncPrefs.setString(key, value);
  }

  static Future<dynamic> getPreferences(String key) async {
    return await asyncPrefs.getString(key);
  }

  static Future<void> setMacro(String macroShortName, String value) async {
    final key = MonitorKeycodes.values.firstWhere(
      (e) => e.shortName == macroShortName,
    );

    await setPreferences(key.name, value);

    print("Set Macro: ${key.name} -> $value");
  }

  static Future<String?> getMacro(MonitorKeycodes keycode) async {
    return await getPreferences(keycode.name);
  }
}
