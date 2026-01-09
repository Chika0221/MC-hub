// Dart imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/macro/app_preferences.dart';
import 'package:mc_hub/infrastructure/macro/run_macro.dart';
import 'package:mc_hub/infrastructure/providers/macros_provider.dart';
import 'package:mc_hub/models/macro.dart';
import 'package:mc_hub/pages/editor_page/widgets/macro_setting/macro_setting_dialog.dart';

class KeyMacroSource extends StatelessWidget {
  final String label;
  final String data;

  const KeyMacroSource({super.key, required this.label, required this.data});

  @override
  Widget build(BuildContext context) {
    const double size = 48.0;

    return Draggable<String>(
      data: data,
      feedback: Material(
        color: Colors.transparent,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      childWhenDragging: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.surfaceContainerHighest.withOpacity(0.5),
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class MacroSettingMacroSource extends HookConsumerWidget {
  const MacroSettingMacroSource({
    super.key,
    required this.label,
    required this.data,
  });

  final String label;
  final String data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double size = 48.0;
    const double spacing = 8.0;
    const double expandedWidth = size * 5 + spacing * 4;

    return Container(
      width: expandedWidth,
      height: size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          KeyMacroSource(label: label, data: data),
          MacroInfomationContainer(
            height: size,
            width: expandedWidth - size,
            label: label,
          ),
        ],
      ),
    );
  }
}

class MacroInfomationContainer extends HookConsumerWidget {
  const MacroInfomationContainer({
    super.key,
    required this.width,
    required this.height,
    required this.label,
  });

  final double width;
  final double height;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int index = MonitorKeycodes.values.indexWhere(
      (e) => e.shortName == label,
    );

    final macrosAsync = ref.watch(MacrosProvider);

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: InkWell(
        onTap:
            () => showDialog(
              context: context,
              builder: (context) => MacroSettingDialog(title: label),
            ),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(width: 4),
              Expanded(
                child: macrosAsync.when(
                  data: (macros) {
                    final macro = macros[index];
                    return Text(
                      macro != null ? macro.name : "未設定",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                  loading:
                      () => Center(child: const CircularProgressIndicator()),
                  error: (error, stackTrace) {
                    print(error.toString());
                    return Text(
                      error.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).colorScheme.surface,
              ),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }
}
