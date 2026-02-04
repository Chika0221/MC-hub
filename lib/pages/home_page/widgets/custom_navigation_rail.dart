// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/theme/custom_theme.dart';
import 'package:mc_hub/widgets/double_line_border_container.dart';

part 'custom_navigation_sub_rail.dart';

class CustomNavigationRail extends HookConsumerWidget {
  const CustomNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.subSelectedIndex,
  });

  final ValueNotifier<int> selectedIndex;
  final ValueNotifier<int> subSelectedIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);

    final double labelHeight =
        (size.height > 600) ? MediaQuery.sizeOf(context).height * 0.6 : 0;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DoubleLineBorderContainer(
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        borderType: DoubleLineBorderType.stadium,
        child: NavigationRail(
          selectedIndex: selectedIndex.value,
          onDestinationSelected: (value) {
            selectedIndex.value = value;
          },
          backgroundColor: Colors.transparent,
          indicatorColor: Theme.of(
            context,
          ).colorScheme.primary.withAlpha(255 * 0.5.toInt()),
          unselectedIconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.surface,
          ),
          leading: Column(
            children: [
              SizedBox(height: 24),
              Image.asset("assets/icons/app_icon.png", width: 40),
              SizedBox(height: 24),
            ],
          ),
          destinations: [
            NavigationRailDestination(
              icon: Icon(Icons.home_rounded),
              label: Text('Home'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.settings_ethernet_rounded),
              label: Text('Settings'),
            ),
          ],
          trailingAtBottom: true,
          trailing: Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 4, 8),
            child: Container(
              decoration: ShapeDecoration(
                shape: StadiumBorder(),
                color: Theme.of(context).colorScheme.primary,
              ),
              height: labelHeight,
              width: 64,
              child: Center(
                child:
                    (selectedIndex.value == 0)
                        ? RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            "Switch Palette",
                            style: CustomTheme()
                                .titleTheme(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            // style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            //   fontSize: MediaQuery.of(context).size.height * 0.08,
                            //   fontWeight: FontWeight.bold,
                            // ),
                          ),
                        ).animate().slideX(
                          duration: 100.ms,
                          curve: Curves.bounceIn,
                          begin: -1.0,
                          end: 0.0,
                        )
                        : CustomNavigationSubRail(
                          selectedIndex: subSelectedIndex.value,
                          onSelected: (index) {
                            subSelectedIndex.value = index;
                          },
                        ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
