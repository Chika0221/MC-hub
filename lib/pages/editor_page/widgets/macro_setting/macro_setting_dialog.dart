// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/pages/editor_page/widgets/macro_setting/macro_setting_container.dart';

class MacroSettingDialog extends HookConsumerWidget {
  const MacroSettingDialog({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final codeSelected = useState<int?>(null);

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
              MacroSettingContainer(
                title: "スマートリモコン操作",
                selected: codeSelected.value,
                onAttach: (docId, index) => codeSelected.value = index,
                itemCount: 20,
                builder: (index) {
                  return MacroSelecterContainer(
                    select: codeSelected.value == index,
                    title: "aaaa",
                  );
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
