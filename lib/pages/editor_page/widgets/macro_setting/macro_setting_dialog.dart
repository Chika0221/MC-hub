// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
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

    void selectCode(int index) {
      codeSelected.value = index;
      appSelected.value = null;
      comboSelected.value = null;
    }

    void selectApp(int index) {
      appSelected.value = index;
      codeSelected.value = null;
      comboSelected.value = null;
    }

    void selectCombo(int index) {
      comboSelected.value = index;
      codeSelected.value = null;
      appSelected.value = null;
    }

    final codesStream = ref.watch(firebaseCodesStreamProvider);

    final runAppFuture = ref.watch(openAppProvider);

    return AlertDialog(
      title: Text(title),
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
                      ref.read(MacrosProvider.notifier).setMacro(title, macro);
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
                      ref
                          .read(MacrosProvider.notifier)
                          .setMacro(title, apps[index]);
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
              
            ],
          ),
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("適応"),
        ),
        FilledButton.tonal(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("閉じる"),
        ),
      ],
    );
  }
}
