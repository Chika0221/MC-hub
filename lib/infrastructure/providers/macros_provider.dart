// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/models/macro.dart';

class MacrosNotifier extends Notifier<List<Macro?>> {
  @override
  build() {
    return [];
  }
}

final macrosProvider =
    NotifierProvider.autoDispose<MacrosNotifier, List<Macro?>>(
      MacrosNotifier.new,
    );

class MacrosStreamNotifier extends StreamNotifier<List<Macro?>> {
  @override
  Stream<List<Macro?>> build() async* {}
}


// TODO: ストリームプロバイダーの実装