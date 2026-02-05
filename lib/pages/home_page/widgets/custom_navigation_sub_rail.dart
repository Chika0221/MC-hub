part of 'custom_navigation_rail.dart';

class CustomNavigationSubRail extends HookConsumerWidget {
  const CustomNavigationSubRail({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  ButtonStyle subRailChildrenButtonStyle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.fromMap({
        WidgetState.selected: colorScheme.surfaceContainer,
      }),
      iconColor: WidgetStateProperty.fromMap({
        WidgetState.selected: colorScheme.primary,
      }),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final label = switch (selectedIndex) {
      0 => 'REMOCON',
      1 => 'WORKFLOW',
      2 => 'CONTROL',
      int() => "UNKNOWN",
    };

    return Column(
      children: [
        const SizedBox(height: 32),
        IconButton(
          isSelected: (selectedIndex == 0),
          onPressed: () => onSelected.call(0),
          icon: const Icon(Icons.add_box_outlined),
          selectedIcon: const Icon(Icons.add_box_rounded),
          style: subRailChildrenButtonStyle(context),
        ),
        IconButton(
          isSelected: (selectedIndex == 1),
          onPressed: () => onSelected.call(1),
          icon: const Icon(Icons.shape_line_outlined),
          selectedIcon: const Icon(Icons.shape_line_rounded),
          style: subRailChildrenButtonStyle(context),
        ),
        IconButton(
          isSelected: (selectedIndex == 2),
          onPressed: () => onSelected.call(2),
          icon: const Icon(Icons.send_time_extension_outlined),
          selectedIcon: const Icon(Icons.send_time_extension_rounded),
          style: subRailChildrenButtonStyle(context),
        ),
        const Spacer(),
        const SizedBox(height: 32),
        RotatedBox(
          quarterTurns: 3,
          child: Text(
            label,
            style: CustomTheme()
                .titleTheme(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ).animate().slideX(
          duration: 100.ms,
          curve: Curves.bounceIn,
          begin: -1.0,
          end: 0.0,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
