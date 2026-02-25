// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connect.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Connect _$ConnectFromJson(Map<String, dynamic> json) {
  return _Connect.fromJson(json);
}

/// @nodoc
mixin _$Connect {
  ConnectHost get host => throw _privateConstructorUsedError;
  ConnectController? get controllerID => throw _privateConstructorUsedError;
  List<Macro>? get macroQueue => throw _privateConstructorUsedError;
  List<Workflow>? get workflowQueue => throw _privateConstructorUsedError;

  /// Serializes this Connect to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Connect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectCopyWith<Connect> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectCopyWith<$Res> {
  factory $ConnectCopyWith(Connect value, $Res Function(Connect) then) =
      _$ConnectCopyWithImpl<$Res, Connect>;
  @useResult
  $Res call({
    ConnectHost host,
    ConnectController? controllerID,
    List<Macro>? macroQueue,
    List<Workflow>? workflowQueue,
  });

  $ConnectHostCopyWith<$Res> get host;
  $ConnectControllerCopyWith<$Res>? get controllerID;
}

/// @nodoc
class _$ConnectCopyWithImpl<$Res, $Val extends Connect>
    implements $ConnectCopyWith<$Res> {
  _$ConnectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Connect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? controllerID = freezed,
    Object? macroQueue = freezed,
    Object? workflowQueue = freezed,
  }) {
    return _then(
      _value.copyWith(
            host:
                null == host
                    ? _value.host
                    : host // ignore: cast_nullable_to_non_nullable
                        as ConnectHost,
            controllerID:
                freezed == controllerID
                    ? _value.controllerID
                    : controllerID // ignore: cast_nullable_to_non_nullable
                        as ConnectController?,
            macroQueue:
                freezed == macroQueue
                    ? _value.macroQueue
                    : macroQueue // ignore: cast_nullable_to_non_nullable
                        as List<Macro>?,
            workflowQueue:
                freezed == workflowQueue
                    ? _value.workflowQueue
                    : workflowQueue // ignore: cast_nullable_to_non_nullable
                        as List<Workflow>?,
          )
          as $Val,
    );
  }

  /// Create a copy of Connect
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectHostCopyWith<$Res> get host {
    return $ConnectHostCopyWith<$Res>(_value.host, (value) {
      return _then(_value.copyWith(host: value) as $Val);
    });
  }

  /// Create a copy of Connect
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectControllerCopyWith<$Res>? get controllerID {
    if (_value.controllerID == null) {
      return null;
    }

    return $ConnectControllerCopyWith<$Res>(_value.controllerID!, (value) {
      return _then(_value.copyWith(controllerID: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConnectImplCopyWith<$Res> implements $ConnectCopyWith<$Res> {
  factory _$$ConnectImplCopyWith(
    _$ConnectImpl value,
    $Res Function(_$ConnectImpl) then,
  ) = __$$ConnectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ConnectHost host,
    ConnectController? controllerID,
    List<Macro>? macroQueue,
    List<Workflow>? workflowQueue,
  });

  @override
  $ConnectHostCopyWith<$Res> get host;
  @override
  $ConnectControllerCopyWith<$Res>? get controllerID;
}

/// @nodoc
class __$$ConnectImplCopyWithImpl<$Res>
    extends _$ConnectCopyWithImpl<$Res, _$ConnectImpl>
    implements _$$ConnectImplCopyWith<$Res> {
  __$$ConnectImplCopyWithImpl(
    _$ConnectImpl _value,
    $Res Function(_$ConnectImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Connect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? controllerID = freezed,
    Object? macroQueue = freezed,
    Object? workflowQueue = freezed,
  }) {
    return _then(
      _$ConnectImpl(
        host:
            null == host
                ? _value.host
                : host // ignore: cast_nullable_to_non_nullable
                    as ConnectHost,
        controllerID:
            freezed == controllerID
                ? _value.controllerID
                : controllerID // ignore: cast_nullable_to_non_nullable
                    as ConnectController?,
        macroQueue:
            freezed == macroQueue
                ? _value._macroQueue
                : macroQueue // ignore: cast_nullable_to_non_nullable
                    as List<Macro>?,
        workflowQueue:
            freezed == workflowQueue
                ? _value._workflowQueue
                : workflowQueue // ignore: cast_nullable_to_non_nullable
                    as List<Workflow>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectImpl implements _Connect {
  const _$ConnectImpl({
    required this.host,
    required this.controllerID,
    final List<Macro>? macroQueue,
    final List<Workflow>? workflowQueue,
  }) : _macroQueue = macroQueue,
       _workflowQueue = workflowQueue;

  factory _$ConnectImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectImplFromJson(json);

  @override
  final ConnectHost host;
  @override
  final ConnectController? controllerID;
  final List<Macro>? _macroQueue;
  @override
  List<Macro>? get macroQueue {
    final value = _macroQueue;
    if (value == null) return null;
    if (_macroQueue is EqualUnmodifiableListView) return _macroQueue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Workflow>? _workflowQueue;
  @override
  List<Workflow>? get workflowQueue {
    final value = _workflowQueue;
    if (value == null) return null;
    if (_workflowQueue is EqualUnmodifiableListView) return _workflowQueue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Connect(host: $host, controllerID: $controllerID, macroQueue: $macroQueue, workflowQueue: $workflowQueue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectImpl &&
            (identical(other.host, host) || other.host == host) &&
            (identical(other.controllerID, controllerID) ||
                other.controllerID == controllerID) &&
            const DeepCollectionEquality().equals(
              other._macroQueue,
              _macroQueue,
            ) &&
            const DeepCollectionEquality().equals(
              other._workflowQueue,
              _workflowQueue,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    host,
    controllerID,
    const DeepCollectionEquality().hash(_macroQueue),
    const DeepCollectionEquality().hash(_workflowQueue),
  );

  /// Create a copy of Connect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectImplCopyWith<_$ConnectImpl> get copyWith =>
      __$$ConnectImplCopyWithImpl<_$ConnectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectImplToJson(this);
  }
}

abstract class _Connect implements Connect {
  const factory _Connect({
    required final ConnectHost host,
    required final ConnectController? controllerID,
    final List<Macro>? macroQueue,
    final List<Workflow>? workflowQueue,
  }) = _$ConnectImpl;

  factory _Connect.fromJson(Map<String, dynamic> json) = _$ConnectImpl.fromJson;

  @override
  ConnectHost get host;
  @override
  ConnectController? get controllerID;
  @override
  List<Macro>? get macroQueue;
  @override
  List<Workflow>? get workflowQueue;

  /// Create a copy of Connect
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectImplCopyWith<_$ConnectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConnectHost _$ConnectHostFromJson(Map<String, dynamic> json) {
  return _ConnectHost.fromJson(json);
}

/// @nodoc
mixin _$ConnectHost {
  String get hostID => throw _privateConstructorUsedError;
  String get hostName => throw _privateConstructorUsedError;

  /// Serializes this ConnectHost to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConnectHost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectHostCopyWith<ConnectHost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectHostCopyWith<$Res> {
  factory $ConnectHostCopyWith(
    ConnectHost value,
    $Res Function(ConnectHost) then,
  ) = _$ConnectHostCopyWithImpl<$Res, ConnectHost>;
  @useResult
  $Res call({String hostID, String hostName});
}

/// @nodoc
class _$ConnectHostCopyWithImpl<$Res, $Val extends ConnectHost>
    implements $ConnectHostCopyWith<$Res> {
  _$ConnectHostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectHost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? hostID = null, Object? hostName = null}) {
    return _then(
      _value.copyWith(
            hostID:
                null == hostID
                    ? _value.hostID
                    : hostID // ignore: cast_nullable_to_non_nullable
                        as String,
            hostName:
                null == hostName
                    ? _value.hostName
                    : hostName // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConnectHostImplCopyWith<$Res>
    implements $ConnectHostCopyWith<$Res> {
  factory _$$ConnectHostImplCopyWith(
    _$ConnectHostImpl value,
    $Res Function(_$ConnectHostImpl) then,
  ) = __$$ConnectHostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String hostID, String hostName});
}

/// @nodoc
class __$$ConnectHostImplCopyWithImpl<$Res>
    extends _$ConnectHostCopyWithImpl<$Res, _$ConnectHostImpl>
    implements _$$ConnectHostImplCopyWith<$Res> {
  __$$ConnectHostImplCopyWithImpl(
    _$ConnectHostImpl _value,
    $Res Function(_$ConnectHostImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectHost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? hostID = null, Object? hostName = null}) {
    return _then(
      _$ConnectHostImpl(
        hostID:
            null == hostID
                ? _value.hostID
                : hostID // ignore: cast_nullable_to_non_nullable
                    as String,
        hostName:
            null == hostName
                ? _value.hostName
                : hostName // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectHostImpl implements _ConnectHost {
  const _$ConnectHostImpl({required this.hostID, required this.hostName});

  factory _$ConnectHostImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectHostImplFromJson(json);

  @override
  final String hostID;
  @override
  final String hostName;

  @override
  String toString() {
    return 'ConnectHost(hostID: $hostID, hostName: $hostName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectHostImpl &&
            (identical(other.hostID, hostID) || other.hostID == hostID) &&
            (identical(other.hostName, hostName) ||
                other.hostName == hostName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, hostID, hostName);

  /// Create a copy of ConnectHost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectHostImplCopyWith<_$ConnectHostImpl> get copyWith =>
      __$$ConnectHostImplCopyWithImpl<_$ConnectHostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectHostImplToJson(this);
  }
}

abstract class _ConnectHost implements ConnectHost {
  const factory _ConnectHost({
    required final String hostID,
    required final String hostName,
  }) = _$ConnectHostImpl;

  factory _ConnectHost.fromJson(Map<String, dynamic> json) =
      _$ConnectHostImpl.fromJson;

  @override
  String get hostID;
  @override
  String get hostName;

  /// Create a copy of ConnectHost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectHostImplCopyWith<_$ConnectHostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConnectController _$ConnectControllerFromJson(Map<String, dynamic> json) {
  return _ConnectController.fromJson(json);
}

/// @nodoc
mixin _$ConnectController {
  String get controllerID => throw _privateConstructorUsedError;
  String get controllerName => throw _privateConstructorUsedError;

  /// Serializes this ConnectController to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConnectController
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectControllerCopyWith<ConnectController> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectControllerCopyWith<$Res> {
  factory $ConnectControllerCopyWith(
    ConnectController value,
    $Res Function(ConnectController) then,
  ) = _$ConnectControllerCopyWithImpl<$Res, ConnectController>;
  @useResult
  $Res call({String controllerID, String controllerName});
}

/// @nodoc
class _$ConnectControllerCopyWithImpl<$Res, $Val extends ConnectController>
    implements $ConnectControllerCopyWith<$Res> {
  _$ConnectControllerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectController
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? controllerID = null, Object? controllerName = null}) {
    return _then(
      _value.copyWith(
            controllerID:
                null == controllerID
                    ? _value.controllerID
                    : controllerID // ignore: cast_nullable_to_non_nullable
                        as String,
            controllerName:
                null == controllerName
                    ? _value.controllerName
                    : controllerName // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConnectControllerImplCopyWith<$Res>
    implements $ConnectControllerCopyWith<$Res> {
  factory _$$ConnectControllerImplCopyWith(
    _$ConnectControllerImpl value,
    $Res Function(_$ConnectControllerImpl) then,
  ) = __$$ConnectControllerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String controllerID, String controllerName});
}

/// @nodoc
class __$$ConnectControllerImplCopyWithImpl<$Res>
    extends _$ConnectControllerCopyWithImpl<$Res, _$ConnectControllerImpl>
    implements _$$ConnectControllerImplCopyWith<$Res> {
  __$$ConnectControllerImplCopyWithImpl(
    _$ConnectControllerImpl _value,
    $Res Function(_$ConnectControllerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectController
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? controllerID = null, Object? controllerName = null}) {
    return _then(
      _$ConnectControllerImpl(
        controllerID:
            null == controllerID
                ? _value.controllerID
                : controllerID // ignore: cast_nullable_to_non_nullable
                    as String,
        controllerName:
            null == controllerName
                ? _value.controllerName
                : controllerName // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectControllerImpl implements _ConnectController {
  const _$ConnectControllerImpl({
    required this.controllerID,
    required this.controllerName,
  });

  factory _$ConnectControllerImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectControllerImplFromJson(json);

  @override
  final String controllerID;
  @override
  final String controllerName;

  @override
  String toString() {
    return 'ConnectController(controllerID: $controllerID, controllerName: $controllerName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectControllerImpl &&
            (identical(other.controllerID, controllerID) ||
                other.controllerID == controllerID) &&
            (identical(other.controllerName, controllerName) ||
                other.controllerName == controllerName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, controllerID, controllerName);

  /// Create a copy of ConnectController
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectControllerImplCopyWith<_$ConnectControllerImpl> get copyWith =>
      __$$ConnectControllerImplCopyWithImpl<_$ConnectControllerImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectControllerImplToJson(this);
  }
}

abstract class _ConnectController implements ConnectController {
  const factory _ConnectController({
    required final String controllerID,
    required final String controllerName,
  }) = _$ConnectControllerImpl;

  factory _ConnectController.fromJson(Map<String, dynamic> json) =
      _$ConnectControllerImpl.fromJson;

  @override
  String get controllerID;
  @override
  String get controllerName;

  /// Create a copy of ConnectController
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectControllerImplCopyWith<_$ConnectControllerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
