// Package imports:
import 'package:hid4flutter/hid4flutter.dart';

void deviceList() async {
  List<HidDevice> devices = await Hid.getDevices();

  print(devices);
}
