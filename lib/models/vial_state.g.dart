// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vial_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VialStateImpl _$$VialStateImplFromJson(Map<String, dynamic> json) =>
    _$VialStateImpl(
      isConnected: json['isConnected'] as bool? ?? false,
      deviceName: json['deviceName'] as String?,
      statusMessage: json['statusMessage'] as String?,
      keyMappings:
          (json['keyMappings'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      matrix:
          (json['matrix'] as List<dynamic>?)
              ?.map(
                (e) =>
                    (e as List<dynamic>)
                        .map(
                          (e) =>
                              (e as List<dynamic>)
                                  .map((e) => (e as num).toInt())
                                  .toList(),
                        )
                        .toList(),
              )
              .toList(),
    );

Map<String, dynamic> _$$VialStateImplToJson(_$VialStateImpl instance) =>
    <String, dynamic>{
      'isConnected': instance.isConnected,
      'deviceName': instance.deviceName,
      'statusMessage': instance.statusMessage,
      'keyMappings': instance.keyMappings,
      'matrix': instance.matrix,
    };
