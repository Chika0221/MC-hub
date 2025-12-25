// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MyDevice {
  String get name => throw _privateConstructorUsedError;
  int get vendorId => throw _privateConstructorUsedError;
  int get productId => throw _privateConstructorUsedError;
  int get usegePage => throw _privateConstructorUsedError;
  int get usege => throw _privateConstructorUsedError;
  List<List<KeyData>> get keys => throw _privateConstructorUsedError;

  /// Create a copy of MyDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MyDeviceCopyWith<MyDevice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyDeviceCopyWith<$Res> {
  factory $MyDeviceCopyWith(MyDevice value, $Res Function(MyDevice) then) =
      _$MyDeviceCopyWithImpl<$Res, MyDevice>;
  @useResult
  $Res call({
    String name,
    int vendorId,
    int productId,
    int usegePage,
    int usege,
    List<List<KeyData>> keys,
  });
}

/// @nodoc
class _$MyDeviceCopyWithImpl<$Res, $Val extends MyDevice>
    implements $MyDeviceCopyWith<$Res> {
  _$MyDeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? vendorId = null,
    Object? productId = null,
    Object? usegePage = null,
    Object? usege = null,
    Object? keys = null,
  }) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            vendorId:
                null == vendorId
                    ? _value.vendorId
                    : vendorId // ignore: cast_nullable_to_non_nullable
                        as int,
            productId:
                null == productId
                    ? _value.productId
                    : productId // ignore: cast_nullable_to_non_nullable
                        as int,
            usegePage:
                null == usegePage
                    ? _value.usegePage
                    : usegePage // ignore: cast_nullable_to_non_nullable
                        as int,
            usege:
                null == usege
                    ? _value.usege
                    : usege // ignore: cast_nullable_to_non_nullable
                        as int,
            keys:
                null == keys
                    ? _value.keys
                    : keys // ignore: cast_nullable_to_non_nullable
                        as List<List<KeyData>>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MyDeviceImplCopyWith<$Res>
    implements $MyDeviceCopyWith<$Res> {
  factory _$$MyDeviceImplCopyWith(
    _$MyDeviceImpl value,
    $Res Function(_$MyDeviceImpl) then,
  ) = __$$MyDeviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    int vendorId,
    int productId,
    int usegePage,
    int usege,
    List<List<KeyData>> keys,
  });
}

/// @nodoc
class __$$MyDeviceImplCopyWithImpl<$Res>
    extends _$MyDeviceCopyWithImpl<$Res, _$MyDeviceImpl>
    implements _$$MyDeviceImplCopyWith<$Res> {
  __$$MyDeviceImplCopyWithImpl(
    _$MyDeviceImpl _value,
    $Res Function(_$MyDeviceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? vendorId = null,
    Object? productId = null,
    Object? usegePage = null,
    Object? usege = null,
    Object? keys = null,
  }) {
    return _then(
      _$MyDeviceImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        vendorId:
            null == vendorId
                ? _value.vendorId
                : vendorId // ignore: cast_nullable_to_non_nullable
                    as int,
        productId:
            null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                    as int,
        usegePage:
            null == usegePage
                ? _value.usegePage
                : usegePage // ignore: cast_nullable_to_non_nullable
                    as int,
        usege:
            null == usege
                ? _value.usege
                : usege // ignore: cast_nullable_to_non_nullable
                    as int,
        keys:
            null == keys
                ? _value._keys
                : keys // ignore: cast_nullable_to_non_nullable
                    as List<List<KeyData>>,
      ),
    );
  }
}

/// @nodoc

class _$MyDeviceImpl implements _MyDevice {
  const _$MyDeviceImpl({
    required this.name,
    required this.vendorId,
    required this.productId,
    required this.usegePage,
    required this.usege,
    required final List<List<KeyData>> keys,
  }) : _keys = keys;

  @override
  final String name;
  @override
  final int vendorId;
  @override
  final int productId;
  @override
  final int usegePage;
  @override
  final int usege;
  final List<List<KeyData>> _keys;
  @override
  List<List<KeyData>> get keys {
    if (_keys is EqualUnmodifiableListView) return _keys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keys);
  }

  @override
  String toString() {
    return 'MyDevice(name: $name, vendorId: $vendorId, productId: $productId, usegePage: $usegePage, usege: $usege, keys: $keys)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyDeviceImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.vendorId, vendorId) ||
                other.vendorId == vendorId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.usegePage, usegePage) ||
                other.usegePage == usegePage) &&
            (identical(other.usege, usege) || other.usege == usege) &&
            const DeepCollectionEquality().equals(other._keys, _keys));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    vendorId,
    productId,
    usegePage,
    usege,
    const DeepCollectionEquality().hash(_keys),
  );

  /// Create a copy of MyDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyDeviceImplCopyWith<_$MyDeviceImpl> get copyWith =>
      __$$MyDeviceImplCopyWithImpl<_$MyDeviceImpl>(this, _$identity);
}

abstract class _MyDevice implements MyDevice {
  const factory _MyDevice({
    required final String name,
    required final int vendorId,
    required final int productId,
    required final int usegePage,
    required final int usege,
    required final List<List<KeyData>> keys,
  }) = _$MyDeviceImpl;

  @override
  String get name;
  @override
  int get vendorId;
  @override
  int get productId;
  @override
  int get usegePage;
  @override
  int get usege;
  @override
  List<List<KeyData>> get keys;

  /// Create a copy of MyDevice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyDeviceImplCopyWith<_$MyDeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
