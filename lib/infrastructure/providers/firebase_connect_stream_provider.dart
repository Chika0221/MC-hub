// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/models/connect.dart';

class FirebaseConnectStreamNotifier extends StreamNotifier<Connect> {
  final connect_collection = FirebaseFirestore.instance.collection("connect");

  @override
  Stream<Connect> build() async* {
    final deviceInfo = await DeviceInfoPlugin().windowsInfo;

    await connect_collection.add(
      Connect(
        host: ConnectHost(
          hostID: deviceInfo.deviceId,
          hostName: deviceInfo.computerName,
        ),
        controllerID: null,
      ).toJson(),
    );

    // return connect_collection.snapshots().map((e) {
    //   return e.docs.map((e) => Connect.fromJson(e.data())).toList();
    // });
  }
}
