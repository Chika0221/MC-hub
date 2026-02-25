// Dart imports:
import 'dart:async';
import 'dart:io';

// Package imports:
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/firebase_connect_stream_provider.dart';
import 'package:mc_hub/infrastructure/providers/keyboard_monitor_controller_provider.dart';

Future<void> shutdownApp(WidgetRef ref) async {
  try {
    ref.read(keyboardMonitorControllerProvider).stop();
  } catch (_) {}

  try {
    await ref.read(firebaseConnectStreamProvider.notifier).close();
  } catch (_) {}
}

Future<void> shutdownAndExit(WidgetRef ref) async {
  await shutdownApp(ref);
  appWindow.close();

  await Future<void>.delayed(const Duration(milliseconds: 50));

  exit(0);
}
