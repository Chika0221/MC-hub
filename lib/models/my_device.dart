// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_device.freezed.dart';
part 'my_device.g.dart';

@freezed
class MyDevice with _$MyDevice {
  const factory MyDevice({
    required String name,
    required int vendorId,
    required int productId,
    required int usegePage,
    required int usege,
  }) = _MyDevice;

  factory MyDevice.fromJson(Map<String, dynamic> json) =>
      _$MyDeviceFromJson(json);
}
