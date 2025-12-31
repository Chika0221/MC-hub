// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/firebase_codes_stream_privider.dart';
import 'package:mc_hub/models/infrared_code.dart';
import 'package:mc_hub/pages/beam_setting_page.dart/widgets/beam_item_grid_view.dart';
import 'package:mc_hub/pages/beam_setting_page.dart/widgets/code_container.dart';
import 'package:mc_hub/widgets/custom_appbar.dart';
import 'package:mc_hub/widgets/folder_border_containar.dart';

class BeamSettingPage extends HookConsumerWidget {
  const BeamSettingPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final codesAsyncValue = ref.watch(firebaseCodesStreamProvider);

    return Scaffold(
      appBar: CustomAppbar(isShowTitle: false).build(context, ref),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    "リモコン一覧",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
            ),
            codesAsyncValue.when(
              data: (infraredCodes) {
                return FolderBorderContainar(
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  title: "コード一覧",
                  child: BeamItemGridView(
                    childrenAspectRatio: 5,
                    itemCount: infraredCodes.length,
                    itemBuilder: (context, index) {
                      return CodeContainer(
                        code: infraredCodes[index],
                        onPressed: () {
                          ref
                              .read(firebaseCodesStreamProvider.notifier)
                              .updateCodes(
                                infraredCodes[index].copyWith(state: true),
                              );
                        },
                      );
                    },
                  ),
                );
              },
              error: (error, stackTrace) {
                return Center(child: Text("エラーが発生 $error"));
              },
              loading: () {
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
