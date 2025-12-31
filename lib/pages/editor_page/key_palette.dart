// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mc_hub/pages/editor_page/key_source.dart';

class KeyPalette extends StatelessWidget {
  const KeyPalette({super.key});

  @override
  Widget build(BuildContext context) {
    // Standard keys to be available in the palette
    final List<String> alphaKeys = List.generate(
      26,
      (index) => String.fromCharCode(65 + index),
    );
    final List<String> numberKeys = List.generate(
      10,
      (index) => index.toString(),
    );
    final List<String> modifiers = [
      "Ctrl",
      "Shift",
      "Alt",
      "Win",
      "Tab",
      "Esc",
      "Bksp",
      "Enter",
      "Space",
    ];
    final List<String> functionKeys = List.generate(
      12,
      (index) => "F${index + 1}",
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 4,
          ),
          right: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 4,
          ),
          left: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 4,
          ),
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: "Basic"),
                Tab(text: "Media"),
                Tab(text: "Macro"),
                Tab(text: "Layer"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildGrid([
                    ...alphaKeys,
                    ...numberKeys,
                    ...modifiers,
                    ...functionKeys,
                  ]),
                  _buildGrid([
                    "VolUp",
                    "VolDn",
                    "Mute",
                    "Play",
                    "Next",
                    "Prev",
                  ]),
                  Center(child: Text("Macros coming soon")),
                  Center(child: Text("Layers coming soon")),
                ],
              ),
            ),
          ],
        ),
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
}
