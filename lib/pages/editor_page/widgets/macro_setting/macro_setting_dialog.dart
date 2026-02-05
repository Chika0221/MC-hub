// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/macro/run_macro.dart';
import 'package:mc_hub/infrastructure/providers/firebase_codes_stream_privider.dart';
import 'package:mc_hub/infrastructure/providers/open_app_provider.dart';
import 'package:mc_hub/models/macro.dart';
import 'package:mc_hub/pages/editor_page/widgets/macro_setting/macro_setting_container.dart';

class MacroSettingDialog extends HookConsumerWidget {
  const MacroSettingDialog({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final codeSelected = useState<int?>(null);
    final appSelected = useState<int?>(null);
    final comboSelected = useState<bool>(false);
    final aiSelected = useState<bool>(false);

    final aiPromptController = useTextEditingController();

    final returnMacro = useState<Macro?>(null);

    void selectCode(int index) {
      codeSelected.value = index;
      appSelected.value = null;
      comboSelected.value = false;
      aiSelected.value = false;
    }

    void selectApp(int index) {
      appSelected.value = index;
      codeSelected.value = null;
      comboSelected.value = false;
      aiSelected.value = false;
    }

    void selectCombo() {
      comboSelected.value = true;
      codeSelected.value = null;
      appSelected.value = null;
      aiSelected.value = false;
    }

    void selectAi() {
      aiSelected.value = true;
      codeSelected.value = null;
      appSelected.value = null;
      comboSelected.value = false;
    }

    return AlertDialog(
      title: Row(
        children: [
          Text(title),
          const Spacer(),
          FilledButton.tonalIcon(
            onPressed: () {
              MacroService.runMacroByKeycode(
                MonitorKeycodes.values.firstWhere((e) => e.shortName == title),
              );
            },
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text("テスト実行"),
          ),
        ],
      ),
      content: Container(
        constraints: BoxConstraints(
          minWidth: size.width * 0.5,
          minHeight: size.height * 0.5,
          maxWidth: double.maxFinite,
          maxHeight: double.maxFinite,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InfreadContainer(
                returnMacro: returnMacro,
                codeSelected: codeSelected,
                selectCode: selectCode,
              ),
              RunAppContainer(
                returnMacro: returnMacro,
                appSelected: appSelected,
                selectApp: selectApp,
              ),
              ComboContainer(
                returnMacro: returnMacro,
                selectCombo: selectCombo,
                comboSelected: comboSelected,
              ),
              AIContainer(
                aiSelected: aiSelected,
                selectAi: selectAi,
                aiPromptController: aiPromptController,
              ),
              // AIマクロ設定
            ],
          ),
        ),
      ),

      actions: [
        FilledButton.icon(
          onPressed: () {
            // AIが選択されている場合のみ、ここで保存する（入力中に毎回保存しない）
            if (aiSelected.value) {
              final order = aiPromptController.text.trim();
              if (order.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("AIへの指示（order）を入力してください")),
                );
                return;
              }
              returnMacro.value = Macro(
                name: order,
                type: MacroType.aiTextConvert,

                aiPrompt: order,
              );
            }
            Navigator.of(context).pop(returnMacro.value);
          },
          icon: const Icon(Icons.check_rounded),
          label: const Text("適応"),
        ),
        FilledButton.tonalIcon(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close_rounded),
          label: const Text("閉じる"),
        ),
      ],
    );
  }
}

class InfreadContainer extends HookConsumerWidget {
  const InfreadContainer({
    super.key,
    required this.returnMacro,
    required this.codeSelected,
    required this.selectCode,
  });

  final ValueNotifier<Macro?> returnMacro;
  final ValueNotifier<int?> codeSelected;
  final void Function(int index) selectCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final codesStream = ref.watch(firebaseCodesStreamProvider);

