// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomBackground extends HookConsumerWidget {
  const CustomBackground({
    super.key,
    required this.backGroundWidget,
    required this.foragroundWidget,
  });

  final Widget backGroundWidget;
  final Widget foragroundWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned.fill(child: backGroundWidget),
          Positioned.fill(child: foragroundWidget),
        ],
      ),
    );
  }
}
