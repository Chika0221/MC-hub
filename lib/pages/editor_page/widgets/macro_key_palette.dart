// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/pages/editor_page/widgets/key_macro_source.dart';

class MacroKeyPalette extends HookConsumerWidget {
  const MacroKeyPalette({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children:
            items.map((label) {
              return MacroSettingMacroSource(label: label, data: label);
            }).toList(),
      ),
    );
  }
}
