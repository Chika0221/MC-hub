// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/hooks/keyboard_hooks.dart';
import 'package:mc_hub/infrastructure/macro/run_macro.dart';

final keyboardMonitorControllerProvider = Provider<KeyboardMonitorController>((
  ref,
) {
  final controller = KeyboardMonitorController();
  ref.onDispose(controller.stop);
  return controller;
});

class KeyboardMonitorController {
  KeyboardMonitorController();

  KeyboardMonitor? _monitor;
  bool _startingOrStarted = false;

  bool get isRunning => _monitor != null;

  Future<void> start() async {
    if (kDebugMode) {
      return;
    }
    if (_startingOrStarted) {
      return;
    }
    _startingOrStarted = true;

    final monitor = KeyboardMonitor(
      onKeyDetected: (event) {
        final log =
            "0x${event.vkCode.toRadixString(16).padLeft(2, '0').toUpperCase()} SCAN: ${event.scanCode}";
        // Keep the existing behavior.
        // ignore: avoid_print
        print(log);

        final vkCode = event.vkCode;
        if (MonitorKeycodes.macro1.vkCode <= vkCode &&
            vkCode <= MonitorKeycodes.macro12.vkCode) {
          MacroService.runMacroByKeycode(
            MonitorKeycodes.values.firstWhere((kc) => kc.vkCode == vkCode),
          );
        }
      },
    );

    _monitor = monitor;
    try {
      await monitor.start();
    } catch (_) {
      _monitor = null;
      _startingOrStarted = false;
      rethrow;
    }
  }

  void stop() {
    _monitor?.stop();
    _monitor = null;
    _startingOrStarted = false;
  }
}
