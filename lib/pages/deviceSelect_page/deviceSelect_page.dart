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
        
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 16,
                children:
                    devices.value
                        .map((device) => SelectDeviceContainer(device: device))
                        .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
