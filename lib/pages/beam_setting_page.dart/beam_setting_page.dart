// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rive/rive.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/firebase_codes_stream_privider.dart';
import 'package:mc_hub/pages/beam_setting_page.dart/widgets/beam_item_grid_view.dart';
import 'package:mc_hub/pages/beam_setting_page.dart/widgets/code_container.dart';
import 'package:mc_hub/pages/beam_setting_page.dart/widgets/new_code_register_dialog.dart';
import 'package:mc_hub/widgets/custom_appbar.dart';
import 'package:mc_hub/widgets/custom_background.dart';
import 'package:mc_hub/widgets/custom_rive_animation.dart';
import 'package:mc_hub/widgets/folder_border_containar.dart';

class BeamSettingPage extends HookConsumerWidget {
  const BeamSettingPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomBackground(
      byRail: true,
      backGroundWidget: CustomRiveAnimation(
        size: Size.infinite,
        fileLoader: FileLoader.fromAsset(
          "assets/animations/background.riv",
          riveFactory: Factory.rive,
        ),
        fit: Fit.scaleDown,
      ),
      foragroundWidget: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppbar(),
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
              BeamSendingContainer(),
            ],
          ),
        ),
      ),
    );
  }
}

class BeamSendingContainer extends HookConsumerWidget {
  const BeamSendingContainer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final codesAsyncValue = ref.watch(firebaseCodesStreamProvider);

    return codesAsyncValue.when(
      data: (infraredCodes) {
        return FolderBorderContainar(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          title: "コード一覧",
          floatingActionButton: FloatingActionButton.extended(
            onPressed:
                () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NewCodeRegisterDialog();
                  },
                ),
            label: Text("登録"),
            icon: Icon(Icons.add),
            elevation: 0,
          ),
          child: BeamItemGridView(
            childrenAspectRatio: 5,
            itemCount: infraredCodes.length,
            itemBuilder: (context, index) {
              return CodeContainer(
                code: infraredCodes[index],
                onPressed: () async {
                  await ref
                      .read(firebaseCodesStreamProvider.notifier)
                      .updateCodes(infraredCodes[index].copyWith(state: true));
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
    );
  }
}
