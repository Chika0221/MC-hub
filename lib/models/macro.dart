// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'macro.freezed.dart';
part 'macro.g.dart';

@freezed
class Macro with _$Macro {
  const factory Macro({
    required String name,
    required MacroType type,
    String? docId,
    List<int>? keys,
    String? appPath,
    String? aiPrompt,
  }) = _Macro;

  factory Macro.fromJson(Map<String, dynamic> json) => _$MacroFromJson(json);
}

enum MacroType { infrared, combo, openApp, aiTextConvert }