    return codesStream.when(
      data: (codes) {
        return MacroSettingContainer(
          title: "スマートリモコン操作",
          selected: codeSelected.value,
          onAttach: (index) async {
            selectCode(index);

            final docId = await ref
                .read(firebaseCodesStreamProvider.notifier)
                .getDocIdByName(codes[index].name);

            returnMacro.value = Macro(
              name: codes[index].name,
              type: MacroType.infrared,
              docId: docId,
            );

            if (docId == null) {
              return;
            }
          },
          itemCount: codes.length,
          builder: (index) {
            final code = codes[index];
            return MacroSelecterContainer(
              select: codeSelected.value == index,
              title: code.name,
              subtitle: code.code,
            );
          },
        );
      },
      error: (error, stackTrace) {
        return Text("エラーが発生しました: $error");
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }
}

class RunAppContainer extends HookConsumerWidget {
  const RunAppContainer({
    super.key,
    required this.returnMacro,
    required this.appSelected,
    required this.selectApp,
  });

  final ValueNotifier<Macro?> returnMacro;
  final ValueNotifier<int?> appSelected;
  final void Function(int index) selectApp;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runAppFuture = ref.watch(openAppProvider);

    return runAppFuture.when(
      data: (apps) {
        return MacroSettingContainer(
          title: "アプリ実行",
          selected: appSelected.value,
          onAttach: (index) {
            selectApp(index);
            returnMacro.value = apps[index];
          },
          itemCount: apps.length,
          builder: (index) {
            final app = apps[index];
            return MacroSelecterContainer(
              select: appSelected.value == index,
              title: app.name,
              subtitle: app.appPath,
            );
          },
        );
      },
      error: (error, stackTrace) {
        return Text("エラーが発生しました: $error");
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }
}

class AIContainer extends HookConsumerWidget {
  const AIContainer({
    super.key,
    required this.aiSelected,
    required this.selectAi,
    required this.aiPromptController,
  });

  final ValueNotifier<bool> aiSelected;
  final void Function() selectAi;
  final TextEditingController aiPromptController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "AIテキスト変換",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              FilterChip(
                selected: aiSelected.value,
                label: const Text("このキーに割り当てる"),
                onSelected: (value) {
                  if (value) {
                    selectAi();
                  } else {
                    aiSelected.value = false;
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "選択中のテキストAIで変換します",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: aiPromptController,
                  enabled: aiSelected.value,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: "AIへの指示",
                    hintText: "例: 敬語にして/要約して/箇条書きにして",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                  ),
                  onTap: () {
                    if (!aiSelected.value) {
                      selectAi();
                    }
                  },
                  onChanged: (_) {
                    if (!aiSelected.value) {
                      selectAi();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ComboContainer extends HookConsumerWidget {
  const ComboContainer({
    super.key,
    required this.selectCombo,
    required this.comboSelected,
    required this.returnMacro,
  });

  final ValueNotifier<Macro?> returnMacro;
  final void Function() selectCombo;
  final ValueNotifier<bool> comboSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isShortcut = useState<bool>(false);

    final textController = useTextEditingController();

    useEffect(() {
      textController.addListener(() {
        final newText = textController.text;

        returnMacro.value = Macro(
          name: newText,
          type: MacroType.text,
          text: newText,
        );
      });
      return () {
        textController.dispose();
      };
    }, []);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "コンボ",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              FilterChip(
                selected: isShortcut.value,
                label: const Text("ショートカット"),
                onSelected: (selected) => isShortcut.value = selected,
              ),
              const SizedBox(width: 4),
              FilterChip(
                selected: comboSelected.value,
                label: const Text("このキーに割り当てる"),
                onSelected: (value) {
                  if (value) {
                    selectCombo();
                  } else {
                    comboSelected.value = false;
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "複数キーを同時入力、またはテキストを入力します",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                const SizedBox(height: 8),
                (isShortcut.value)
                    ? Text(
                      "選択中: テキスト入力",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    )
                    : TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        labelText: "入力テキスト",
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
