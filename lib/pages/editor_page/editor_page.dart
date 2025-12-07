import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mc_hub/widgets/custom_appbar.dart';

class EditorPage extends HookConsumerWidget {
  const EditorPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppbar().build(context, ref),
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("こんにちは"),
        ),
      ),
    );
  }
}
