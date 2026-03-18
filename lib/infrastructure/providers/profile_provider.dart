// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import 'package:mc_hub/infrastructure/fileIO.dart/file_service.dart';
import 'package:mc_hub/infrastructure/providers/vial_provider.dart';
import 'package:mc_hub/models/key_profile.dart';

class ProfilesAsyncNotifier extends AsyncNotifier<List<KeyProfile?>> {
  final asyncPrefs = SharedPreferencesAsync();

  @override
  FutureOr<List<KeyProfile?>> build() {
    return _fetchProfiles();
  }

  Future<void> fetchProfiles() async {
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

  Future<void> _saveProfile(KeyProfile profile) async {
    final key = "profile_${profile.id}";
    final value = jsonEncode(profile.toJson());
    await asyncPrefs.setString(key, value);
    await fetchProfiles();
  }

  Future<void> createProfile(String name) async {
    final uuid = Uuid().v4();

    final keyMatrix = ref.read(vialProvider.select((vial) => vial.matrix));

    final newProfile = KeyProfile(name: name, id: uuid, keyMatrix: keyMatrix);
    await _saveProfile(newProfile);
  }

  Future<void> updateProfile(KeyProfile profile) async {
    await _saveProfile(profile);
  }

  Future<void> inputProfile() async {
    final profileJson = await FileService.loadjsonFile();
    if (profileJson == null) return;

    final importProfile = KeyProfile.fromJson(profileJson);

    await _saveProfile(importProfile);
  }
}

final profilesAsyncNotifierProvider =
    AsyncNotifierProvider<ProfilesAsyncNotifier, List<KeyProfile?>>(
      ProfilesAsyncNotifier.new,
    );

final profilesProvider = Provider<List<KeyProfile?>>((ref) {
  final asyncValue = ref.watch(profilesAsyncNotifierProvider);
  return asyncValue.when(
    data: (data) {
      return data;
    },
    error: (error, stackTrace) {
      debugPrint("Error loading profiles: $error");
      return [];
    },
    loading: () => [],
  );
});

class SelectProfileNotifier extends Notifier<KeyProfile?> {
  final prefs = SharedPreferencesAsync();

  @override
  KeyProfile? build() {
    unawaited(_loadSelectedProfile());
    return null;
  }

  Future<void> selectProfile(KeyProfile profile) async {
    state = profile;
    final keyMatrix = profile.keyMatrix;

    if (keyMatrix != null) {
      await ref.read(vialProvider.notifier).updateKeyMatrix(keyMatrix);
    }
    await updateSelectProfilePrefarences(profile);
  }

  Future<void> _loadSelectedProfile() async {
    final selectedProfileId = prefs.getString("select_profile_id");

    final profiles = ref.read(profilesProvider);
    final selectedProfile = profiles.firstWhere(
      (profile) => profile?.id == selectedProfileId,
      orElse: () => null,
    );
    state = selectedProfile;
  }

  Future<void> updateSelectProfilePrefarences(KeyProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("select_profile_id", profile.id);
  }
}

final selectProfileProvider =
    NotifierProvider<SelectProfileNotifier, KeyProfile?>(
      SelectProfileNotifier.new,
    );
