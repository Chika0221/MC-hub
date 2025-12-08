// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/main.dart';
import 'package:mc_hub/pages/deviceSelect_page/widgets/backgroundGradiantContainer.dart';
import 'package:mc_hub/theme/custom_theme.dart';
import 'package:mc_hub/widgets/custom_appbar.dart';

class DeviceSelectPage extends HookConsumerWidget {
  const DeviceSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = [1, 1, 1, 1, 1];

    return Scaffold(
      appBar: CustomAppbar().build(context, ref),
      body: Backgroundgradiantcontainer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Text(
                "MC Hub",
                style: CustomTheme().titleTheme.textTheme.titleLarge?.copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.05,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 16,
                    children: List.generate(devices.length, (int index) {
                      return Container(
                        width: MediaQuery.of(context).size.height * 0.3,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1,
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.of(
                              context,
                            ).pushNamed(AppRoute.editor.path);
                          },
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
