// Flutterのインポート:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hid4flutter/hid4flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rive/rive.dart';

// Project imports:
import 'package:mc_hub/infrastructure/hid/hid_scripts.dart';
import 'package:mc_hub/infrastructure/providers/vial_provider.dart';
import 'package:mc_hub/main.dart';
import 'package:mc_hub/theme/custom_theme.dart';
import 'package:mc_hub/widgets/custom_appbar.dart';
import 'package:mc_hub/widgets/custom_background.dart';
import 'package:mc_hub/widgets/custom_rive_animation.dart';

// 専用ボックス
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
      appWindow.size = const Size(1200, 800);
      appWindow.alignment = Alignment.center;

      getHidDevice();

      return null;
    }, []);

    return CustomBackground(
      byRail: true,
      backGroundWidget: CustomRiveAnimation(
        size: Size.infinite,
        fileLoader: FileLoader.fromAsset(
          "assets/animations/background.riv",
          riveFactory: Factory.rive,
        ),
        artBoardName: "downLight",
        fit: Fit.scaleDown,
      ),
      foragroundWidget: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppbar(),
        body: Column(
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
                      fontWeight: FontWeight.bold,
                    ),
                // style: Theme.of(context).textTheme.titleLarge?.copyWith(
                //   fontSize: MediaQuery.of(context).size.height * 0.08,
                //   fontWeight: FontWeight.bold,
                // ),
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
                      return SelectDeviceContainer(
                          device: devices.value[index],
                        );
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
