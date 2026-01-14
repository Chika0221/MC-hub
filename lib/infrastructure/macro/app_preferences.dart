// Package imports:

// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:mc_hub/infrastructure/macro/run_macro.dart';
import 'package:mc_hub/models/infrared_code.dart';
import 'package:mc_hub/models/macro.dart';

class AppPreferences {
  static final asyncPrefs = SharedPreferencesAsync();

  static final _codesCollection = FirebaseFirestore.instance.collection(
    'codes',
  );

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
        try {
          final decoded = jsonDecode(valueString);

          if (decoded is Map<String, dynamic>) {
            return Macro.fromJson(decoded);
          }

          if (decoded is String) {
            return await _migrateLegacyDocId(keycode: keycode, docId: decoded);
          }

          return null;
        } on FormatException {
          // Legacy format: valueString itself is likely a Firestore docId.
          return await _migrateLegacyDocId(
            keycode: keycode,
            docId: valueString,
          );
        }
      }
    } on StateError {
      print("Warning: Macro with keycode '${keycode.name}' not found.");
      return null;
    }

    return null;
  }

  static Future<Macro?> _migrateLegacyDocId({
    required MonitorKeycodes keycode,
    required String docId,
  }) async {
    try {
      final docSnapshot = await _codesCollection.doc(docId).get();
      final data = docSnapshot.data();
      if (!docSnapshot.exists || data == null) {
        return null;
      }

      final code = InfraredCode.fromJson(data);
      final macro = Macro(
        name: code.name,
        type: MacroType.infrared,
        docId: docId,
      );

      // Write back in the new JSON format so future reads are stable.
      await setPreferences(keycode.name, jsonEncode(macro.toJson()));

      return macro;
    } catch (_) {
      // If migration fails (network/offline/permission), avoid crashing UI.
      return null;
    }
  }
}
