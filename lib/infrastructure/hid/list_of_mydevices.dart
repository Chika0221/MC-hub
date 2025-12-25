// Project imports:
import 'package:mc_hub/models/my_device.dart';
import 'package:mc_hub/pages/editor_page/key_data.dart';

final myDevices = [
  MyDevice(
    name: "MCKeyboard",
    vendorId: 0xfeed,
    productId: 0x6D63,
    usegePage: 0xFF60,
    usege: 0x61,
    keys: [
      // Row 0
      [
        KeyData(id: "0,0", defaultLabel: 'Esc', width: 1.25),
        KeyData(id: "0,1", defaultLabel: '~', width: 1.0),
        KeyData(id: "0,2", defaultLabel: 'Q', width: 1.0),
        KeyData(id: "0,3", defaultLabel: 'W', width: 1.0),
        KeyData(id: "0,4", defaultLabel: 'E', width: 1.0),
        KeyData(id: "0,5", defaultLabel: 'R', width: 1.0),
        KeyData(id: "0,6", defaultLabel: 'T', width: 1.0),
        KeyData(id: "0,7", defaultLabel: 'Y', width: 1.0),
        KeyData(id: "0,8", defaultLabel: 'U', width: 1.0),
        KeyData(id: "0,9", defaultLabel: 'I', width: 1.0),
        KeyData(id: "0,10", defaultLabel: 'O', width: 1.0),
        KeyData(id: "0,11", defaultLabel: 'P', width: 1.0),
        KeyData(id: "0,12", defaultLabel: '{', width: 1.0),
        KeyData(id: "0,13", defaultLabel: '}', width: 1.0),
        KeyData(id: "3,13", defaultLabel: 'Bksp', width: 2.0),
      ],

      // Row 1
      [
        KeyData(id: "1,0", defaultLabel: 'Tab', width: 1.25),
        KeyData(id: "1,1", defaultLabel: 'MO(2)', width: 1.25),
        KeyData(id: "1,2", defaultLabel: 'A', width: 1.0),
        KeyData(id: "1,3", defaultLabel: 'S', width: 1.0),
        KeyData(id: "1,4", defaultLabel: 'D', width: 1.0),
        KeyData(id: "1,5", defaultLabel: 'F', width: 1.0),
        KeyData(id: "1,6", defaultLabel: 'G', width: 1.0),
        KeyData(id: "1,7", defaultLabel: 'H', width: 1.0),
        KeyData(id: "1,8", defaultLabel: 'J', width: 1.0),
        KeyData(id: "1,9", defaultLabel: 'K', width: 1.0),
        KeyData(id: "1,10", defaultLabel: 'L', width: 1.0),
        KeyData(id: "1,11", defaultLabel: ':', width: 1.0),
        KeyData(id: "1,12", defaultLabel: '"', width: 1.0),
        KeyData(id: "1,13", defaultLabel: 'Enter', width: 2.75),
      ],

      // Row 2
      [
        KeyData(id: "2,0", defaultLabel: 'LShift', width: 1.5),
        KeyData(id: "2,1", defaultLabel: 'MO(1)', width: 1.25),
        KeyData(id: "2,2", defaultLabel: 'Z', width: 1.0),
        KeyData(id: "2,3", defaultLabel: 'X', width: 1.0),
        KeyData(id: "2,4", defaultLabel: 'C', width: 1.0),
        KeyData(id: "2,5", defaultLabel: 'V', width: 1.0),
        KeyData(id: "2,6", defaultLabel: 'B', width: 1.0),
        KeyData(id: "2,7", defaultLabel: 'N', width: 1.0),
        KeyData(id: "2,8", defaultLabel: 'M', width: 1.0),
        KeyData(id: "2,9", defaultLabel: '<', width: 1.0),
        KeyData(id: "2,10", defaultLabel: '>', width: 1.0),
        KeyData(id: "2,11", defaultLabel: '?', width: 1.0),
        KeyData(id: "2,12", defaultLabel: 'MO(3)', width: 1.5),
        KeyData(id: "2,13", defaultLabel: 'Up', width: 1.0),
      ],

      // Row 3
      [
        KeyData(id: "3,0", defaultLabel: 'LCtrl', width: 1.5),
        KeyData(id: "3,1", defaultLabel: 'LGui', width: 1.5),
        KeyData(id: "3,3", defaultLabel: 'LAlt', width: 1.5),
        KeyData(id: "3,6", defaultLabel: 'Space', width: 6.25),
        KeyData(id: "3,8", defaultLabel: 'Home', width: 1.25),
        KeyData(id: "3,9", defaultLabel: 'End', width: 1.25),
        KeyData(id: "3,10", defaultLabel: 'Left', width: 1.0),
        KeyData(id: "3,11", defaultLabel: 'Down', width: 1.0),
        KeyData(id: "3,12", defaultLabel: 'Right', width: 1.0),
      ],
    ],
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
