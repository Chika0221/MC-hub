part of '../deviceSelect_page.dart';

class SelectDeviceContainer extends HookConsumerWidget {
  const SelectDeviceContainer({super.key, required this.device});

  final HidDevice device;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final fileLoader = FileLoader.fromAsset(
      "assets/animations/fondKeyboard.riv",
      riveFactory: Factory.rive,
    );

    useEffect(() {
      return () {
        fileLoader.dispose();
      };
    }, []);

    return Container(
      width: MediaQuery.of(context).size.height * 0.7,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: RiveWidgetBuilder(
              fileLoader: fileLoader,
              builder:
                  (context, state) => switch (state) {
                    RiveLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    RiveFailed() => ErrorWidget.withDetails(
                      message: state.error.toString(),
                      error: FlutterError(state.error.toString()),
                    ),
                    RiveLoaded() => InkWell(
                      onTap: () async {
                        await Future.delayed(Duration(milliseconds: 100));
                        Navigator.of(context).pushNamed(AppRoute.editor.path);
                        ref.read(vialProvider.notifier).connect();
                      },
                      child: RiveWidget(
                        controller: state.controller,
                        fit: Fit.contain,
                      ),
                    ),
                  },
            ),
          ),
          SizedBox(height: 16),
          Text(
            device.productName,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SizedBox(height: 16),
          Container(
            decoration: ShapeDecoration(
              shape: StadiumBorder(
                side: BorderSide(
                  width: 4.0,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "0x${device.vendorId.toRadixString(16)} : 0x${device.productId.toRadixString(16)}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
