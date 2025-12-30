// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/pages/deviceSelect_page/deviceSelect_page.dart';
import 'package:mc_hub/pages/home_page/widgets/custom_navigation_rail.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [CustomNavigationRail(), Expanded(child: DeviceSelectPage())],
      ),
    );
  }
}
