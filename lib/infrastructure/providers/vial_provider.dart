// Package imports:
import 'package:hid4flutter/hid4flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/hid/list_of_mydevices.dart';
import 'package:mc_hub/infrastructure/hid/vial_service.dart';
import 'package:mc_hub/models/vial_state.dart';

enum VialKey {
  no(0x0000, 'No'),

  // Letters
  a(0x0400, 'A'),
  b(0x0500, 'B'),
  c(0x0600, 'C'),
  d(0x0700, 'D'),
  e(0x0800, 'E'),
  f(0x0900, 'F'),
  g(0x0A00, 'G'),
  h(0x0B00, 'H'),
  i(0x0C00, 'I'),
  j(0x0D00, 'J'),
  k(0x0E00, 'K'),
  l(0x0F00, 'L'),
  m(0x1000, 'M'),
  n(0x1100, 'N'),
  o(0x1200, 'O'),
  p(0x1300, 'P'),
  q(0x1400, 'Q'),
  r(0x1500, 'R'),
  s(0x1600, 'S'),
  t(0x1700, 'T'),
  u(0x1800, 'U'),
  v(0x1900, 'V'),
  w(0x1A00, 'W'),
  x(0x1B00, 'X'),
  y(0x1C00, 'Y'),
  z(0x1D00, 'Z'),

  // Digits
  digit1(0x5900, '1'),
  digit2(0x5A00, '2'),
  digit3(0x5B00, '3'),
  digit4(0x5C00, '4'),
  digit5(0x5D00, '5'),
  digit6(0x5E00, '6'),
  digit7(0x5F00, '7'),
  digit8(0x6000, '8'),
  digit9(0x6100, '9'),
  digit0(0x6200, '0'),

  // Basic keys
  enter(0x2800, 'Enter'),
  esc(0x2900, 'Esc'),
  bksp(0x2A00, 'Bksp'),
  tab(0x2B00, 'Tab'),
  space(0x2C00, 'Space'),
  minus(0x2D00, '-'),
  equal(0x2E00, '='),
  lbracket(0x2F00, '['),
  rbracket(0x3000, ']'),
  backslash(0x3100, '\\'),
  semicolon(0x3300, ';'),
  quote(0x3400, "'"),
  grave(0x3500, '`'),
  comma(0x3600, ','),
  dot(0x3700, '.'),
  slash(0x3800, '/'),
  caps(0x3900, 'Caps'),

  // Shifted symbols (project-specific representation)
  exclam(0x1E02, '!'),
  at(0x1F02, '@'),
  hash(0x2002, '#'),
  dollar(0x2102, r'$'),
  percent(0x2202, '%'),
  caret(0x2302, '^'),
  amp(0x2402, '&'),
  asterisk(0x2502, '*'),
  lparen(0x2602, '('),
  rparen(0x2702, ')'),
  underscore(0x2D02, '_'),

  // Function keys
  f1(0x3A00, 'F1'),
  f2(0x3B00, 'F2'),
  f3(0x3C00, 'F3'),
  f4(0x3D00, 'F4'),
  f5(0x3E00, 'F5'),
  f6(0x3F00, 'F6'),
  f7(0x4000, 'F7'),
  f8(0x4100, 'F8'),
  f9(0x4200, 'F9'),
  f10(0x4300, 'F10'),
  f11(0x4400, 'F11'),
  f12(0x4500, 'F12'),

  // Modifiers
  lctrl(0xE000, 'LCtrl'),
  lshift(0xE100, 'LShift'),
  lalt(0xE200, 'LAlt'),
  win(0xE300, 'Win'),
  rctrl(0xE400, 'RCtrl'),
  rshift(0xE500, 'RShift'),
  ralt(0xE600, 'RAlt'),
  rwin(0xE700, 'RWin'),

  // Navigation
  home(0x4A00, 'Home'),
  pgup(0x4B00, 'PgUp'),
  end(0x4D00, 'End'),
  pgdn(0x4E00, 'PgDn'),
  right(0x4F00, '→'),
  left(0x5000, '←'),
  down(0x5100, '↓'),
  up(0x5200, '↑'),

  // Macros
  m1(0x6800, 'M1'),
  m2(0x6900, 'M2'),
  m3(0x6A00, 'M3'),
  m4(0x6B00, 'M4'),
  m5(0x6C00, 'M5'),
  m6(0x6D00, 'M6'),
  m7(0x6E00, 'M7'),
  m8(0x6F00, 'M8'),
  m9(0x7000, 'M9'),
  m10(0x7100, 'M10'),
  m11(0x7200, 'M11'),
  m12(0x7300, 'M12'),

  layer0(0x2052, 'L0'),
  layer1(0x2152, 'L1'),
  layer2(0x2252, 'L2'),
  layer3(0x2352, 'L3'),

  circle(0x0100, '◯');

  const VialKey(this.code, this.label);

  final int code;
  final String label;

  static final Map<int, VialKey> _byCode = {for (final v in values) v.code: v};
  static final Map<String, VialKey> _byLabel = {
    for (final v in values) _normalizeLabel(v.label): v,
  };

  static bool isNoLabel(String label) {
    return _normalizeLabel(label) == 'NO';
  }

  static VialKey? fromCode(int code) {
    return _byCode[code];
  }

  static String labelFromCode(int code) {
    final hit = fromCode(code);
    if (hit != null) return hit.label;
    return '0x${code.toRadixString(16).toUpperCase()}';
  }

  static VialKey? fromLabel(String label) {
    final normalized = _normalizeLabel(label);
    if (normalized.isEmpty) return no;

    // Also allow matching by upper-cased canonical label (e.g. Esc/Enter)
    return _byLabel[normalized];
  }

  static String _normalizeLabel(String label) {
    return label.trim().toUpperCase();
  }

  static List<String> basicLabels() {
    return values
        .sublist(VialKey.a.index, VialKey.m1.index)
        .map((e) => e.label)
        .toList();
  }

  static List<String> macroLabels() {
    return values
        .sublist(VialKey.m1.index, VialKey.layer0.index)
        .map((e) => e.label)
        .toList();
  }

  static List<String> layerLabels() {
    return values
        .sublist(VialKey.layer0.index, VialKey.circle.index)
        .map((e) => e.label)
        .toList();
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
    return VialState(statusMessage: null, matrix: null);
  }

  Future<void> connect(HidDevice selectDevice) async {
    state = state.copyWith(statusMessage: "Connecting...");

    final deviceDef = myDevices.firstWhere(
      (d) =>
          d.vendorId == selectDevice.vendorId &&
          d.productId == selectDevice.productId,
      orElse: () => myDevices.first,
    );

    final success = await _service.connect(selectDevice);

    if (success) {
      state = state.copyWith(
        isConnected: true,
        // deviceName: _service.productName ?? deviceDef.name,
        deviceName: deviceDef.name,
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
    if (keycode == 0 && !VialKey.isNoLabel(newLabel)) {
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
      final deviceDef = myDevices.firstWhere(
        (d) => d.name == state.deviceName,
        orElse: () => myDevices.first,
      );
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
    return VialKey.labelFromCode(keycode);
  }

  static int labelToKeycode(String label) {
    final hit = VialKey.fromLabel(label);
    return hit?.code ?? 0x0000;
  }
}

final vialProvider = NotifierProvider<VialNotifier, VialState>(
  VialNotifier.new,
);
