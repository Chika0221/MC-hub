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
    return HasLastChildListview(
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
    );
  }
}
