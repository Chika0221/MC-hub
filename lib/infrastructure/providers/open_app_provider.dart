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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return getOpenApps();
    });
  }

  Future<List<Macro>> getOpenApps() async {
    final result = await Process.run('powershell', [
      'Get-ItemProperty',
      r'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*, HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*, HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayIcon | Where-Object {$_.DisplayName -ne $null -and $_.DisplayIcon -ne $null} | ConvertTo-Json',
    ]);

    final out = (result.stdout ?? "").toString();

    final List<dynamic> listJson = jsonDecode(out);

    final List<AppInfo> apps =
        listJson
            .map((e) => AppInfo.fromJson(e))
            .where((e) => !(e.DisplayIcon.contains(".ico")))
            .map((e) {
              String iconPath = e.DisplayIcon;
              if (iconPath.contains(',')) {
                iconPath = iconPath.split(',')[0];
              }
              return AppInfo(DisplayName: e.DisplayName, DisplayIcon: iconPath);
            })
            .toList();

    apps.sort((a, b) => a.DisplayName.compareTo(b.DisplayName));

    for (var app in apps) {
      print('${app.DisplayName} => ${app.DisplayIcon}');
    }
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
