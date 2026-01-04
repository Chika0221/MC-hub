// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/hid/list_of_mydevices.dart';
import 'package:mc_hub/infrastructure/providers/vial_provider.dart';
import 'package:mc_hub/models/vial_state.dart';
import 'package:mc_hub/pages/editor_page/key_data.dart';
import 'package:mc_hub/pages/editor_page/key_palette.dart';
import 'package:mc_hub/pages/editor_page/keyboard_layout.dart';
import 'package:mc_hub/pages/editor_page/layout_data.dart';
import 'package:mc_hub/pages/editor_page/widgets/layer_button.dart';
import 'package:mc_hub/widgets/custom_appbar.dart';

class EditorPage extends HookConsumerWidget {
  const EditorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vialState = ref.watch(vialProvider);
    final keyMappings = vialState.keyMappings;

    final selectedLayer = useState<int>(0);

    ref.listen(vialProvider, (VialState? previousState, VialState newState) {
      print(newState.statusMessage);
    });

    // Determine layout to show
    List<List<KeyData>> activeLayout;

    if (vialState.matrix != null && vialState.matrix!.isNotEmpty) {
      // Construct dynamic layout from matrix
      // Using Layer 0 for visualization
      final layer0 = vialState.matrix![selectedLayer.value];
      activeLayout = [];
      for (int r = 0; r < layer0.length; r++) {
        final List<KeyData> row = [];
        for (int c = 0; c < layer0[r].length; c++) {
          final keycode = layer0[r][c];

          try {
            final keydata = KeyData(
              id: "$r,$c",
              defaultLabel: VialNotifier.keycodeToLabel(keycode),
              width:
                  myDevices.first.keys
                      .where((key) => key.id == "$r,$c")
                      .first
                      .width,
            );
            row.add(keydata);
          } catch (e) {}
        }
        activeLayout.add(row);
      }
    } else {
      // Fallback to static layout
      activeLayout = keyboardLayout60;
    }

    return Scaffold(
      appBar: CustomAppbar(title: vialState.deviceName),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          // Top section: Keyboard Visualization
          Expanded(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 84,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      spacing: 8,
                      children: List.generate(4, (index) {
                        return LayerButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            selectedLayer.value = index;
                            print(index);
                          },
                        );
                      }),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.surfaceContainerLow,
                    child: Center(
                      child: SingleChildScrollView(
                        child: KeyboardLayout(
                          layoutData: activeLayout,
                          keyMappings: keyMappings,
                          onKeyRemap: (keyId, newMapping) {
                            ref
                                .read(vialProvider.notifier)
                                .updateKey(keyId, newMapping);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Mapped $newMapping to key"),
                                duration: const Duration(milliseconds: 500),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 8),
          const Expanded(flex: 2, child: KeyPalette()),
        ],
      ),
    );
  }
}
