// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/widgets/custom_appbar.dart';

class NewCodeRegisterDialog extends HookConsumerWidget {
  const NewCodeRegisterDialog({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    const sizePadding = 8.0;

    final currentStep = useState(0);

    return SimpleDialog(
      title: CustomAppbar(isShowTitle: false),
      insetPadding: const EdgeInsets.all(sizePadding),
      children: [
        SizedBox(
          width: size.width,
          height: size.height,
          child: Center(
            child: SizedBox(
              width: size.width / 2,
              height: size.height / 0.8,
              child: Stepper(
                currentStep: currentStep.value,
                onStepContinue: () => currentStep.value += 1,
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(),
                            labelText: 'コード名を入力してください',
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  Step(
                    title: Text("コードの登録"),
                    content: Container(
                      height: 200,
                      width: double.infinity,
                      child: Center(
                        child: Image.asset("assets/icons/app_icon.png"),
                      ),
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
        ),
      ],
    );
  }
}

void showNewCodeRegisterDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return NewCodeRegisterDialog();
    },
  );
}
