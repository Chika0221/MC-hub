// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/pages/editor_page/widgets/layer/layer_buttons.dart';
import 'package:mc_hub/pages/editor_page/widgets/layer/layer_selecter.dart';
import 'package:mc_hub/pages/editor_page/widgets/layer/profile_selecter.dart';
import 'package:mc_hub/widgets/double_line_border_container.dart';

class LayerProfileContainer extends HookConsumerWidget {
  const LayerProfileContainer({
    super.key,
    required this.onLayerSelected,
    required this.selectedIndex,
  });

  final void Function(int layerIndex) onLayerSelected;
  final int selectedIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final isOpen = useState<bool>(false);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isOpen.value ? 250 : 64,
      child:
          (isOpen.value)
              ? DoubleLineBorderContainer(
                backgroundColor: colorScheme.surfaceContainer,
                borderType: DoubleLineBorderType.roundedRectangle,
                borderRadius: 32,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(flex: 1, child: ProfileSelecter()),
                      Divider(color: Theme.of(context).colorScheme.surface),
                      Flexible(flex: 2, child: LayerSelecter()),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.tonal(
                          onPressed: () {
                            isOpen.value = !isOpen.value;
                          },
                          child: Icon(Icons.arrow_back_ios_rounded),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              : Container(
                decoration: ShapeDecoration(
                  shape: StadiumBorder(),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LayerButtons(
                      selectedLayerIndex: selectedIndex,
                      onLayerChanged: onLayerSelected,
                    ),
                    const SizedBox(height: 8),
                    IconButton.filledTonal(
                      onPressed: () {
                        isOpen.value = !isOpen.value;
                      },
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
    );
  }
}
