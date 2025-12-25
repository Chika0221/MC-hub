// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mc_hub/infrastructure/hid/list_of_mydevices.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/vial_provider.dart';
import 'package:mc_hub/models/vial_state.dart';
import 'package:mc_hub/pages/editor_page/key_data.dart';
import 'package:mc_hub/pages/editor_page/key_palette.dart';
import 'package:mc_hub/pages/editor_page/keyboard_layout.dart';
import 'package:mc_hub/pages/editor_page/layout_data.dart';
import 'package:mc_hub/widgets/custom_appbar.dart';

class EditorPage extends HookConsumerWidget {
  const EditorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vialState = ref.watch(vialProvider);
    final keyMappings = vialState.keyMappings;

    ref.listen(vialProvider, (VialState? previousState, VialState newState) {
      print(newState.statusMessage);
    });

    // Determine layout to show
    List<List<KeyData>> activeLayout;

    if (vialState.matrix != null && vialState.matrix!.isNotEmpty) {
      // Construct dynamic layout from matrix
      // Using Layer 0 for visualization
      final layer0 = vialState.matrix![0];
      activeLayout = [];
      for (int r = 0; r < layer0.length; r++) {
        final List<KeyData> row = [];
        for (int c = 0; c < layer0[r].length; c++) {
          final keycode = layer0[r][c];
          row.add(
            KeyData(
              id: "$r,$c",
              defaultLabel: VialNotifier.keycodeToLabel(keycode),
              width: 1.0,
            ),
          );
        }
        activeLayout.add(row);
      }
    } else {
      // Fallback to static layout
      activeLayout = keyboardLayout60;
    }

    return Scaffold(
      appBar: CustomAppbar().build(context, ref),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          // Top section: Keyboard Visualization
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
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

          // Divider
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),

          // Bottom section: Key Palette
          const Expanded(flex: 2, child: KeyPalette()),
        ],
      ),
    );
  }
}
