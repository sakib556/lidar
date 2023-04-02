// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'api_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ApiStateTearOff {
  const _$ApiStateTearOff();

  _ApiStateinitial<T> initial<T>() {
    return _ApiStateinitial<T>();
  }

  _ApiStateloading<T> loading<T>() {
    return _ApiStateloading<T>();
  }

  _ApiStateloaded<T> loaded<T>({required T data}) {
    return _ApiStateloaded<T>(
      data: data,
    );
  }

  _ApiStateerror<T> error<T>({required String error}) {
    return _ApiStateerror<T>(
      error: error,
    );
  }
}

/// @nodoc
const $ApiState = _$ApiStateTearOff();

/// @nodoc
mixin _$ApiState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ApiStateinitial<T> value) initial,
    required TResult Function(_ApiStateloading<T> value) loading,
    required TResult Function(_ApiStateloaded<T> value) loaded,
    required TResult Function(_ApiStateerror<T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ApiStateinitial<T> value)? initial,
    TResult Function(_ApiStateloading<T> value)? loading,
    TResult Function(_ApiStateloaded<T> value)? loaded,
    TResult Function(_ApiStateerror<T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ApiStateinitial<T> value)? initial,
    TResult Function(_ApiStateloading<T> value)? loading,
    TResult Function(_ApiStateloaded<T> value)? loaded,
    TResult Function(_ApiStateerror<T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiStateCopyWith<T, $Res> {
  factory $ApiStateCopyWith(
          ApiState<T> value, $Res Function(ApiState<T>) then) =
      _$ApiStateCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$ApiStateCopyWithImpl<T, $Res> implements $ApiStateCopyWith<T, $Res> {
  _$ApiStateCopyWithImpl(this._value, this._then);

  final ApiState<T> _value;
  // ignore: unused_field
  final $Res Function(ApiState<T>) _then;
}

/// @nodoc
abstract class _$ApiStateinitialCopyWith<T, $Res> {
  factory _$ApiStateinitialCopyWith(
          _ApiStateinitial<T> value, $Res Function(_ApiStateinitial<T>) then) =
      __$ApiStateinitialCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$ApiStateinitialCopyWithImpl<T, $Res>
    extends _$ApiStateCopyWithImpl<T, $Res>
    implements _$ApiStateinitialCopyWith<T, $Res> {
  __$ApiStateinitialCopyWithImpl(
      _ApiStateinitial<T> _value, $Res Function(_ApiStateinitial<T>) _then)
      : super(_value, (v) => _then(v as _ApiStateinitial<T>));

  @override
  _ApiStateinitial<T> get _value => super._value as _ApiStateinitial<T>;
}

/// @nodoc

class _$_ApiStateinitial<T> implements _ApiStateinitial<T> {
  const _$_ApiStateinitial();

  @override
  String toString() {
    return 'ApiState<$T>.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ApiStateinitial<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ApiStateinitial<T> value) initial,
    required TResult Function(_ApiStateloading<T> value) loading,
    required TResult Function(_ApiStateloaded<T> value) loaded,
    required TResult Function(_ApiStateerror<T> value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ApiStateinitial<T> value)? initial,
    TResult Function(_ApiStateloading<T> value)? loading,
    TResult Function(_ApiStateloaded<T> value)? loaded,
    TResult Function(_ApiStateerror<T> value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ApiStateinitial<T> value)? initial,
    TResult Function(_ApiStateloading<T> value)? loading,
    TResult Function(_ApiStateloaded<T> value)? loaded,
    TResult Function(_ApiStateerror<T> value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _ApiStateinitial<T> implements ApiState<T> {
  const factory _ApiStateinitial() = _$_ApiStateinitial<T>;
}

/// @nodoc
abstract class _$ApiStateloadingCopyWith<T, $Res> {
  factory _$ApiStateloadingCopyWith(
          _ApiStateloading<T> value, $Res Function(_ApiStateloading<T>) then) =
      __$ApiStateloadingCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$ApiStateloadingCopyWithImpl<T, $Res>
    extends _$ApiStateCopyWithImpl<T, $Res>
    implements _$ApiStateloadingCopyWith<T, $Res> {
  __$ApiStateloadingCopyWithImpl(
      _ApiStateloading<T> _value, $Res Function(_ApiStateloading<T>) _then)
      : super(_value, (v) => _then(v as _ApiStateloading<T>));

  @override
  _ApiStateloading<T> get _value => super._value as _ApiStateloading<T>;
}

/// @nodoc

class _$_ApiStateloading<T> implements _ApiStateloading<T> {
  const _$_ApiStateloading();

  @override
  String toString() {
    return 'ApiState<$T>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ApiStateloading<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ApiStateinitial<T> value) initial,
    required TResult Function(_ApiStateloading<T> value) loading,
    required TResult Function(_ApiStateloaded<T> value) loaded,
    required TResult Function(_ApiStateerror<T> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ApiStateinitial<T> value)? initial,
    TResult Function(_ApiStateloading<T> value)? loading,
    TResult Function(_ApiStateloaded<T> value)? loaded,
    TResult Function(_ApiStateerror<T> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ApiStateinitial<T> value)? initial,
    TResult Function(_ApiStateloading<T> value)? loading,
    TResult Function(_ApiStateloaded<T> value)? loaded,
    TResult Function(_ApiStateerror<T> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _ApiStateloading<T> implements ApiState<T> {
  const factory _ApiStateloading() = _$_ApiStateloading<T>;
}

/// @nodoc
abstract class _$ApiStateloadedCopyWith<T, $Res> {
  factory _$ApiStateloadedCopyWith(
          _ApiStateloaded<T> value, $Res Function(_ApiStateloaded<T>) then) =
      __$ApiStateloadedCopyWithImpl<T, $Res>;
  $Res call({T data});
}

/// @nodoc
class __$ApiStateloadedCopyWithImpl<T, $Res>
    extends _$ApiStateCopyWithImpl<T, $Res>
    implements _$ApiStateloadedCopyWith<T, $Res> {
  __$ApiStateloadedCopyWithImpl(
      _ApiStateloaded<T> _value, $Res Function(_ApiStateloaded<T>) _then)
      : super(_value, (v) => _then(v as _ApiStateloaded<T>));

  @override
  _ApiStateloaded<T> get _value => super._value as _ApiStateloaded<T>;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_ApiStateloaded<T>(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_ApiStateloaded<T> implements _ApiStateloaded<T> {
  const _$_ApiStateloaded({required this.data});

  @override
  final T data;

  @override
  String toString() {
    return 'ApiState<$T>.loaded(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ApiStateloaded<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$ApiStateloadedCopyWith<T, _ApiStateloaded<T>> get copyWith =>
      __$ApiStateloadedCopyWithImpl<T, _ApiStateloaded<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
  }) {
    return loaded?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ApiStateinitial<T> value) initial,
    required TResult Function(_ApiStateloading<T> value) loading,
    required TResult Function(_ApiStateloaded<T> value) loaded,
    required TResult Function(_ApiStateerror<T> value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ApiStateinitial<T> value)? initial,
    TResult Function(_ApiStateloading<T> value)? loading,
    TResult Function(_ApiStateloaded<T> value)? loaded,
    TResult Function(_ApiStateerror<T> value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ApiStateinitial<T> value)? initial,
    TResult Function(_ApiStateloading<T> value)? loading,
    TResult Function(_ApiStateloaded<T> value)? loaded,
    TResult Function(_ApiStateerror<T> value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _ApiStateloaded<T> implements ApiState<T> {
  const factory _ApiStateloaded({required T data}) = _$_ApiStateloaded<T>;

  T get data;
  @JsonKey(ignore: true)
  _$ApiStateloadedCopyWith<T, _ApiStateloaded<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ApiStateerrorCopyWith<T, $Res> {
  factory _$ApiStateerrorCopyWith(
          _ApiStateerror<T> value, $Res Function(_ApiStateerror<T>) then) =
      __$ApiStateerrorCopyWithImpl<T, $Res>;
  $Res call({String error});
}

/// @nodoc
class __$ApiStateerrorCopyWithImpl<T, $Res>
    extends _$ApiStateCopyWithImpl<T, $Res>
    implements _$ApiStateerrorCopyWith<T, $Res> {
  __$ApiStateerrorCopyWithImpl(
      _ApiStateerror<T> _value, $Res Function(_ApiStateerror<T>) _then)
      : super(_value, (v) => _then(v as _ApiStateerror<T>));

  @override
  _ApiStateerror<T> get _value => super._value as _ApiStateerror<T>;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_ApiStateerror<T>(
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ApiStateerror<T> implements _ApiStateerror<T> {
  const _$_ApiStateerror({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'ApiState<$T>.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ApiStateerror<T> &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$ApiStateerrorCopyWith<T, _ApiStateerror<T>> get copyWith =>
      __$ApiStateerrorCopyWithImpl<T, _ApiStateerror<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ApiStateinitial<T> value) initial,
    required TResult Function(_ApiStateloading<T> value) loading,
    required TResult Function(_ApiStateloaded<T> value) loaded,
    required TResult Function(_ApiStateerror<T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ApiStateinitial<T> value)? initial,
    TResult Function(_ApiStateloading<T> value)? loading,
    TResult Function(_ApiStateloaded<T> value)? loaded,
    TResult Function(_ApiStateerror<T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ApiStateinitial<T> value)? initial,
    TResult Function(_ApiStateloading<T> value)? loading,
    TResult Function(_ApiStateloaded<T> value)? loaded,
    TResult Function(_ApiStateerror<T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ApiStateerror<T> implements ApiState<T> {
  const factory _ApiStateerror({required String error}) = _$_ApiStateerror<T>;

  String get error;
  @JsonKey(ignore: true)
  _$ApiStateerrorCopyWith<T, _ApiStateerror<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
