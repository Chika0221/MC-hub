// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:mc_hub/pages/editor_page/key_data.dart';

part 'my_device.freezed.dart';

@freezed
class MyDevice with _$MyDevice {
  const factory MyDevice({
    required String name,
    required int vendorId,
    required int productId,
    required int usegePage,
    required int usege,
    required List<KeyData> keys,
  }) = _MyDevice;

  // factory MyDevice.fromJson(Map<String, dynamic> json) =>
  //     _$MyDeviceFromJson(json);
}
