// Dart imports:
import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';

// Package imports:
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

// win32パッケージに含まれていない場合のための型定義（念のため）
typedef CallNextHookExProc =
    LRESULT Function(Int32 nCode, WPARAM wParam, LPARAM lParam);

class KeyCodeEvent {
  final String vkCode;
  final String scanCode;

  KeyCodeEvent(this.vkCode, this.scanCode);

  @override
  String toString() {
    return 'VK: $vkCode, Scan: $scanCode';
  }
}

class KeyboardMonitor {
  Isolate? _isolate;
  ReceivePort? _receivePort;
  StreamSubscription? _subscription;

  final Function(KeyCodeEvent) onKeyDetected;

  KeyboardMonitor({required this.onKeyDetected});

  Future<void> start() async {
    if (_isolate != null) return;

    _receivePort = ReceivePort();

    _isolate = await Isolate.spawn(_isolateEnteyPoint, _receivePort!.sendPort);

    _subscription = _receivePort!.listen((message) {
      if (message is List<String>) {
        onKeyDetected(KeyCodeEvent(message[0], message[1]));
      }
    });
  }

  void stop() {
    _subscription?.cancel();
    _receivePort?.close();
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
  }

  static void _isolateEnteyPoint(SendPort sendPort) {
    int hookProc(int nCode, int wParam, int lParam) {
      if (nCode >= 0 && (wParam == WM_KEYDOWN || wParam == WM_SYSKEYDOWN)) {
        final kbdStruct = Pointer<KBDLLHOOKSTRUCT>.fromAddress(lParam).ref;

        final hexVk =
            "0x${kbdStruct.vkCode.toRadixString(16).padLeft(2, '0').toUpperCase()}";
        final hexScan =
            "0x${kbdStruct.scanCode.toRadixString(16).padLeft(2, '0').toUpperCase()}";

        sendPort.send([hexVk, hexScan]);
      }

      return CallNextHookEx(0, nCode, wParam, lParam);
    }

    final callback = NativeCallable<CallNextHookExProc>.isolateLocal(
      hookProc,
      exceptionalReturn: 0,
    );

    final hInstance = GetModuleHandle(nullptr);
    final hHook = SetWindowsHookEx(
      WH_KEYBOARD_LL,
      callback.nativeFunction,
      hInstance,
      0,
    );

    if (hHook == 0) {
      print("sethook 失敗");
      return;
    }

    final msg = calloc<MSG>();
    while (GetMessage(msg, 0, 0, 0) != 0) {
      TranslateMessage(msg);
      DispatchMessage(msg);
    }

    UnhookWindowsHookEx(hHook);
    calloc.free(msg);
  }
}
