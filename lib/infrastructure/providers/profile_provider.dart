// Dart imports:
import 'dart:async';
import 'dart:convert';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:mc_hub/infrastructure/macro/app_preferences.dart';
import 'package:mc_hub/models/key_profile.dart';

class ProfilesAsyncNotifier extends AsyncNotifier<List<KeyProfile?>> {
  final asyncPrefs = SharedPreferencesAsync();

  @override
  FutureOr<List<KeyProfile?>> build() {
    return _fetchProfiles();
  }

  Future<void> fetchProfiles() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchProfiles);
  }

  Future<List<KeyProfile?>> _fetchProfiles() async {
    state = const AsyncLoading();
    final loadedProfile = <KeyProfile?>[];

    final allPreferences = await asyncPrefs.getAll();

    allPreferences.forEach((key, value) {
      if (key.startsWith("profile_")) {
        final decodedValue = jsonDecode(value as String);
        final profile = KeyProfile.fromJson(decodedValue);
        loadedProfile.add(profile);
      }
    });

    return loadedProfile;
  }
}
