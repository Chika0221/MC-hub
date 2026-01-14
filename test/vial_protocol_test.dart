// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/vial_provider.dart';

void main() {
  test('Keycode conversion logic verification', () {
      // Test the actual implementation in VialNotifier
      expect(VialNotifier.labelToKeycode("A"), 0x04);
      expect(VialNotifier.labelToKeycode("Esc"), 0x29);
      expect(VialNotifier.labelToKeycode("1"), 0x1E);
      expect(VialNotifier.labelToKeycode("UnknownKey"), 0x00);
  });

  test('Matrix mapping structure verification', () {
      // Check that critical keys are mapped using the actual map
      final map = VialNotifier.keyIdToMatrix;

      expect(map["k41"], [0, 0], reason: "Esc should be at 0,0");
      expect(map["k30"], [0, 1], reason: "1 should be at 0,1");

      // Verify we have a decent number of keys mapped
      expect(map.length, greaterThan(50));
  });
}
