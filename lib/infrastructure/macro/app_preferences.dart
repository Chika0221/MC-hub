// Package imports:

// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:mc_hub/infrastructure/macro/run_macro.dart';
import 'package:mc_hub/models/macro.dart';

class AppPreferences {
  static final asyncPrefs = SharedPreferencesAsync();

  static Future<void> setPreferences(String key, String value) async {
    await asyncPrefs.setString(key, value);
  }

  static Future<String?> getPreferences(String key) async {
    return await asyncPrefs.getString(key);
  }

  static Future<void> setMacro(String macroShortName, Macro value) async {
    try {
      final key = MonitorKeycodes.values.firstWhere(
        (e) => e.shortName == macroShortName,
      );

      final valueString = jsonEncode(value.toJson());

      await setPreferences(key.name, valueString);

      print("Set Macro: ${key.name} -> $value");
    } on StateError {
      print("Warning: Macro with short name '$macroShortName' not found.");
    }
  }

  static Future<Macro?> getMacro(MonitorKeycodes keycode) async {
    try {
      final valueString = await getPreferences(keycode.name);

      if (valueString != null) {
        final valueJson = jsonDecode(valueString);
        return Macro.fromJson(valueJson);
      }
    } on StateError {
      print("Warning: Macro with keycode '${keycode.name}' not found.");
      return null;
    }

    return null;
  }
}
