// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vial_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

VialState _$VialStateFromJson(Map<String, dynamic> json) {
  return _VialState.fromJson(json);
}

/// @nodoc
mixin _$VialState {
  bool get isConnected => throw _privateConstructorUsedError;
  String? get statusMessage => throw _privateConstructorUsedError;
  Map<String, String> get keyMappings => throw _privateConstructorUsedError;
  List<List<List<int>>>? get matrix => throw _privateConstructorUsedError;

  /// Serializes this VialState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VialState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VialStateCopyWith<VialState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VialStateCopyWith<$Res> {
  factory $VialStateCopyWith(VialState value, $Res Function(VialState) then) =
      _$VialStateCopyWithImpl<$Res, VialState>;
  @useResult
  $Res call({
    bool isConnected,
    String? statusMessage,
    Map<String, String> keyMappings,
    List<List<List<int>>>? matrix,
  });
}

/// @nodoc
class _$VialStateCopyWithImpl<$Res, $Val extends VialState>
    implements $VialStateCopyWith<$Res> {
  _$VialStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VialState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConnected = null,
    Object? statusMessage = freezed,
    Object? keyMappings = null,
    Object? matrix = freezed,
  }) {
    return _then(
      _value.copyWith(
            isConnected:
                null == isConnected
                    ? _value.isConnected
                    : isConnected // ignore: cast_nullable_to_non_nullable
                        as bool,
            statusMessage:
                freezed == statusMessage
                    ? _value.statusMessage
                    : statusMessage // ignore: cast_nullable_to_non_nullable
                        as String?,
            keyMappings:
                null == keyMappings
                    ? _value.keyMappings
                    : keyMappings // ignore: cast_nullable_to_non_nullable
                        as Map<String, String>,
            matrix:
                freezed == matrix
                    ? _value.matrix
                    : matrix // ignore: cast_nullable_to_non_nullable
                        as List<List<List<int>>>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VialStateImplCopyWith<$Res>
    implements $VialStateCopyWith<$Res> {
  factory _$$VialStateImplCopyWith(
    _$VialStateImpl value,
    $Res Function(_$VialStateImpl) then,
  ) = __$$VialStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isConnected,
    String? statusMessage,
    Map<String, String> keyMappings,
    List<List<List<int>>>? matrix,
  });
}

/// @nodoc
class __$$VialStateImplCopyWithImpl<$Res>
    extends _$VialStateCopyWithImpl<$Res, _$VialStateImpl>
    implements _$$VialStateImplCopyWith<$Res> {
  __$$VialStateImplCopyWithImpl(
    _$VialStateImpl _value,
    $Res Function(_$VialStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VialState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConnected = null,
    Object? statusMessage = freezed,
    Object? keyMappings = null,
    Object? matrix = freezed,
  }) {
    return _then(
      _$VialStateImpl(
        isConnected:
            null == isConnected
                ? _value.isConnected
                : isConnected // ignore: cast_nullable_to_non_nullable
                    as bool,
        statusMessage:
            freezed == statusMessage
                ? _value.statusMessage
                : statusMessage // ignore: cast_nullable_to_non_nullable
                    as String?,
        keyMappings:
            null == keyMappings
                ? _value._keyMappings
                : keyMappings // ignore: cast_nullable_to_non_nullable
                    as Map<String, String>,
        matrix:
            freezed == matrix
                ? _value._matrix
                : matrix // ignore: cast_nullable_to_non_nullable
                    as List<List<List<int>>>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VialStateImpl implements _VialState {
  const _$VialStateImpl({
    this.isConnected = false,
    required this.statusMessage,
    final Map<String, String> keyMappings = const {},
    required final List<List<List<int>>>? matrix,
  }) : _keyMappings = keyMappings,
       _matrix = matrix;

  factory _$VialStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$VialStateImplFromJson(json);

  @override
  @JsonKey()
  final bool isConnected;
  @override
  final String? statusMessage;
  final Map<String, String> _keyMappings;
  @override
  @JsonKey()
  Map<String, String> get keyMappings {
    if (_keyMappings is EqualUnmodifiableMapView) return _keyMappings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_keyMappings);
  }

  final List<List<List<int>>>? _matrix;
  @override
  List<List<List<int>>>? get matrix {
    final value = _matrix;
    if (value == null) return null;
    if (_matrix is EqualUnmodifiableListView) return _matrix;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'VialState(isConnected: $isConnected, statusMessage: $statusMessage, keyMappings: $keyMappings, matrix: $matrix)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VialStateImpl &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.statusMessage, statusMessage) ||
                other.statusMessage == statusMessage) &&
            const DeepCollectionEquality().equals(
              other._keyMappings,
              _keyMappings,
            ) &&
            const DeepCollectionEquality().equals(other._matrix, _matrix));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    isConnected,
    statusMessage,
    const DeepCollectionEquality().hash(_keyMappings),
    const DeepCollectionEquality().hash(_matrix),
  );

  /// Create a copy of VialState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VialStateImplCopyWith<_$VialStateImpl> get copyWith =>
      __$$VialStateImplCopyWithImpl<_$VialStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VialStateImplToJson(this);
  }
}

abstract class _VialState implements VialState {
  const factory _VialState({
    final bool isConnected,
    required final String? statusMessage,
    final Map<String, String> keyMappings,
    required final List<List<List<int>>>? matrix,
  }) = _$VialStateImpl;

  factory _VialState.fromJson(Map<String, dynamic> json) =
      _$VialStateImpl.fromJson;

  @override
  bool get isConnected;
  @override
  String? get statusMessage;
  @override
  Map<String, String> get keyMappings;
  @override
  List<List<List<int>>>? get matrix;

  /// Create a copy of VialState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VialStateImplCopyWith<_$VialStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
