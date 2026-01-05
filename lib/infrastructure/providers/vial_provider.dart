// Package imports:
import 'package:hid4flutter/hid4flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/hid/list_of_mydevices.dart';
import 'package:mc_hub/infrastructure/hid/vial_service%20copy.dart';
import 'package:mc_hub/models/vial_state.dart';

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
    return VialState(statusMessage: null, matrix: null);
  }

  Future<void> connect(HidDevice selectDevice) async {
    state = state.copyWith(statusMessage: "Connecting...");
    final deviceDef = myDevices.first;
    final success = await _service.connect(selectDevice);

    if (success) {
      state = state.copyWith(
        isConnected: true,
        // deviceName: _service.productName ?? deviceDef.name,
        deviceName: myDevices.first.name,
        statusMessage: "Connected to ${deviceDef.name}",
      );

      // Fetch Layout if we have config
      final config = deviceLayouts[deviceDef.name];
      if (config != null) {
        try {
          final keymap = await _service.getKeymap(
            layers: config.layers,
            rows: config.rows,
            cols: config.cols,
          );
          // Populate mappings for Layer 0
          final Map<String, String> initialMappings = {};
          if (keymap.isNotEmpty) {
            final layer0 = keymap[0];
            for (int r = 0; r < layer0.length; r++) {
              for (int c = 0; c < layer0[r].length; c++) {
                initialMappings["$r,$c"] = keycodeToLabel(layer0[r][c]);
              }
            }
          }

          state = state.copyWith(
            matrix: keymap,
            keyMappings: initialMappings,
            statusMessage: "Connected and loaded keymap",
          );
        } catch (e) {
          state = state.copyWith(
            statusMessage: "Connected but failed to load keymap: $e",
          );
        }
      }
    } else {
      state = state.copyWith(
        isConnected: false,
        statusMessage: "Failed to connect",
      );
    }
  }

  Future<void> disconnect() async {
    _service.disconnect();
    state = state.copyWith(
      isConnected: false,
      statusMessage: "Disconnected",
      matrix: null,
      keyMappings: {},
    );
  }

  Future<void> updateKey(int layer, String keyId, String newLabel) async {
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

    int row = -1;
    int col = -1;

    // Check if keyId is "row,col" format
    if (keyId.contains(',')) {
      final parts = keyId.split(',');
      if (parts.length == 2) {
        row = int.tryParse(parts[0]) ?? -1;
        col = int.tryParse(parts[1]) ?? -1;
      }
    } else {
      // Fallback to static map
      final matrixPos = keyIdToMatrix[keyId];
      if (matrixPos != null) {
        row = matrixPos[0];
        col = matrixPos[1];
      }
    }

    if (row != -1 && col != -1) {
      // Get dimensions from config
      final deviceDef = myDevices.first;
      final config = deviceLayouts[deviceDef.name];
      final rows = config?.rows ?? 4; // Default fallback
      final cols = config?.cols ?? 14;

      try {
        await _service.setKey(layer, row, col, keycode, rows, cols);

        final newMap = Map<String, String>.from(state.keyMappings);
        newMap[keyId] = newLabel;

        // Also update matrix in state if it exists
        List<List<List<int>>>? newMatrix = state.matrix;
        if (newMatrix != null && newMatrix.isNotEmpty) {
          // Deep copy needed? Or just update nested value if we treat state as immutable wrapper around mutable list content (risky but common in simple providers)
          // Proper way: copy structure.
          // For now, let's assume we re-fetch or just update the UI map.
          // Updating the matrix in memory:
          final safeLayer = layer.clamp(0, newMatrix.length - 1);
          newMatrix[safeLayer][row][col] = keycode;
        }

        state = state.copyWith(
          keyMappings: newMap,
          matrix: newMatrix,
          statusMessage: "Updated L$layer $keyId to $newLabel",
        );
      } catch (e) {
        state = state.copyWith(statusMessage: "Failed to write: $e");
      }
    } else {
      state = state.copyWith(
        statusMessage: "Unknown physical position for $keyId",
      );
    }
  }

  static String keycodeToLabel(int keycode) {
    // Simple reverse mapping.
    // Since labelToKeycode maps multiple strings to same int, this might be ambiguous (e.g. LSHIFT vs SHIFT).
    // We pick canonical names.
    switch (keycode) {
      case 0x400:
        return "A";
      case 0x500:
        return "B";
      case 0x600:
        return "C";
      case 0x700:
        return "D";
      case 0x800:
        return "E";
      case 0x900:
        return "F";
      case 0xA00:
        return "G";
      case 0xB00:
        return "H";
      case 0xC00:
        return "I";
      case 0xD00:
        return "J";
      case 0xE00:
        return "K";
      case 0xF00:
        return "L";
      case 0x1000:
        return "M";
      case 0x1100:
        return "N";
      case 0x1200:
        return "O";
      case 0x1300:
        return "P";
      case 0x1400:
        return "Q";
      case 0x1500:
        return "R";
      case 0x1600:
        return "S";
      case 0x1700:
        return "T";
      case 0x1800:
        return "U";
      case 0x1900:
        return "V";
      case 0x1A00:
        return "W";
      case 0x1B00:
        return "X";
      case 0x1C00:
        return "Y";
      case 0x1D00:
        return "Z";

      case 0x5900:
        return "1";
      case 0x5A00:
        return "2";
      case 0x5B00:
        return "3";
      case 0x5C00:
        return "4";
      case 0x5D00:
        return "5";
      case 0x5E00:
        return "6";
      case 0x5F00:
        return "7";
      case 0x6000:
        return "8";
      case 0x6100:
        return "9";
      case 0x6200:
        return "0";

      case 0x2800:
        return "Enter";
      case 0x2900:
        return "Esc";
      case 0x2A00:
        return "Bksp";
      case 0x2B00:
        return "Tab";
      case 0x2C00:
        return "Space";

      case 0x2D00:
        return "-";
      case 0x2E00:
        return "=";
      case 0x2F00:
        return "[";
      case 0x3000:
        return "]";
      case 0x3100:
        return "\\";

      case 0x3300:
        return ";";
      case 0x3400:
        return "'";
      case 0x3500:
        return "`";
      case 0x3600:
        return ",";
      case 0x3700:
        return ".";
      case 0x3800:
        return "/";

      case 0x3A00:
        return "F1";
      case 0x3B00:
        return "F2";
      case 0x3C00:
        return "F3";
      case 0x3D00:
        return "F4";
      case 0x3E00:
        return "F5";
      case 0x3F00:
        return "F6";
      case 0x4000:
        return "F7";
      case 0x4100:
        return "F8";
      case 0x4200:
        return "F9";
      case 0x4300:
        return "F10";
      case 0x4400:
        return "F11";
      case 0x4500:
        return "F12";

      case 0xE000:
        return "LCtrl";
      case 0xE100:
        return "LShift";
      case 0xE200:
        return "LAlt";
      case 0xE300:
        return "Win";
      case 0xE400:
        return "RCtrl";
      case 0xE500:
        return "RShift";
      case 0xE600:
        return "RAlt";
      case 0xE700:
        return "RWin";
      case 0x4A00:
        return "Home";
      case 0x4B00:
        return "PgUp";
      case 0x4D00:
        return "End";
      case 0x4E00:
        return "PgDn";
      case 0x4F00:
        return "→";
      case 0x5000:
        return "←";
      case 0x5100:
        return "↓";
      case 0x5200:
        return "↑";

      case 0x1E02:
        return "!";
      case 0x1F02:
        return "@";
      case 0x2002:
        return "#";
      case 0x2102:
        return "\$";
      case 0x2202:
        return "%";
      case 0x2302:
        return "^";
      case 0x2402:
        return "&";
      case 0x2502:
        return "*";
      case 0x2602:
        return "(";
      case 0x2702:
        return ")";
      case 0x2D02:
        return "_";

      case 0x100:
        return "◯";

      default:
        return "0x${keycode.toRadixString(16).toUpperCase()}";
    }
  }

  static int labelToKeycode(String label) {
    // Basic QMK Keycodes
    switch (label.toUpperCase()) {
      case "A":
        return 0x4;
      case "B":
        return 0x5;
      case "C":
        return 0x6;
      case "D":
        return 0x7;
      case "E":
        return 0x8;
      case "F":
        return 0x9;
      case "G":
        return 0xA;
      case "H":
        return 0xB;
      case "I":
        return 0xC;
      case "J":
        return 0xD;
      case "K":
        return 0xE;
      case "L":
        return 0xF;
      case "M":
        return 0x10;
      case "N":
        return 0x11;
      case "O":
        return 0x12;
      case "P":
        return 0x13;
      case "Q":
        return 0x14;
      case "R":
        return 0x15;
      case "S":
        return 0x16;
      case "T":
        return 0x17;
      case "U":
        return 0x18;
      case "V":
        return 0x19;
      case "W":
        return 0x1A;
      case "X":
        return 0x1B;
      case "Y":
        return 0x1C;
      case "Z":
        return 0x1D;

      case "1":
        return 0x1E;
      case "2":
        return 0x1F;
      case "3":
        return 0x20;
      case "4":
        return 0x21;
      case "5":
        return 0x22;
      case "6":
        return 0x23;
      case "7":
        return 0x24;
      case "8":
        return 0x25;
      case "9":
        return 0x26;
      case "0":
        return 0x27;

      case "ENTER":
        return 0x28;
      case "ESC":
        return 0x29;
      case "BKSP":
        return 0x2A;
      case "TAB":
        return 0x2B;
      case "SPACE":
        return 0x2C;

      case "-":
        return 0x2D;
      case "=":
        return 0x2E;
      case "[":
        return 0x2F;
      case "]":
        return 0x30;
      case "\\":
        return 0x31;

      case ";":
        return 0x33;
      case "'":
        return 0x34;
      case ",":
        return 0x36;
      case ".":
        return 0x37;
      case "/":
        return 0x38;

      case "CAPS":
        return 0x39;

      case "F1":
        return 0x3A;
      case "F2":
        return 0x3B;
      // ... add more as needed

      case "LCTRL":
      case "CTRL":
        return 0xE0;
      case "LSHIFT":
      case "SHIFT":
        return 0xE1;
      case "LALT":
      case "ALT":
        return 0xE2;
      case "LGUI":
      case "WIN":
        return 0xE3;
      case "RCTRL":
        return 0xE4;
      case "RSHIFT":
        return 0xE5;
      case "RALT":
        return 0xE6;
      case "RGUI":
        return 0xE7;

      default:
        return 0x0; // Unknown
    }
  }
}

final vialProvider = NotifierProvider<VialNotifier, VialState>(
  VialNotifier.new,
);
