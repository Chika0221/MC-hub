// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:mc_hub/models/macro.dart';
import 'package:mc_hub/models/workflow.dart';

part 'connect.freezed.dart';
part 'connect.g.dart';

@freezed
class Connect with _$Connect {
  const factory Connect({
    required String? hostID,
    required String? controllerID,
    required String? hostName,
    required String? controllerName,
    List<Macro>? macroQueue,
    List<Workflow>? workflowQueue,
  }) = _Connect;

  factory Connect.fromJson(Map<String, dynamic> json) =>
      _$ConnectFromJson(json);
}
