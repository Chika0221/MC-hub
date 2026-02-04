// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mc_hub/pages/editor_page/key_data.dart';

class KeyUnit extends StatelessWidget {
  final KeyData keyData;
  final String? currentMapping;
  final Function(String) onRemap;

  const KeyUnit({
    super.key,
    required this.keyData,
    this.currentMapping,
    required this.onRemap,
  });

  @override
  Widget build(BuildContext context) {
    // 1u size base. You might want to adjust this based on screen width.
    const double uSize = 54.0;
    const double spacing = 4.0;

    return Container(
      width: (keyData.width * uSize) + (keyData.width - 1) * spacing,
      height: (keyData.height * uSize) + (keyData.height - 1) * spacing,
      margin: EdgeInsets.only(
        left: keyData.xOffset * (uSize + spacing),
        right: spacing,
        bottom: spacing,
      ),
      child: DragTarget<String>(
        onWillAcceptWithDetails: (details) => true,
        onAcceptWithDetails: (details) {
          onRemap(details.data);
        },
        builder: (context, candidateData, rejectedData) {
          final isHovered = candidateData.isNotEmpty;
          final displayLabel = currentMapping ?? keyData.defaultLabel;

          return Container(
            decoration: BoxDecoration(
              color:
                  isHovered
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color:
                    isHovered
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outlineVariant,
                width: 1.0,
              ),
            ),
            child: Center(
              child: Text(
                displayLabel,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color:
                      isHovered
                          ? Theme.of(context).colorScheme.onPrimaryContainer
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
