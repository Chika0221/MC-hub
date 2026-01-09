// Dart imports:
import 'dart:async';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/macro/app_preferences.dart';
import 'package:mc_hub/infrastructure/macro/run_macro.dart';
import 'package:mc_hub/models/macro.dart';

class MacrosNotifier extends AsyncNotifier<List<Macro?>> {
  @override
  FutureOr<List<Macro?>> build() async {
    return _fetchMacros();
  }

  Macro? getMacroByIndex(int index) {
    final macros = state.value;
    if (macros == null || index < 0 || index >= macros.length) {
      return null;
    }
    return macros[index];
  }

  Future<void> loadMacros() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchMacros);
  }

  Future<List<Macro?>> _fetchMacros() async {
    state = const AsyncLoading();
    final loadedMacros = <Macro?>[];
    for (final keycode in MonitorKeycodes.values) {
      loadedMacros.add(await AppPreferences.getMacro(keycode));
    }

    print("Loaded Macros: $loadedMacros");

    return loadedMacros;
  }

  Future<void> setMacro(String macroShortName, Macro macro) async {
    await AppPreferences.setMacro(macroShortName, macro);
    await loadMacros();
  }
}

final MacrosProvider =
    AsyncNotifierProvider.autoDispose<MacrosNotifier, List<Macro?>>(
      MacrosNotifier.new,
    );
