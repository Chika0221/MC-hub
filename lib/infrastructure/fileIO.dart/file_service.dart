// Dart imports:
import 'dart:convert';
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:file_selector/file_selector.dart';

class FileService {
  static Future<void> saveStringFile(String content) async {}

  static Future<void> saveJsonFile(
    String suggestionName,
    Map<String, dynamic> json,
  ) async {
    final suggestionNameWithExtension =
        suggestionName.endsWith(".json")
            ? suggestionName
            : "$suggestionName.json";

    final jsonString = jsonEncode(json);

    FileSaveLocation? location = await getSaveLocation(
      suggestedName: suggestionNameWithExtension,
      acceptedTypeGroups: [
        XTypeGroup(label: "JSON Files", extensions: ["json"]),
      ],
    );
    print(location?.path);
    if (location == null) {
      return;
    } else {
      final data = Uint8List.fromList(jsonString.codeUnits);
      final mimeType = "application/json";
      final file = XFile.fromData(data, mimeType: mimeType);
      await file.saveTo(location.path);
    }
  }

  static Future<Map<String, dynamic>?> loadjsonFile() async {
    final result = await openFile(
      acceptedTypeGroups: [
        XTypeGroup(label: "JSON Files", extensions: ["json"]),
      ],
    );

    if (result == null) {
      return null;
    } else {
      final file = XFile(result.path);
      // TODO インポートエラーのハンドリング
      try {
        final bytes = await file.readAsBytes();
        final content = _decodeJsonBytes(bytes);
        return jsonDecode(content);
      } catch (e) {
        debugPrint("Failed to load or parse json file: $e");
        return null;
      }
    }
  }

  static String _decodeJsonBytes(Uint8List bytes) {
    if (bytes.length >= 2) {
      if (bytes[0] == 0xFF && bytes[1] == 0xFE) {
        return String.fromCharCodes(Uint16List.sublistView(bytes, 2));
      }
      if (bytes[0] == 0xFE && bytes[1] == 0xFF) {
        final data = bytes.sublist(2);
        final swapped = Uint8List(data.length);
        for (var i = 0; i + 1 < data.length; i += 2) {
          swapped[i] = data[i + 1];
          swapped[i + 1] = data[i];
        }
        return String.fromCharCodes(Uint16List.sublistView(swapped));
      }
    }

    if (bytes.length >= 3 &&
        bytes[0] == 0xEF &&
        bytes[1] == 0xBB &&
        bytes[2] == 0xBF) {
      return utf8.decode(bytes.sublist(3));
    }

    try {
      return utf8.decode(bytes);
    } catch (_) {
      try {
        return latin1.decode(bytes);
      } catch (_) {
        return utf8.decode(bytes, allowMalformed: true);
      }
    }
  }
}
