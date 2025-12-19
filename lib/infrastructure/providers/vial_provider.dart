// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/hid/list_of_mydevices.dart';
import 'package:mc_hub/infrastructure/hid/vial_service.dart';
import 'package:mc_hub/models/my_device.dart';

// State to hold connection status and potentially cached data
class VialState {
  final bool isConnected;
  final String? statusMessage;
  final Map<String, String> keyMappings;

  VialState({
    this.isConnected = false,
    this.statusMessage,
    this.keyMappings = const {},
  });

  VialState copyWith({
    bool? isConnected,
    String? statusMessage,
    Map<String, String>? keyMappings,
  }) {
    return VialState(
      isConnected: isConnected ?? this.isConnected,
      statusMessage: statusMessage ?? this.statusMessage,
      keyMappings: keyMappings ?? this.keyMappings,
    );
  }
}

class VialNotifier extends Notifier<VialState> {
  final _service = VialService();

  // Basic 60% mapping (approximate GH60/standard 60% matrix)
  // Mapping Key ID (from layout_data.dart) to (Row, Col)
  // This is a best-effort mapping for a standard 60% PCB.
  // Made public for testing
  static const Map<String, List<int>> keyIdToMatrix = {
    "k41": [0, 0], // Esc
    "k30": [0, 1], // 1
    "k31": [0, 2], // 2
    "k32": [0, 3], // 3
    "k33": [0, 4], // 4
    "k34": [0, 5], // 5
    "k35": [0, 6], // 6
    "k36": [0, 7], // 7
    "k37": [0, 8], // 8
    "k38": [0, 9], // 9
    "k39": [0, 10], // 0
    "k45": [0, 11], // -
    "k46": [0, 12], // =
    "k42": [0, 13], // Bksp

    "k43": [1, 0], // Tab
    "k20": [1, 1], // Q
    "k26": [1, 2], // W
    "k08": [1, 3], // E
    "k21": [1, 4], // R
    "k23": [1, 5], // T
    "k28": [1, 6], // Y
    "k24": [1, 7], // U
    "k12": [1, 8], // I
    "k18": [1, 9], // O
    "k19": [1, 10], // P
    "k47": [1, 11], // [
    "k48": [1, 12], // ]
    "k49": [1, 13], // \

    "k57": [2, 0], // Caps
    "k04": [2, 1], // A
    "k22": [2, 2], // S
    "k07": [2, 3], // D
    "k09": [2, 4], // F
    "k10": [2, 5], // G
    "k11": [2, 6], // H
    "k13": [2, 7], // J
    "k14": [2, 8], // K
    "k15": [2, 9], // L
    "k51": [2, 10], // ;
    "k52": [2, 11], // '
    "k40": [2, 12], // Enter (often spans cols)

    "k225": [3, 0], // Shift
    "k29": [3, 1], // Z
    "k27": [3, 2], // X
    "k06": [3, 3], // C
    "k25": [3, 4], // V
    "k05": [3, 5], // B
    "k17": [3, 6], // N
    "k16": [3, 7], // M
    "k54": [3, 8], // ,
    "k55": [3, 9], // .
    "k56": [3, 10], // /
    "k229": [3, 11], // RShift

    "k224": [4, 0], // LCtrl
    "k227": [4, 1], // Win
    "k226": [4, 2], // Alt
    "k44": [4, 3], // Space
    "k230": [4, 4], // RAlt
    "k231": [4, 5], // RWin
    "k101": [4, 6], // Menu
    "k228": [4, 7], // RCtrl
  };

  @override
  VialState build() {
    return VialState();
  }

  Future<void> connect() async {
    state = state.copyWith(statusMessage: "Connecting...");
    final deviceDef = myDevices.first;
    final success = await _service.connect(deviceDef);

    if (success) {
      state = state.copyWith(isConnected: true, statusMessage: "Connected to ${deviceDef.name}");
    } else {
      state = state.copyWith(isConnected: false, statusMessage: "Failed to connect");
    }
  }

  Future<void> disconnect() async {
    _service.disconnect();
    state = state.copyWith(isConnected: false, statusMessage: "Disconnected");
  }

  Future<void> updateKey(String keyId, String newLabel) async {
    if (!state.isConnected) {
      state = state.copyWith(statusMessage: "Not connected");
      return;
    }

    // Map label to basic QMK keycode
    final keycode = labelToKeycode(newLabel);
    if (keycode == 0 && newLabel != "No") {
       state = state.copyWith(statusMessage: "Unknown key label: $newLabel");
       return;
    }

    final matrixPos = keyIdToMatrix[keyId];
    if (matrixPos != null) {
        // Assume Layer 0 for now as the editor doesn't show layers yet
        final row = matrixPos[0];
        final col = matrixPos[1];
        try {
            await _service.setKey(0, row, col, keycode, 5, 14);

            final newMap = Map<String, String>.from(state.keyMappings);
            newMap[keyId] = newLabel;
            state = state.copyWith(
                keyMappings: newMap,
                statusMessage: "Updated $keyId to $newLabel"
            );
        } catch (e) {
            state = state.copyWith(statusMessage: "Failed to write: $e");
        }
    } else {
        state = state.copyWith(statusMessage: "Unknown physical position for $keyId");
    }
  }

  static int labelToKeycode(String label) {
    // Basic QMK Keycodes
    switch (label.toUpperCase()) {
        case "A": return 0x04;
        case "B": return 0x05;
        case "C": return 0x06;
        case "D": return 0x07;
        case "E": return 0x08;
        case "F": return 0x09;
        case "G": return 0x0A;
        case "H": return 0x0B;
        case "I": return 0x0C;
        case "J": return 0x0D;
        case "K": return 0x0E;
        case "L": return 0x0F;
        case "M": return 0x10;
        case "N": return 0x11;
        case "O": return 0x12;
        case "P": return 0x13;
        case "Q": return 0x14;
        case "R": return 0x15;
        case "S": return 0x16;
        case "T": return 0x17;
        case "U": return 0x18;
        case "V": return 0x19;
        case "W": return 0x1A;
        case "X": return 0x1B;
        case "Y": return 0x1C;
        case "Z": return 0x1D;

        case "1": return 0x1E;
        case "2": return 0x1F;
        case "3": return 0x20;
        case "4": return 0x21;
        case "5": return 0x22;
        case "6": return 0x23;
        case "7": return 0x24;
        case "8": return 0x25;
        case "9": return 0x26;
        case "0": return 0x27;

        case "ENTER": return 0x28;
        case "ESC": return 0x29;
        case "BKSP": return 0x2A;
        case "TAB": return 0x2B;
        case "SPACE": return 0x2C;

        case "-": return 0x2D;
        case "=": return 0x2E;
        case "[": return 0x2F;
        case "]": return 0x30;
        case "\\": return 0x31;

        case ";": return 0x33;
        case "'": return 0x34;
        case ",": return 0x36;
        case ".": return 0x37;
        case "/": return 0x38;

        case "CAPS": return 0x39;

        case "F1": return 0x3A;
        case "F2": return 0x3B;
        // ... add more as needed

        case "LCTRL": case "CTRL": return 0xE0;
        case "LSHIFT": case "SHIFT": return 0xE1;
        case "LALT": case "ALT": return 0xE2;
        case "LGUI": case "WIN": return 0xE3;
        case "RCTRL": return 0xE4;
        case "RSHIFT": return 0xE5;
        case "RALT": return 0xE6;
        case "RGUI": return 0xE7;

        default: return 0x00; // Unknown
    }
  }
}

final vialProvider = NotifierProvider<VialNotifier, VialState>(VialNotifier.new);
