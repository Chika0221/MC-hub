// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rive/rive.dart';

// Project imports:
import 'package:mc_hub/models/unregistered_code.dart';

class StateAnimation extends HookConsumerWidget {
  const StateAnimation({super.key, required this.state});

  final CodeRegisteredState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileLoader = FileLoader.fromAsset(
      "assets/animations/unregister_code_state.riv",
      riveFactory: Factory.rive,
    );

    final size = MediaQuery.sizeOf(context);

    useEffect(() {
      return () {
        fileLoader.dispose();
      };
    }, []);

    return SizedBox(
      width: size.width * 0.3,
      height: size.width * 0.3,
      child: RiveWidgetBuilder(
        fileLoader: fileLoader,
        artboardSelector: ArtboardSelector.byName(state.name),
        builder:
            (context, state) => switch (state) {
              RiveLoading() => const Center(child: CircularProgressIndicator()),
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
    );
  }
}
