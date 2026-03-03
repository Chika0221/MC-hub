// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/macro/run_macro.dart';
import 'package:mc_hub/infrastructure/workflow/run_workflow.dart';
import 'package:mc_hub/models/connect.dart';
import 'package:mc_hub/models/macro.dart';

class FirebaseConnectStreamNotifier extends StreamNotifier<Connect> {
  final connect_collection = FirebaseFirestore.instance.collection("connect");

  String? docId;

  bool _wasQueueNotEmpty = false;

  bool _isQueueNotEmpty(Connect connect) {
    final hasMacros = connect.macroQueue.isNotEmpty;
    final hasWorkflows = connect.workflowQueue.isNotEmpty;
    return hasMacros || hasWorkflows;
  }

  Future<void> onQueueNotEmpty(Connect connect) async {
    if (connect.workflowQueue.isNotEmpty) {
      final workflows = connect.workflowQueue;

      for (final workflow in workflows) {
        await WorkflowService(workflow: workflow).runWorkflow();
      }
    }
    if (connect.macroQueue.isNotEmpty) {
      final macros = connect.macroQueue;

      for (final macro in macros) {
        await MacroService.runMacro(macro);
      }
    }
    await updateConnect(connect.copyWith(macroQueue: [], workflowQueue: []));
  }

  @override
  Stream<Connect> build() async* {
    final deviceInfo = await DeviceInfoPlugin().windowsInfo;

    docId ??= deviceInfo.deviceId;

    final docRef = connect_collection.doc(docId!);

    // TODO 後で消す
    final value = await Clipboard.getData(Clipboard.kTextPlain);
    if (value != null) {
      print("Clipboard value: ${value.text}");
    }

    final initial =
        Connect(
          hostID: deviceInfo.deviceId,
          hostName: deviceInfo.computerName,
          controllerID: null,
          controllerName: null,
          infoAction: InfoAction.text(
            text: value?.text ?? "",
            macro: Macro(
              type: MacroType.text,
              text: value?.text,
              name: value?.text ?? "Initial Macro",
            ),
          ),
        ).toJson();

    await docRef.set(initial, SetOptions(merge: true));

    await for (final snapshot in docRef.snapshots()) {
      final data = snapshot.data();
      if (data == null) {
        continue;
      }

      final connect = Connect.fromJson(data);
      final isQueueNotEmpty = _isQueueNotEmpty(connect);
      if (isQueueNotEmpty && !_wasQueueNotEmpty) {
        await onQueueNotEmpty(connect);
      }
      _wasQueueNotEmpty = isQueueNotEmpty;

      yield connect;
    }
  }

  Future<void> updateConnect(Connect connect) async {
    if (docId == null) {
      final deviceInfo = await DeviceInfoPlugin().windowsInfo;
      docId = deviceInfo.deviceId;
    }

    await connect_collection
        .doc(docId!)
        .set(connect.toJson(), SetOptions(merge: true));
  }

  Future<void> close() async {
    if (docId == null) {
      final deviceInfo = await DeviceInfoPlugin().windowsInfo;
      docId = deviceInfo.deviceId;
    }

    await connect_collection.doc(docId!).set({
      "state": ConnectState.offline.name,
    }, SetOptions(merge: true));
  }
}

final firebaseConnectStreamProvider =
    StreamNotifierProvider.autoDispose<FirebaseConnectStreamNotifier, Connect>(
      FirebaseConnectStreamNotifier.new,
    );
