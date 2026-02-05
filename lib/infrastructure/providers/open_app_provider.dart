// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/models/app_info.dart';
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
    final result = await Process.run('powershell', [
      '-Command',
      '@(Get-StartApps) | Select-Object Name, AppID | ConvertTo-Json',
    ]);

    final out = (result.stdout ?? "").toString();

    final List<dynamic> listJson = jsonDecode(out);

    final List<AppInfo> apps =
        listJson.map((e) {
          final name = e['Name'] as String;
          final appId = e['AppID'] as String;
          return AppInfo(
            DisplayName: name,
            DisplayIcon: 'shell:AppsFolder\\$appId',
          );
        }).toList();

    apps.sort((a, b) => a.DisplayName.compareTo(b.DisplayName));

    apps.forEach((app) {
      print('${app.DisplayName} => ${app.DisplayIcon}');
    });
    print(apps.length);

    final macros =
        apps.map((app) {
          return Macro(
            name: app.DisplayName,
            type: MacroType.openApp,
            appPath: app.DisplayIcon,
          );
        }).toList();

    // final windowList = await WindowWatcher.getWindows(getExe: true);
    // final macros =
    //     windowList.map((window) {
    //       // final appName = window.exePath?.split('\\').last.split('.').first;
    //       final appName = window.title.split(' - ').last;

    //       return Macro(
    //         name: appName ?? 'Unknown App',
    //         type: MacroType.openApp,
    //         appPath: window.exePath,
    //       );
    //     }).toList();

    return macros;
  }
}

final openAppProvider =
    AsyncNotifierProvider.autoDispose<OpenAppNotifier, List<Macro>>(
      OpenAppNotifier.new,
    );
