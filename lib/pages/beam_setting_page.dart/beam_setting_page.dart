// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/pages/beam_setting_page.dart/widgets/beam_item_list_view.dart';
import 'package:mc_hub/widgets/custom_appbar.dart';

class BeamSettingPage extends HookConsumerWidget {
  const BeamSettingPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppbar(isShowTitle: false).build(context, ref),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          spacing: 16,
          children: [
            BeamItemListView(
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
            BeamItemListView(
              backgroundColor: Theme.of(
                context,
              ).colorScheme.tertiary.withAlpha((255 * 2 / 3).toInt()),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.primary,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
