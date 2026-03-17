// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'key_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

KeyProfile _$KeyProfileFromJson(Map<String, dynamic> json) {
  return _KeyProfile.fromJson(json);
}

/// @nodoc
mixin _$KeyProfile {
  String get Name => throw _privateConstructorUsedError;
  String get Id => throw _privateConstructorUsedError;
  Map<String, String> get keyMappings => throw _privateConstructorUsedError;

  /// Serializes this KeyProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KeyProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KeyProfileCopyWith<KeyProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeyProfileCopyWith<$Res> {
  factory $KeyProfileCopyWith(
    KeyProfile value,
    $Res Function(KeyProfile) then,
  ) = _$KeyProfileCopyWithImpl<$Res, KeyProfile>;
  @useResult
  $Res call({String Name, String Id, Map<String, String> keyMappings});
}

/// @nodoc
class _$KeyProfileCopyWithImpl<$Res, $Val extends KeyProfile>
    implements $KeyProfileCopyWith<$Res> {
  _$KeyProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KeyProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? Name = null,
    Object? Id = null,
    Object? keyMappings = null,
  }) {
    return _then(
      _value.copyWith(
            Name:
                null == Name
                    ? _value.Name
                    : Name // ignore: cast_nullable_to_non_nullable
                        as String,
            Id:
                null == Id
                    ? _value.Id
                    : Id // ignore: cast_nullable_to_non_nullable
                        as String,
            keyMappings:
                null == keyMappings
                    ? _value.keyMappings
                    : keyMappings // ignore: cast_nullable_to_non_nullable
                        as Map<String, String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$KeyProfileImplCopyWith<$Res>
    implements $KeyProfileCopyWith<$Res> {
  factory _$$KeyProfileImplCopyWith(
    _$KeyProfileImpl value,
    $Res Function(_$KeyProfileImpl) then,
  ) = __$$KeyProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String Name, String Id, Map<String, String> keyMappings});
}

/// @nodoc
class __$$KeyProfileImplCopyWithImpl<$Res>
    extends _$KeyProfileCopyWithImpl<$Res, _$KeyProfileImpl>
    implements _$$KeyProfileImplCopyWith<$Res> {
  __$$KeyProfileImplCopyWithImpl(
    _$KeyProfileImpl _value,
    $Res Function(_$KeyProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of KeyProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? Name = null,
    Object? Id = null,
    Object? keyMappings = null,
  }) {
    return _then(
      _$KeyProfileImpl(
        Name:
            null == Name
                ? _value.Name
                : Name // ignore: cast_nullable_to_non_nullable
                    as String,
        Id:
            null == Id
                ? _value.Id
                : Id // ignore: cast_nullable_to_non_nullable
                    as String,
        keyMappings:
            null == keyMappings
                ? _value._keyMappings
                : keyMappings // ignore: cast_nullable_to_non_nullable
                    as Map<String, String>,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$KeyProfileImpl implements _KeyProfile {
  const _$KeyProfileImpl({
    required this.Name,
    required this.Id,
    required final Map<String, String> keyMappings,
  }) : _keyMappings = keyMappings;

  factory _$KeyProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$KeyProfileImplFromJson(json);

  @override
  final String Name;
  @override
  final String Id;
  final Map<String, String> _keyMappings;
  @override
  Map<String, String> get keyMappings {
    if (_keyMappings is EqualUnmodifiableMapView) return _keyMappings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_keyMappings);
  }

  @override
  String toString() {
    return 'KeyProfile(Name: $Name, Id: $Id, keyMappings: $keyMappings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeyProfileImpl &&
            (identical(other.Name, Name) || other.Name == Name) &&
            (identical(other.Id, Id) || other.Id == Id) &&
            const DeepCollectionEquality().equals(
              other._keyMappings,
              _keyMappings,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    Name,
    Id,
    const DeepCollectionEquality().hash(_keyMappings),
  );

  /// Create a copy of KeyProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KeyProfileImplCopyWith<_$KeyProfileImpl> get copyWith =>
      __$$KeyProfileImplCopyWithImpl<_$KeyProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KeyProfileImplToJson(this);
  }
}

abstract class _KeyProfile implements KeyProfile {
  const factory _KeyProfile({
    required final String Name,
    required final String Id,
    required final Map<String, String> keyMappings,
  }) = _$KeyProfileImpl;

  factory _KeyProfile.fromJson(Map<String, dynamic> json) =
      _$KeyProfileImpl.fromJson;

  @override
  String get Name;
  @override
  String get Id;
  @override
  Map<String, String> get keyMappings;

  /// Create a copy of KeyProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KeyProfileImplCopyWith<_$KeyProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppLayer _$AppLayerFromJson(Map<String, dynamic> json) {
  return _AppLayer.fromJson(json);
}

/// @nodoc
mixin _$AppLayer {
  String get Name => throw _privateConstructorUsedError;
  String get Id => throw _privateConstructorUsedError;
  String get appPath => throw _privateConstructorUsedError;
  bool get isFocus => throw _privateConstructorUsedError;
  List<Macro?> get macros => throw _privateConstructorUsedError;

  /// Serializes this AppLayer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppLayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppLayerCopyWith<AppLayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppLayerCopyWith<$Res> {
  factory $AppLayerCopyWith(AppLayer value, $Res Function(AppLayer) then) =
      _$AppLayerCopyWithImpl<$Res, AppLayer>;
  @useResult
  $Res call({
    String Name,
    String Id,
    String appPath,
    bool isFocus,
    List<Macro?> macros,
  });
}

/// @nodoc
class _$AppLayerCopyWithImpl<$Res, $Val extends AppLayer>
    implements $AppLayerCopyWith<$Res> {
  _$AppLayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppLayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? Name = null,
    Object? Id = null,
    Object? appPath = null,
    Object? isFocus = null,
    Object? macros = null,
  }) {
    return _then(
      _value.copyWith(
            Name:
                null == Name
                    ? _value.Name
                    : Name // ignore: cast_nullable_to_non_nullable
                        as String,
            Id:
                null == Id
                    ? _value.Id
                    : Id // ignore: cast_nullable_to_non_nullable
                        as String,
            appPath:
                null == appPath
                    ? _value.appPath
                    : appPath // ignore: cast_nullable_to_non_nullable
                        as String,
            isFocus:
                null == isFocus
                    ? _value.isFocus
                    : isFocus // ignore: cast_nullable_to_non_nullable
                        as bool,
            macros:
                null == macros
                    ? _value.macros
                    : macros // ignore: cast_nullable_to_non_nullable
                        as List<Macro?>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppLayerImplCopyWith<$Res>
    implements $AppLayerCopyWith<$Res> {
  factory _$$AppLayerImplCopyWith(
    _$AppLayerImpl value,
    $Res Function(_$AppLayerImpl) then,
  ) = __$$AppLayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String Name,
    String Id,
    String appPath,
    bool isFocus,
    List<Macro?> macros,
  });
}

/// @nodoc
class __$$AppLayerImplCopyWithImpl<$Res>
    extends _$AppLayerCopyWithImpl<$Res, _$AppLayerImpl>
    implements _$$AppLayerImplCopyWith<$Res> {
  __$$AppLayerImplCopyWithImpl(
    _$AppLayerImpl _value,
    $Res Function(_$AppLayerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppLayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? Name = null,
    Object? Id = null,
    Object? appPath = null,
    Object? isFocus = null,
    Object? macros = null,
  }) {
    return _then(
      _$AppLayerImpl(
        Name:
            null == Name
                ? _value.Name
                : Name // ignore: cast_nullable_to_non_nullable
                    as String,
        Id:
            null == Id
                ? _value.Id
                : Id // ignore: cast_nullable_to_non_nullable
                    as String,
        appPath:
            null == appPath
                ? _value.appPath
                : appPath // ignore: cast_nullable_to_non_nullable
                    as String,
        isFocus:
            null == isFocus
                ? _value.isFocus
                : isFocus // ignore: cast_nullable_to_non_nullable
                    as bool,
        macros:
            null == macros
                ? _value._macros
                : macros // ignore: cast_nullable_to_non_nullable
                    as List<Macro?>,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$AppLayerImpl implements _AppLayer {
  const _$AppLayerImpl({
    required this.Name,
    required this.Id,
    required this.appPath,
    required this.isFocus,
    final List<Macro?> macros = const <Macro?>[
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
    ],
  }) : _macros = macros;

  factory _$AppLayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppLayerImplFromJson(json);

  @override
  final String Name;
  @override
  final String Id;
  @override
  final String appPath;
  @override
  final bool isFocus;
  final List<Macro?> _macros;
  @override
  @JsonKey()
  List<Macro?> get macros {
    if (_macros is EqualUnmodifiableListView) return _macros;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_macros);
  }

  @override
  String toString() {
    return 'AppLayer(Name: $Name, Id: $Id, appPath: $appPath, isFocus: $isFocus, macros: $macros)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppLayerImpl &&
            (identical(other.Name, Name) || other.Name == Name) &&
            (identical(other.Id, Id) || other.Id == Id) &&
            (identical(other.appPath, appPath) || other.appPath == appPath) &&
            (identical(other.isFocus, isFocus) || other.isFocus == isFocus) &&
            const DeepCollectionEquality().equals(other._macros, _macros));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    Name,
    Id,
    appPath,
    isFocus,
    const DeepCollectionEquality().hash(_macros),
  );

  /// Create a copy of AppLayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppLayerImplCopyWith<_$AppLayerImpl> get copyWith =>
      __$$AppLayerImplCopyWithImpl<_$AppLayerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppLayerImplToJson(this);
  }
}

abstract class _AppLayer implements AppLayer {
  const factory _AppLayer({
    required final String Name,
    required final String Id,
    required final String appPath,
    required final bool isFocus,
    final List<Macro?> macros,
  }) = _$AppLayerImpl;

  factory _AppLayer.fromJson(Map<String, dynamic> json) =
      _$AppLayerImpl.fromJson;

  @override
  String get Name;
  @override
  String get Id;
  @override
  String get appPath;
  @override
  bool get isFocus;
  @override
  List<Macro?> get macros;

  /// Create a copy of AppLayer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppLayerImplCopyWith<_$AppLayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
