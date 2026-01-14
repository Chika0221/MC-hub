// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/widgets/custom_appbar.dart';

class CustomFullPageDialog extends HookConsumerWidget {
  const CustomFullPageDialog({super.key, required this.child, this.title});

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    const sizePadding = 8.0;

    return SimpleDialog(
      title: CustomAppbar(title: title),
      insetPadding: const EdgeInsets.all(sizePadding),
      children: [
        SizedBox(
          width: size.width,
          height: size.height - sizePadding,
          child: child,
        ),
      ],
    );
  }
}
