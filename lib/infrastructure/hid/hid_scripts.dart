// Package imports:
import 'package:hid4flutter/hid4flutter.dart';

// Project imports:
import 'package:mc_hub/infrastructure/hid/list_of_mydevices.dart';

List<HidDevice> filterMyKeyboards(List<HidDevice> devices) {
  return devices
      .where(
        (device) => myDevices.any((myDevice) {
          return device.vendorId == myDevice.vendorId &&
              device.productId == myDevice.productId &&
              device.usagePage == myDevice.usegePage &&
              device.usage == myDevice.usege;
        }),
      )
      .toList();
}

Future<List<HidDevice>> deviceList() async {
  final devices = await Hid.getDevices();
  final keyboards = filterMyKeyboards(devices);
  print(keyboards);
  return keyboards;
}
