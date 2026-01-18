// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/notification/send_notification.dart';

class CustomNavigationRail extends HookConsumerWidget {
  const CustomNavigationRail({super.key, required this.selectedIndex});

  final ValueNotifier<int> selectedIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationRail(
      selectedIndex: selectedIndex.value,
      onDestinationSelected: (value) {
        selectedIndex.value = value;
      },
      backgroundColor: Theme.of(context).colorScheme.onSurface,
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
          Text(
            "MC Hub",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
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
      trailing: IconButton.filledTonal(
        onPressed: () {
          sendAppNotification();
        },
        icon: Icon(Icons.logout_rounded),
      ),
    );
  }
}
