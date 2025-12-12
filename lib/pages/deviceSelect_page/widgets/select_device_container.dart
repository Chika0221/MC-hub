part of '../deviceSelect_page.dart';

class SelectDeviceContainer extends HookConsumerWidget {
  const SelectDeviceContainer({super.key});
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

    return GlassContainer.clearGlass(
      width: MediaQuery.of(context).size.height * 0.7,
      height: MediaQuery.of(context).size.height * 0.6,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(10),
      //   color: Theme.of(context).colorScheme.surfaceContainer,
      //   border: Border.all(
      //     color: Theme.of(context).colorScheme.primary,
      //     width: 1,
      //   ),
      // ),
      // borderRadius: BorderRadius.circular(10),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.of(context).pushNamed(AppRoute.editor.path);
        },
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
                RiveLoaded() => RiveWidget(
                  controller: state.controller,
                  fit: Fit.contain,
                ),
              },
        ),
      ),
    );
  }
}
