// Project imports:
import 'package:mc_hub/models/my_device.dart';

final myDevices = [
  MyDevice(
    name: "MCKeyboard",
    vendorId: 0xfeed,
    productId: 0x0,
    usegePage: 0xFF60,
    usege: 0x61,
  ),
];

class DeviceLayoutConfig {
  final int layers;
  final int rows;
  final int cols;

  const DeviceLayoutConfig({
    required this.layers,
    required this.rows,
    required this.cols,
  });
}

final deviceLayouts = {
  "MCKeyboard": const DeviceLayoutConfig(layers: 4, rows: 5, cols: 14),
};
