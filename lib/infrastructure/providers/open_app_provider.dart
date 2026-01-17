// Dart imports:
import 'dart:async';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:window_watcher/window_watcher.dart';

// Project imports:
import 'package:mc_hub/models/macro.dart';

class OpenAppNotifier extends AsyncNotifier<List<Macro>> {
  @override
  FutureOr<List<Macro>> build() {
    return getOpenApps();
  }

  void fetch() async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return getOpenApps();
    });
  }

  Future<List<Macro>> getOpenApps() async {
    final windowList = await WindowWatcher.getWindows(getExe: true);
    final macros =
        windowList.map((window) {
          // final appName = window.exePath?.split('\\').last.split('.').first;
          final appName = window.title.split(' - ').last;

          return Macro(
            name: appName ?? 'Unknown App',
            type: MacroType.openApp,
            appPath: window.exePath,
          );
        }).toList();

    return macros;
  }
}

final openAppProvider =
    AsyncNotifierProvider.autoDispose<OpenAppNotifier, List<Macro>>(
      OpenAppNotifier.new,
    );
