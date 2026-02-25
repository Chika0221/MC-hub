// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectImpl _$$ConnectImplFromJson(Map<String, dynamic> json) =>
    _$ConnectImpl(
      hostID: json['hostID'] as String?,
      controllerID: json['controllerID'] as String?,
      state: $enumDecode(_$ConnectStateEnumMap, json['state']),
      hostName: json['hostName'] as String?,
      controllerName: json['controllerName'] as String?,
      macroQueue:
          (json['macroQueue'] as List<dynamic>?)
              ?.map((e) => Macro.fromJson(e as Map<String, dynamic>))
              .toList(),
      workflowQueue:
          (json['workflowQueue'] as List<dynamic>?)
              ?.map((e) => Workflow.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$$ConnectImplToJson(_$ConnectImpl instance) =>
    <String, dynamic>{
      'hostID': instance.hostID,
      'controllerID': instance.controllerID,
      'state': _$ConnectStateEnumMap[instance.state]!,
      'hostName': instance.hostName,
      'controllerName': instance.controllerName,
      'macroQueue': instance.macroQueue,
      'workflowQueue': instance.workflowQueue,
    };

const _$ConnectStateEnumMap = {
  ConnectState.ready: 'ready',
  ConnectState.connected: 'connected',
  ConnectState.offline: 'offline',
};
