// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/macro/run_macro.dart';
import 'package:mc_hub/infrastructure/providers/firebase_codes_stream_privider.dart';
import 'package:mc_hub/infrastructure/providers/macros_provider.dart';
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
    final comboSelected = useState<int?>(null);
    final aiSelected = useState<bool>(false);

    final aiPromptController = useTextEditingController();

    void selectCode(int index) {
      codeSelected.value = index;
      appSelected.value = null;
      comboSelected.value = null;
      aiSelected.value = false;
    }

    void selectApp(int index) {
      appSelected.value = index;
      codeSelected.value = null;
      comboSelected.value = null;
      aiSelected.value = false;
    }

    void selectCombo(int index) {
      comboSelected.value = index;
      codeSelected.value = null;
      appSelected.value = null;
      aiSelected.value = false;
    }

    void selectAi() {
      aiSelected.value = true;
      codeSelected.value = null;
      appSelected.value = null;
      comboSelected.value = null;
    }

    void setMacroByType(Macro macro) async {
      final setMacro = macro.copyWith(
        name: "${macro.type.displayName}: ${macro.name}",
      );

      ref.read(MacrosProvider.notifier).setMacro(title, setMacro);
    }

    final codesStream = ref.watch(firebaseCodesStreamProvider);

    final runAppFuture = ref.watch(openAppProvider);

    return AlertDialog(
      title: Row(
        children: [
          Text(title),
          Spacer(),
          OutlinedButton.icon(
            onPressed: () {
              MacroService(
                keycode: MonitorKeycodes.values.firstWhere(
                  (e) => e.shortName == title,
                ),
              ).runMacro();
            },
            icon: Icon(Icons.play_arrow_rounded),
            label: Text("テスト実行"),
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
              codesStream.when(
                data: (codes) {
                  return MacroSettingContainer(
                    title: "スマートリモコン操作",
                    selected: codeSelected.value,
                    onAttach: (index) async {
                      selectCode(index);

                      final docId = await ref
                          .read(firebaseCodesStreamProvider.notifier)
                          .getDocIdByName(codes[index].name);

                      final macro = Macro(
                        name: codes[index].name,
                        type: MacroType.infrared,
                        docId: docId,
                      );

                      if (docId == null) {
                        return;
                      }
                      setMacroByType(macro);
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
              ),
              runAppFuture.when(
                data: (apps) {
                  return MacroSettingContainer(
                    title: "アプリ実行",
                    selected: appSelected.value,
                    onAttach: (index) {
                      selectApp(index);
                      setMacroByType(apps[index]);
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
              ),

              // AIマクロ設定
              Padding(
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
                            style: Theme.of(context).textTheme.bodyMedium,
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
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
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
              ),
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
              final macro = Macro(
                name: order,
                type: MacroType.aiTextConvert,
                aiPrompt: order,
              );
              setMacroByType(macro);
            }
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.check_rounded),
          label: Text("適応"),
        ),
        FilledButton.tonalIcon(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close_rounded),
          label: Text("閉じる"),
        ),
      ],
    );
  }
}
