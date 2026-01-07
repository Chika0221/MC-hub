// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MacroSettingDialog extends HookConsumerWidget {
  const MacroSettingDialog({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

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
            children: [Text("マクロの設定内容がここに入ります。")],
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
