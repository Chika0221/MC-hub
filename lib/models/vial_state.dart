// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vial_state.freezed.dart';
part 'vial_state.g.dart';

@freezed
class VialState with _$VialState {
  const factory VialState({
    @Default(false) bool isConnected,
    String? deviceName,
    required String? statusMessage,
    @Default({}) Map<String, String> keyMappings,
    required List<List<List<int>>>? matrix,
  }) = _VialState;

  factory VialState.fromJson(Map<String, dynamic> json) =>
      _$VialStateFromJson(json);
}
