// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:hid4flutter/hid4flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mc_hub/infrastructure/hid/hid_scripts.dart';
// Project imports:
import 'package:mc_hub/main.dart';
import 'package:mc_hub/pages/deviceSelect_page/widgets/backgroundGradiantContainer.dart';
import 'package:mc_hub/theme/custom_theme.dart';
import 'package:mc_hub/widgets/custom_appbar.dart';
import 'package:rive/rive.dart';

part 'widgets/select_device_container.dart';

class DeviceSelectPage extends HookConsumerWidget {
  const DeviceSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = useState<List<HidDevice>>([]);

    void getHidDevice() async {
      devices.value = await deviceList();
    }

    useEffect(() {
      getHidDevice();
    }, []);

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
                style: CustomTheme()
                    .titleTheme(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                      fontSize: MediaQuery.of(context).size.height * 0.08,
                    ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 16,
                      children: List.generate(devices.value.length, (
                        int index,
                      ) {
                        return SelectDeviceContainer();
                      }),
                    ),
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
