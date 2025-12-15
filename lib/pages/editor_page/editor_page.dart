// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/widgets/custom_appbar.dart';
import 'package:mc_hub/pages/editor_page/layout_data.dart';
import 'package:mc_hub/pages/editor_page/keyboard_layout.dart';
import 'package:mc_hub/pages/editor_page/key_palette.dart';

// State provider for key mappings
// final keyMappingProvider = NotifierProvider<Map<String, String>>((ref) => {});
final keyMappingProvider = Provider<Map<String, String>>((ref) => {});

class EditorPage extends HookConsumerWidget {
  const EditorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyMappings = ref.watch(keyMappingProvider);

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
                    layoutData: keyboardLayout60,
                    keyMappings: keyMappings,
                    onKeyRemap: (keyId, newMapping) {
                      final currentMap = ref.read(keyMappingProvider);
                      // ref.read(keyMappingProvider.notifier).state = {
                      //   ...currentMap,
                      //   keyId: newMapping,
                      // };

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
