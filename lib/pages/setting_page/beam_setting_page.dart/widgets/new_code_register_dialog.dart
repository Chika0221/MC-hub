// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/firebase_unregistered_code_stream_provider.dart';
import 'package:mc_hub/models/unregistered_code.dart';
import 'package:mc_hub/pages/setting_page/beam_setting_page.dart/widgets/state_animation.dart';
import 'package:mc_hub/widgets/custom_full_page_dialog.dart';

class NewCodeRegisterDialog extends HookConsumerWidget {
  const NewCodeRegisterDialog({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);

    final currentStep = useState(0);

    final textController = useTextEditingController(text: "");

    final unregisteredCodeStream = ref.watch(
      firebaseUnregisterCodeStreamProvider,
    );

    ref.listen<AsyncValue<UnregisteredCode?>>(
      firebaseUnregisterCodeStreamProvider,
      (previous, next) {
        next.whenData((data) async {
          if (data != null && data.state == CodeRegisteredState.done) {
            await Future.delayed(const Duration(seconds: 1));
            Navigator.of(context).pop();
          }
        });
      },
    );

    return CustomFullPageDialog(
      child: Center(
        child: SizedBox(
          width: size.width / 2,
          height: size.height / 0.8,
          child: Stepper(
            currentStep: currentStep.value,
            onStepContinue: () {
              if (textController.text.isEmpty && currentStep.value == 0) {
                return;
              }
              currentStep.value += 1;
            },
            onStepCancel: () => currentStep.value -= 1,
            controlsBuilder: (context, details) {
              return Row(
                children: [
                  if (details.currentStep != 1)
                    FilledButton(
                      onPressed: details.onStepContinue,
                      child: const Text('次へ'),
                    ),
                  const SizedBox(width: 8),
                  if (details.currentStep != 0)
                    FilledButton.tonal(
                      onPressed: details.onStepCancel,
                      child: const Text('戻る'),
                    ),
                ],
              );
            },
            steps: [
              Step(
                stepStyle: StepStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  connectorColor: Theme.of(context).colorScheme.onSurface,
                ),
                title: Text("コードの名前の登録"),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 8),
                    TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(),
                        labelText: 'コード名を入力してください',
                      ),
                    ),
                    if (textController.text.isEmpty)
                      Text(
                        "コード名は必須です",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
              Step(
                title: Text("コードの登録"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 8),
                    unregisteredCodeStream.when(
                      data: (data) {
                        if (data == null) {
                          return SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed:
                                  () => ref
                                      .read(
                                        firebaseUnregisterCodeStreamProvider
                                            .notifier,
                                      )
                                      .setUnregisteredCode(
                                        UnregisteredCode(
                                          name: textController.text,
                                        ),
                                      ),
                              child: Text("リモコンのコードの検索を始める"),
                            ),
                          );
                        }
                        // return switch (data.state) {
                        //   CodeRegisteredState.reading => Text(
                        //     "リモコンからコードを送信してください: ${data.name}",
                        //   ),
                        //   CodeRegisteredState.done => Text(
                        //     "コードを受信しました: ${data.name}",
                        //   ),
                        //   CodeRegisteredState.error => Text(
                        //     "コードの受信に失敗しました。もう一度リモコンから送信してください: ${data.name}",
                        //   ),
                        //   null => Text("準備中..."),
                        // };
                        return StateAnimation(
                          state: data.state ?? CodeRegisteredState.none,
                        );
                      },
                      error: (error, stackTrace) {
                        return Text("エラーが発生しました: $error");
                      },
                      loading: () {
                        return CircularProgressIndicator();
                      },
                    ),
                    SizedBox(height: 8),
                  ],
                ),
                stepStyle: StepStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  connectorColor: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
