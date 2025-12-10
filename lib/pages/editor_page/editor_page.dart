// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keyboard_event/keyboard_event.dart';

// Project imports:
import 'package:mc_hub/widgets/custom_appbar.dart';

class EditorPage extends HookConsumerWidget {
  const EditorPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final KeyboardEvent keyboardEvent;
    final keyDownEvents = useState<List<String?>>([]);

    Future<void> initKeyboard() async {
      await KeyboardEvent.init(); // 仮想キー情報の初期化[web:1]
      keyboardEvent.startListening((keyEvent) {
        if (keyEvent.isKeyDown &&
            !keyDownEvents.value.contains(keyEvent.vkName)) {
          keyDownEvents.value = [
            ...keyDownEvents.value,
            keyEvent.vkName,
          ]; //2キー以上の入力に対応
        } else {
          keyDownEvents.value = [];
        }
        // debugPrint(keyEvent.toString());
        debugPrint(keyDownEvents.value.join(" + "));
      });
    }

    useEffect(() {
      keyboardEvent = KeyboardEvent();
      initKeyboard();
      return () {
        keyboardEvent.cancelListening();
      };
    }, []);

    return Scaffold(
      appBar: CustomAppbar().build(context, ref),
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(keyDownEvents.value.join(" + ")),
        ),
      ),
    );
  }
}
