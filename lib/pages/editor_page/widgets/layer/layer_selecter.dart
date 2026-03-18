// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
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
                  child: FilledButton.tonal(
                    onPressed: () {},
                    child: Text("Profile $index"),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 8);
              },
              itemCount: 20,
              lastChild: FilledButton(onPressed: () {}, child: Icon(Icons.add)),
            ),
          ),
        ],
      ),
    );
  }
}

class LayerSelecterAppItem extends HookConsumerWidget {
  const LayerSelecterAppItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text("Profile Name"),
        subtitle: Text("Last modified: 2024-01-01"),
        onTap: () {},
      ),
    );
  }
}
