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
import 'package:mc_hub/pages/editor_page/layout_data.dart';
import 'package:mc_hub/pages/editor_page/widgets/key_palette.dart';
import 'package:mc_hub/pages/editor_page/widgets/keyboard_layout.dart';
import 'package:mc_hub/pages/editor_page/widgets/layer_buttons.dart';
import 'package:mc_hub/widgets/custom_appbar.dart';

class EditorPage extends HookConsumerWidget {
  const EditorPage({super.key});

  Map<String, String> _keyMappingsForLayer(
    VialState vialState,
    int layerIndex,
  ) {
    final matrix = vialState.matrix;
    if (matrix == null || matrix.isEmpty) {
      return vialState.keyMappings;
    }

    final safeLayerIndex = layerIndex.clamp(
      0,
      matrix.length - 1,
    ); // avoid out-of-range
    final layer = matrix[safeLayerIndex];

    final Map<String, String> mappings = {};
    for (int r = 0; r < layer.length; r++) {
      for (int c = 0; c < layer[r].length; c++) {
        mappings["$r,$c"] = VialNotifier.keycodeToLabel(layer[r][c]);
      }
    }
    return mappings;
  }

  List<List<KeyData>> setLayout(VialState vialState, int index) {
    List<List<KeyData>> activeLayout = [];

    final deviceDef = myDevices.firstWhere(
      (d) => d.name == vialState.deviceName,
      orElse: () => myDevices.first,
    );

    final visualLayoutDef =
        vialState.deviceName != null
            ? deviceVisualLayouts[vialState.deviceName]
            : null;

    if (visualLayoutDef != null &&
        vialState.matrix != null &&
        vialState.matrix!.isNotEmpty) {
      final matrix = vialState.matrix!;
      final safeLayerIndex = index.clamp(0, matrix.length - 1);
      final layer = matrix[safeLayerIndex];

      for (final rowIds in visualLayoutDef) {
        final List<KeyData> row = [];
        for (final id in rowIds) {
          final parts = id.split(',');
          if (parts.length != 2) continue;
          final r = int.tryParse(parts[0]);
          final c = int.tryParse(parts[1]);

          if (r != null &&
              c != null &&
              r < layer.length &&
              c < layer[r].length) {
            final keycode = layer[r][c];

            try {
              final keyDef = deviceDef.keys.firstWhere(
                (k) => k.id == id,
                orElse: () => KeyData(id: id, defaultLabel: "?"),
              );

              final keydata = KeyData(
                id: id,
                defaultLabel: VialNotifier.keycodeToLabel(keycode),
                width: keyDef.width,
              );
              row.add(keydata);
            } catch (e) {}
          }
        }
        activeLayout.add(row);
      }
    } else if (vialState.matrix != null && vialState.matrix!.isNotEmpty) {
      final matrix = vialState.matrix!;
      final safeLayerIndex = index.clamp(0, matrix.length - 1);
      final layer0 = matrix[safeLayerIndex];
      for (int r = 0; r < layer0.length; r++) {
        final List<KeyData> row = [];
        for (int c = 0; c < layer0[r].length; c++) {
          final keycode = layer0[r][c];

          try {
            final keydata = KeyData(
              id: "$r,$c",
              defaultLabel: VialNotifier.keycodeToLabel(keycode),
              width:
                  deviceDef.keys.where((key) => key.id == "$r,$c").first.width,
            );
            row.add(keydata);
          } catch (e) {}
        }
        activeLayout.add(row);
      }
    } else {
      activeLayout = keyboardLayout60;
    }

    return activeLayout;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vialState = ref.watch(vialProvider);
    final selectedLayer = useState<int>(0);

    final layoutData = setLayout(vialState, selectedLayer.value);
    final keyMappings = _keyMappingsForLayer(vialState, selectedLayer.value);

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
                    child: LayerButtons(
                      selectedLayerIndex: selectedLayer.value,
                      onLayerChanged: (index) {
                        selectedLayer.value = index;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.surfaceContainerLow,
                    child: Center(
                      child: SingleChildScrollView(
                        child: KeyboardLayout(
                          layoutData: layoutData,
                          keyMappings: keyMappings,
                          onKeyRemap: (keyId, newMapping) {
                            ref
                                .read(vialProvider.notifier)
                                .updateKey(
                                  selectedLayer.value,
                                  keyId,
                                  newMapping,
                                );
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
