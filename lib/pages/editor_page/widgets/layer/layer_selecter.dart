// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/profile_provider.dart';
import 'package:mc_hub/models/key_profile.dart';
import 'package:mc_hub/pages/editor_page/widgets/layer/layer_buttons.dart';
import 'package:mc_hub/widgets/has_last_child_listview.dart';

class LayerSelecter extends HookConsumerWidget {
  const LayerSelecter({
    super.key,
    required this.onLayerSelected,
    required this.selectedIndex,
  });

  final void Function(int layerIndex) onLayerSelected;
  final int selectedIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(selectProfileProvider);

    // final appLayers = profile?.appLayers ?? [];
    final appLayers = [
      AppLayer(name: "VSCode", id: "000", appPath: "vscode.exe", isFocus: true),
      AppLayer(
        name: "Chrome",
        id: "001",
        appPath: "chrome.exe",
        isFocus: false,
      ),
      AppLayer(name: "Slack", id: "002", appPath: "slack.exe", isFocus: false),
      AppLayer(
        name: "Discord",
        id: "003",
        appPath: "discord.exe",
        isFocus: false,
      ),
      AppLayer(name: "Figma", id: "004", appPath: "figma.exe", isFocus: false),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              4,
              (index) => LayerButton(
                onPressed: () => onLayerSelected(index),
                child: Text(
                  index.toString(),
                  style: TextStyle(
                    color:
                        (selectedIndex == index)
                            ? Theme.of(context).colorScheme.onTertiary
                            : Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
            ),
          ),
          Divider(color: Theme.of(context).colorScheme.surface),
          Expanded(
            child: HasLastChildListView(
              itemBuilder: (context, index) {
                return SizedBox(
                  width: double.infinity,
                  child: LayerSelecterAppItem(appLayer: appLayers[index]),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 8);
              },
              itemCount: appLayers.length,
              lastChild: FilledButton(onPressed: () {}, child: Icon(Icons.add)),
            ),
          ),
        ],
      ),
    );
  }
}

class LayerSelecterAppItem extends HookConsumerWidget {
  const LayerSelecterAppItem({super.key, required this.appLayer});

  final AppLayer appLayer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSettingOpen = useState(false);

    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      curve: Curves.bounceInOut,
      height: 48 + (isSettingOpen.value ? 84 : 0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(appLayer.name),
            onTap: () {
              isSettingOpen.value = !isSettingOpen.value;
            },
            trailing:
                (isSettingOpen.value)
                    ? Icon(Icons.arrow_drop_up_rounded)
                    : Icon(Icons.arrow_drop_down_rounded),
          ),
          if (isSettingOpen.value)
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.all(4),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("App Path:"),
                      SizedBox(width: 8),
                      Expanded(child: Text(appLayer.appPath)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text("Is Focus:"),
                      SizedBox(width: 8),
                      Switch(value: appLayer.isFocus, onChanged: (value) {}),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
