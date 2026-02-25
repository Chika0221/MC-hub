// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectImpl _$$ConnectImplFromJson(Map<String, dynamic> json) =>
    _$ConnectImpl(
      host: ConnectHost.fromJson(json['host'] as Map<String, dynamic>),
      controllerID:
          json['controllerID'] == null
              ? null
              : ConnectController.fromJson(
                json['controllerID'] as Map<String, dynamic>,
              ),
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
      'host': instance.host,
      'controllerID': instance.controllerID,
      'macroQueue': instance.macroQueue,
      'workflowQueue': instance.workflowQueue,
    };

_$ConnectHostImpl _$$ConnectHostImplFromJson(Map<String, dynamic> json) =>
    _$ConnectHostImpl(
      hostID: json['hostID'] as String,
      hostName: json['hostName'] as String,
    );

Map<String, dynamic> _$$ConnectHostImplToJson(_$ConnectHostImpl instance) =>
    <String, dynamic>{'hostID': instance.hostID, 'hostName': instance.hostName};

_$ConnectControllerImpl _$$ConnectControllerImplFromJson(
  Map<String, dynamic> json,
) => _$ConnectControllerImpl(
  controllerID: json['controllerID'] as String,
  controllerName: json['controllerName'] as String,
);

Map<String, dynamic> _$$ConnectControllerImplToJson(
  _$ConnectControllerImpl instance,
) => <String, dynamic>{
  'controllerID': instance.controllerID,
  'controllerName': instance.controllerName,
};
