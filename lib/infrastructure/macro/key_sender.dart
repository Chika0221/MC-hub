// Package imports:

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
    final input = calloc<INPUT>();

    try {
      for (final vKCode in vKCodes) {
        input.ref.type = INPUT_KEYBOARD;
        input.ref.ki.wVk = vKCode;
        input.ref.ki.dwFlags = 0;

        SendInput(1, input, sizeOf<INPUT>());
      }

      if (isShortcut)
        for (final vKCode in vKCodes.reversed) {
          input.ref.ki.wVk = vKCode;
          input.ref.ki.dwFlags = KEYEVENTF_KEYUP;

          SendInput(1, input, sizeOf<INPUT>());
        }
    } finally {
      calloc.free(input);
    }
  }
}
