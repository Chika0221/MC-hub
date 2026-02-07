// Dart imports:
import 'dart:ffi';

// Package imports:
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

class KeySender {
  static void sendKeyPush(int vKCode) {
    final input = calloc<INPUT>();

    try {
      input.ref.type = INPUT_KEYBOARD;
      input.ref.ki.wVk = vKCode;
      input.ref.ki.dwFlags = 0;

      SendInput(1, input, sizeOf<INPUT>());

      input.ref.ki.dwFlags = KEYEVENTF_KEYUP;
      SendInput(1, input, sizeOf<INPUT>());
    } finally {
      calloc.free(input);
    }
  }

  static void sendMultiKeyPush(List<int> vKCodes, [bool isShortcut = false]) {
    if (vKCodes.isEmpty) return;

    final input = calloc<INPUT>();

    void send(int vKCode, int flags) {
      input.ref.type = INPUT_KEYBOARD;
      input.ref.ki
        ..wVk = vKCode
        ..wScan = 0
        ..dwFlags = flags
        ..time = 0
        ..dwExtraInfo = 0;

      SendInput(1, input, sizeOf<INPUT>());
    }

    try {
      // KeyDown: specified order
      for (final vKCode in vKCodes) {
        send(vKCode, 0);
      }

      if (isShortcut) {
        for (final vKCode in vKCodes.reversed) {
          send(vKCode, KEYEVENTF_KEYUP);
        }
      }
    } finally {
      calloc.free(input);
    }
  }
}
