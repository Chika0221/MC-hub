// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/firebase_codes_stream_privider.dart';
import 'package:mc_hub/models/infrared_code.dart';

class CodeContainer extends HookConsumerWidget {
  const CodeContainer({super.key, required this.code, required this.onPressed});

  final InfraredCode code;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color:
            (code.state)
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.surface,
      ),
      padding: EdgeInsets.fromLTRB(24, 8, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(code.name),
                      content: Text("${code.code}"),
                      actions: [
                        FilledButton.tonalIcon(
                          onPressed: () {
                            ref
                                .read(firebaseCodesStreamProvider.notifier)
                                .deleteCode(code);
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.delete_rounded),
                          label: Text("削除"),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.close_rounded),
                          label: Text("閉じる"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    code.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color:
                          (code.state)
                              ? Theme.of(context).colorScheme.onSecondary
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    code.code,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color:
                          (code.state)
                              ? Theme.of(context).colorScheme.onSecondary
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16),
          IconButton.filled(
            icon: Icon(Icons.play_arrow_rounded),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
