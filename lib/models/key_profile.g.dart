// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KeyProfileImpl _$$KeyProfileImplFromJson(Map<String, dynamic> json) =>
    _$KeyProfileImpl(
      name: json['name'] as String,
      id: json['id'] as String,
      keyMappings: Map<String, String>.from(json['keyMappings'] as Map),
    );

Map<String, dynamic> _$$KeyProfileImplToJson(_$KeyProfileImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'keyMappings': instance.keyMappings,
    };

_$AppLayerImpl _$$AppLayerImplFromJson(
  Map<String, dynamic> json,
) => _$AppLayerImpl(
  name: json['name'] as String,
  id: json['id'] as String,
  appPath: json['appPath'] as String,
  isFocus: json['isFocus'] as bool,
  macros:
      (json['macros'] as List<dynamic>?)
          ?.map(
            (e) => e == null ? null : Macro.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <Macro?>[
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
      ],
);

Map<String, dynamic> _$$AppLayerImplToJson(_$AppLayerImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'appPath': instance.appPath,
      'isFocus': instance.isFocus,
      'macros': instance.macros.map((e) => e?.toJson()).toList(),
    };
