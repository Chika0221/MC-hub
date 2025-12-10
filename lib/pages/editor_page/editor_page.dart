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
      // body: Center(
      //   child: OutlinedButton(
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //     child: Text(keyDownEvents.value.join(" + ")),
      //   ),
      // ),
      body: Column(
        children: [
          Flexible(
            flex: 4,
            child: Container(
              child: Center(
                child: Draggable(
                  data: "yes_data",
                  child: Text("こっちで設定"),
                  feedback: Material(
                    child: Text("うわぁ～"),
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                        child: Center(
                          child: Text(
                            keyDownEvents.value.join(" + "),
                            style: Theme.of(
                              context,
                            ).textTheme.displayMedium?.copyWith(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onSecondaryContainer,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: MediaQuery.of(context).size.width * 0.03,
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                        child: DragTarget(
                          onAcceptWithDetails: (data) {
                            if (data.data is String) {
                              print(data.data);
                            }
                          },

                          builder: (
                            BuildContext context,
                            List<Object?> candidateData,
                            List<dynamic> rejectedData,
                          ) {
                            return Center(
                              child: Text(candidateData.toString()),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: Container(
              color: Theme.of(context).colorScheme.surfaceContainer,
              child: Center(child: Text("こっちにキーボード")),
            ),
          ),
        ],
      ),
    );
  }
}
