// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/pages/beam_setting_page.dart/widgets/beam_item_grid_view.dart';
import 'package:mc_hub/widgets/custom_appbar.dart';
import 'package:mc_hub/widgets/folder_border_containar.dart';

class BeamSettingPage extends HookConsumerWidget {
  const BeamSettingPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppbar(isShowTitle: false).build(context, ref),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            FolderBorderContainar(
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              title: "コード一覧",
              child: BeamItemGridView(
                childrenAspectRatio: 1,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    width: double.infinity,
                    color: Theme.of(context).colorScheme.primary,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
