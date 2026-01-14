// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/vial_provider.dart';
import 'package:mc_hub/pages/editor_page/widgets/key_macro_source.dart';
import 'package:mc_hub/pages/editor_page/widgets/key_source.dart';
import 'package:mc_hub/widgets/folder_border_container_tabs.dart';

class KeyPalette extends HookConsumerWidget {
  const KeyPalette({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Standard keys to be available in the palette

    final tabSelectedIndex = useState(0);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FolderBorderContainerTabs(
        titles: ["Basic", "Media", "Macro", "Layer"],
        children: [
          _buildGrid(VialKey.basicLabels()),
          _buildGrid(["VolUp", "VolDn", "Mute", "Play", "Next", "Prev"]),
          _buildMacroGrid(VialKey.macroLabels()),
          _buildGrid(VialKey.layerLabels()),
        ],
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        selectedIndex: tabSelectedIndex.value,
        onTabChanged: (int value) {
          tabSelectedIndex.value = value;
        },
      ),
    );
  }

  Widget _buildGrid(List<String> items) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children:
            items.map((label) {
              return KeySource(label: label, data: label);
            }).toList(),
      ),
    );
  }

  Widget _buildMacroGrid(List<String> items) {
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
