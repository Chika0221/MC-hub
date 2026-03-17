// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:mc_hub/models/macro.dart';

part 'key_profile.freezed.dart';
part 'key_profile.g.dart';

@freezed
class KeyProfile with _$KeyProfile {
  @JsonSerializable(explicitToJson: true)
  const factory KeyProfile({
    required String name,
    required String id,
    required Map<String, String> keyMappings,
  }) = _KeyProfile;

  factory KeyProfile.fromJson(Map<String, dynamic> json) =>
      _$KeyProfileFromJson(json);
}

@freezed
class AppLayer with _$AppLayer {
  @JsonSerializable(explicitToJson: true)
  const factory AppLayer({
    required String Name,
    required String Id,
    required String appPath,
    required bool isFocus,
    @Default(<Macro?>[
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
    ])
    List<Macro?> macros,
  }) = _AppLayer;

  factory AppLayer.fromJson(Map<String, dynamic> json) =>
      _$AppLayerFromJson(json);
}
