// Package imports:
import 'package:hid4flutter/hid4flutter.dart';

Future<List<HidDevice>> deviceList() async {
  // List<HidDevice> devices = await Hid.getDevices();
  List<HidDevice> devices = await Hid.getDevices(
    vendorId: 0xfeed,
    productId: 0x0,
  );

  // vendorId=0xfeed,
  // productId=0x0,

  return [devices.first];
}
