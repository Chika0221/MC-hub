// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/fileIO.dart/file_service.dart';
import 'package:mc_hub/infrastructure/providers/profile_provider.dart';
import 'package:mc_hub/pages/editor_page/widgets/layer/new_profile_dialog.dart';
import 'package:mc_hub/widgets/has_last_child_listview.dart';

class ProfileSelecter extends HookConsumerWidget {
  const ProfileSelecter({super.key});

  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final profiles = ref.watch(profilesProvider);
    final selectedProfile = ref.watch(selectProfileProvider);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                selectedProfile?.name ?? "Profile",
                style: textTheme.headlineLarge?.copyWith(
                  color: colorScheme.primary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 4),
            IconButton.filledTonal(
              onPressed: () async {
                if (selectedProfile == null) return;
                FileService.saveJsonFile(
                  "profile_${selectedProfile.id}",
                  selectedProfile.toJson(),
                );
              },
              icon: Icon(Icons.file_upload_rounded),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: HasLastChildListView(
            itemBuilder: (context, index) {
              final profile = profiles[index];

              // return SizedBox(
              //   width: double.infinity,
              //   child: FilledButton.tonal(
              //     onPressed: () {
              //       if (profile != null) {
              //         ref
              //             .read(selectProfileProvider.notifier)
              //             .selectProfile(profile);
              //       }
              //     },
              //     child: Text(profile?.name ?? "UnKnown"),
              //   ),
              // );
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  title: Text(
                    profile?.name ?? "UnKnown",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  onTap: () {
                    if (profile != null) {
                      ref
                          .read(selectProfileProvider.notifier)
                          .selectProfile(profile);
                    }
                  },
                  trailing:
                      profile == selectedProfile
                          ? IconButton(
                            onPressed: () async {
                              if (profile == null) return;
                              await ref
                                  .read(profilesAsyncNotifierProvider.notifier)
                                  .updateProfile(profile);
                            },
                            icon: Icon(
                              Icons.save_rounded,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                          : null,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 8);
            },
            itemCount: profiles.length,
            lastChild: FilledButton(
              onPressed: () => NewProfileDialog.show(context),
              child: Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}
