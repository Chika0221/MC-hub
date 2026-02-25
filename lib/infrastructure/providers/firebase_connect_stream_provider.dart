// Dart imports:
import 'dart:async';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/models/connect.dart';

class FirebaseConnectStreamNotifier extends StreamNotifier<Connect> {
  final connect_collection = FirebaseFirestore.instance.collection("connect");

  String? docId;

  @override
  Stream<Connect> build() async* {
    final deviceInfo = await DeviceInfoPlugin().windowsInfo;

    docId ??= deviceInfo.deviceId;

    ref.onDispose(() {
      final id = docId;
      if (id == null) return;
      scheduleMicrotask(() {
        unawaited(connect_collection.doc(id).delete());
      });
    });

    await connect_collection
        .doc(docId!)
        .set(
          Connect(
            hostID: deviceInfo.deviceId,
            hostName: deviceInfo.computerName,
            controllerID: null,
            controllerName: null,
          ).toJson(),
        );

    yield* connect_collection.doc(docId!).snapshots().map((e) {
      return Connect.fromJson(e.data()!);
    });
  }
}

final firebaseConnectStreamProvider =
    StreamNotifierProvider.autoDispose<FirebaseConnectStreamNotifier, Connect>(
      FirebaseConnectStreamNotifier.new,
    );
