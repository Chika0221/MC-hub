// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkflowImpl _$$WorkflowImplFromJson(Map<String, dynamic> json) =>
    _$WorkflowImpl(
      displayName: json['displayName'] as String,
      actions:
          (json['actions'] as List<dynamic>)
              .map((e) => WorkflowAction.fromJson(e as Map<String, dynamic>))
              .toList(),
      trigger: WorkflowTrigger.fromJson(
        json['trigger'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$$WorkflowImplToJson(_$WorkflowImpl instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'actions': instance.actions,
      'trigger': instance.trigger,
    };

_$WorkflowActionImpl _$$WorkflowActionImplFromJson(Map<String, dynamic> json) =>
    _$WorkflowActionImpl(
      actionId: json['actionId'] as String,
      nextActionIds:
          (json['nextActionIds'] as List<dynamic>)
              .map((e) => e as String?)
              .toList(),
      ActionName: json['ActionName'] as String,
      positionX: (json['positionX'] as num).toInt(),
      PositionY: (json['PositionY'] as num).toInt(),
      actionType: $enumDecode(_$ActionTypeEnumMap, json['actionType']),
      macro:
          json['macro'] == null
              ? null
              : Macro.fromJson(json['macro'] as Map<String, dynamic>),
      delayDuration:
          json['delayDuration'] == null
              ? null
              : Duration(microseconds: (json['delayDuration'] as num).toInt()),
      notificationMessage: json['notificationMessage'] as String?,
    );

Map<String, dynamic> _$$WorkflowActionImplToJson(
  _$WorkflowActionImpl instance,
) => <String, dynamic>{
  'actionId': instance.actionId,
  'nextActionIds': instance.nextActionIds,
  'ActionName': instance.ActionName,
  'positionX': instance.positionX,
  'PositionY': instance.PositionY,
  'actionType': _$ActionTypeEnumMap[instance.actionType]!,
  'macro': instance.macro,
  'delayDuration': instance.delayDuration?.inMicroseconds,
  'notificationMessage': instance.notificationMessage,
};

const _$ActionTypeEnumMap = {
  ActionType.Start: 'Start',
  ActionType.Macro: 'Macro',
  ActionType.Delay: 'Delay',
  ActionType.Notification: 'Notification',
  ActionType.End: 'End',
};

_$WorkflowTriggerImpl _$$WorkflowTriggerImplFromJson(
  Map<String, dynamic> json,
) => _$WorkflowTriggerImpl(
  type: $enumDecode(_$TriggerTypeEnumMap, json['type']),
  scheduledTime:
      json['scheduledTime'] == null
          ? null
          : DateTime.parse(json['scheduledTime'] as String),
);

Map<String, dynamic> _$$WorkflowTriggerImplToJson(
  _$WorkflowTriggerImpl instance,
) => <String, dynamic>{
  'type': _$TriggerTypeEnumMap[instance.type]!,
  'scheduledTime': instance.scheduledTime?.toIso8601String(),
};

const _$TriggerTypeEnumMap = {
  TriggerType.TimeBased: 'TimeBased',
  TriggerType.EventBased: 'EventBased',
};
