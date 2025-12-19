// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MyDeviceImpl _$$MyDeviceImplFromJson(Map<String, dynamic> json) =>
    _$MyDeviceImpl(
      name: json['name'] as String,
      vendorId: (json['vendorId'] as num).toInt(),
      productId: (json['productId'] as num).toInt(),
      usegePage: (json['usegePage'] as num).toInt(),
      usege: (json['usege'] as num).toInt(),
    );

Map<String, dynamic> _$$MyDeviceImplToJson(_$MyDeviceImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'vendorId': instance.vendorId,
      'productId': instance.productId,
      'usegePage': instance.usegePage,
      'usege': instance.usege,
    };
