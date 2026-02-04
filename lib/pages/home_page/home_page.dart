// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_animated_indexed_stack/easy_animated_indexed_stack.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/pages/deviceSelect_page/deviceSelect_page.dart';
import 'package:mc_hub/pages/home_page/widgets/custom_navigation_rail.dart';
import 'package:mc_hub/pages/setting_page/setting_page.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);
    final subSelectedIndex = useState(0);

    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomNavigationRail(
            selectedIndex: selectedIndex,
            subSelectedIndex: subSelectedIndex,
          ),
          Expanded(
            child: EasyAnimatedIndexedStack(
              index: selectedIndex.value,
              animationBuilder:
                  (context, animation, child) =>
                      FadeTransition(opacity: animation, child: child),
              curve: Curves.easeInOutSine,
              duration: Duration(milliseconds: 240),
              children: [
                DeviceSelectPage(),
                SettingPage(selectedIndex: subSelectedIndex.value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
