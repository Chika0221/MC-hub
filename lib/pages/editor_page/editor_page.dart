// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/vial_provider.dart';
import 'package:mc_hub/pages/editor_page/widgets/key_canvas.dart';
import 'package:mc_hub/pages/editor_page/widgets/key_palette.dart';
import 'package:mc_hub/pages/editor_page/widgets/layer/layer_buttons.dart';
import 'package:mc_hub/pages/editor_page/widgets/layer/layer_profile_container.dart';
import 'package:mc_hub/widgets/custom_appbar.dart';

class EditorPage extends HookConsumerWidget {
  const EditorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vialState = ref.watch(vialProvider);
    final selectedLayer = useState<int>(0);

    return Scaffold(
      appBar: CustomAppbar(title: vialState.deviceName),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            LayerProfileContainer(
              selectedIndex: selectedLayer.value,
              onLayerSelected: (int index) => selectedLayer.value = index,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: KeyCanvas(layerIndex: selectedLayer.value),
                  ),
                  SizedBox(height: 8),
                  const Expanded(flex: 2, child: KeyPalette()),
                ],
              ),
            ),
            const SizedBox(width: 8),
            LayerProfileContainer(
              selectedIndex: selectedLayer.value,
              onLayerSelected: (int index) => selectedLayer.value = index,
            ),
          ],
        ),
      ),
    );
  }
}
