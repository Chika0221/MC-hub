// Dart imports:
import 'dart:convert';

class FileService {
  static Future<void> saveStringFile(String content) async {}

  static Future<void> saveJsonFile(Map<String, dynamic> json) async {
    final jsonString = jsonEncode(json);

    
  }
}
