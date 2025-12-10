// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/widgets/custom_appbar.dart';

class EditorPage extends HookConsumerWidget {
  const EditorPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppbar().build(context, ref),
      body: Center(
        // child: OutlinedButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: Text("こんにちは"),
        // ),
        // child: Focus(
        //   autofocus: true,
        //   onKeyEvent: (node, event) {
        //     final key = event.logicalKey;
        //     if (event is KeyDownEvent) print("DOWN:$key");
        //     return KeyEventResult.handled;
        //   },
        //   child: Container(width: 300, height: 300, color: Colors.red),
        // ),
        
      ),
    );
  }
}
