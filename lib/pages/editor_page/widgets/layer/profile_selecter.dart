// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/widgets/has_last_child_listview.dart';

class ProfileSelecter extends HookConsumerWidget {
  const ProfileSelecter({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(
          children: [
            Text(
              "Profile",
              style: textTheme.headlineLarge?.copyWith(
                color: colorScheme.primary,
              ),
            ),
            const Spacer(),
            IconButton.filledTonal(
              onPressed: () {},
              icon: Icon(Icons.file_upload_rounded),
            ),
            const SizedBox(width: 4),
            IconButton.filledTonal(
              onPressed: () {},
              icon: Icon(Icons.file_upload_rounded),
            ),
          ],
        ),
        Expanded(
          child: HasLastChildListView(
            itemBuilder: (context, index) {
              return SizedBox(
                width: double.infinity,
                child: FilledButton.tonal(
                  onPressed: () {},
                  child: Text("Profile $index"),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 8);
            },
            itemCount: 20,
            lastChild: FilledButton(onPressed: () {}, child: Text("aa")),
          ),
        ),
      ],
    );
  }
}
