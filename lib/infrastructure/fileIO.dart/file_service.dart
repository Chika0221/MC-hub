// Dart imports:
import 'dart:convert';
import 'dart:typed_data';

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
}
