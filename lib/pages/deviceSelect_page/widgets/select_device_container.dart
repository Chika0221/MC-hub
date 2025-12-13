part of '../deviceSelect_page.dart';

class SelectDeviceContainer extends HookConsumerWidget {
  const SelectDeviceContainer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final fileLoader = FileLoader.fromAsset(
      "assets/animations/fondKeyboard.riv",
      riveFactory: Factory.rive,
    );

    // late final riveController;
    // late final file;

    // void initRive() async {
    //   file = await File.asset(
    //     "assets/animations/fondKeyboard.riv",
    //     riveFactory: Factory.rive,
    //   );

    //   riveController = useMemoized(
    //     () => RiveWidgetController(
    //       file,
    //       stateMachineSelector: StateMachineSelector.byIndex(0),
    //     ),
    //     [],
    //   );
    // }

    useEffect(() {
      // initRive();

      return () {
        fileLoader.dispose();
      };
    }, []);

    return GlassContainer.clearGlass(
      width: MediaQuery.of(context).size.height * 0.7,
      height: MediaQuery.of(context).size.height * 0.6,
      borderRadius: BorderRadius.circular(10),
      child: RiveWidgetBuilder(
        fileLoader: fileLoader,
        builder:
            (context, state) => switch (state) {
              RiveLoading() => const Center(child: CircularProgressIndicator()),
              RiveFailed() => ErrorWidget.withDetails(
                message: state.error.toString(),
                error: FlutterError(state.error.toString()),
              ),
              RiveLoaded() => InkWell(
                onTap: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  Navigator.of(context).pushNamed(AppRoute.editor.path);
                },
                child: RiveWidget(
                  controller: state.controller,
                  fit: Fit.contain,
                ),
              ),
            },
      ),
    );
  }
}
