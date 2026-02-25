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
    required ConnectHost host,
    required ConnectController? controllerID,
    List<Macro>? macroQueue,
    List<Workflow>? workflowQueue,
  }) = _Connect;

  factory Connect.fromJson(Map<String, dynamic> json) =>
      _$ConnectFromJson(json);
}

@freezed
class ConnectHost with _$ConnectHost {
  const factory ConnectHost({
    required String hostID,
    required String hostName,
  }) = _ConnectHost;

  factory ConnectHost.fromJson(Map<String, dynamic> json) =>
      _$ConnectHostFromJson(json);
}

@freezed
class ConnectController with _$ConnectController {
  const factory ConnectController({
    required String controllerID,
    required String controllerName,
  }) = _ConnectController;

  factory ConnectController.fromJson(Map<String, dynamic> json) =>
      _$ConnectControllerFromJson(json);
}
