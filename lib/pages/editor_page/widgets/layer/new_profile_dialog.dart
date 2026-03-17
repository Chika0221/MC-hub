// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/profile_provider.dart';

class NewProfileDialog extends HookConsumerWidget {
  const NewProfileDialog({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputText = useTextEditingController();

    return AlertDialog(
      title: Text("プロファイルの追加"),
      content: TextFormField(
        controller: inputText,
        decoration: InputDecoration(
          labelText: "Profile Name",
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () {
          if (inputText.text.isEmpty) return;
            ref
                .read(profilesAsyncNotifierProvider.notifier)
                .createProfile(inputText.text);

            Navigator.of(context).pop();
          },
          child: Text("作成"),
        ),
        FilledButton.tonal(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("キャンセル"),
        ),
      ],
    );
  }

  static Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return const NewProfileDialog();
      },
    );
  }
}
