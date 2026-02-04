// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:mc_hub/infrastructure/hooks/virtual_key_codes.dart';

void main() {
  test('Maps known VK codes', () {
    expect(VirtualKeyCode.tryFromVkCode(0x70), VirtualKeyCode.f1);
    expect(VirtualKeyCode.tryFromVkCode(0x7B), VirtualKeyCode.f12);
    expect(VirtualKeyCode.keyA.vkCode, 0x41);
  });

  test('Excludes VK_F13..VK_F24 (reserved for macros)', () {
    expect(VirtualKeyCode.tryFromVkCode(0x7C), isNull);
    expect(VirtualKeyCode.tryFromVkCode(0x87), isNull);
  });
}
