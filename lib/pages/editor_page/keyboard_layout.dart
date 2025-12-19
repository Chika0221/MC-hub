// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mc_hub/pages/editor_page/key_data.dart';
import 'package:mc_hub/pages/editor_page/key_unit.dart';

class KeyboardLayout extends StatelessWidget {
  final List<List<KeyData>> layoutData;
  final Map<String, String> keyMappings;
  final Function(String keyId, String newMapping) onKeyRemap;

  const KeyboardLayout({
    super.key,
    required this.layoutData,
    required this.keyMappings,
    required this.onKeyRemap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: layoutData.map((row) {
            return Row(
              children: row.map((keyData) {
                return KeyUnit(
                  keyData: keyData,
                  currentMapping: keyMappings[keyData.id],
                  onRemap: (newMapping) {
                    onKeyRemap(keyData.id, newMapping);
                  },
                );
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
