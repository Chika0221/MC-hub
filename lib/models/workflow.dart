// Flutter imports:

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:mc_hub/models/macro.dart';

part 'workflow.freezed.dart';
part 'workflow.g.dart';

@freezed
class Workflow with _$Workflow {
  const factory Workflow({
    required String displayName,
    required List<WorkflowAction> actions,
    required WorkflowTrigger trigger,
  }) = _Workflow;

  factory Workflow.fromJson(Map<String, dynamic> json) =>
      _$WorkflowFromJson(json);
}

@freezed
class WorkflowAction with _$WorkflowAction {
  const factory WorkflowAction({
    required String actionId,
    required List<String?> nextActionIds,
    required String ActionName,
    required int positionX,
    required int PositionY,
    required ActionType actionType,
    required Macro? macro,
    required Duration? delayDuration,
    required String? notificationMessage,
  }) = _WorkflowAction;

  factory WorkflowAction.fromJson(Map<String, dynamic> json) =>
      _$WorkflowActionFromJson(json);
}

@freezed
class WorkflowTrigger with _$WorkflowTrigger {
  const factory WorkflowTrigger({
    required TriggerType type,
    required DateTime? scheduledTime,
  }) = _WorkflowTrigger;

  factory WorkflowTrigger.fromJson(Map<String, dynamic> json) =>
      _$WorkflowTriggerFromJson(json);
}

enum ActionType { Start, Macro, Delay, Notification, End }

enum TriggerType { TimeBased, EventBased }
