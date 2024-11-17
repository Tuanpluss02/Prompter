// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../data/local/api_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApiResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BaseResponse data) success,
    required TResult Function(dynamic data) successWWithCustomResponse,
    required TResult Function(NetworkExceptions error) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BaseResponse data)? success,
    TResult? Function(dynamic data)? successWWithCustomResponse,
    TResult? Function(NetworkExceptions error)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BaseResponse data)? success,
    TResult Function(dynamic data)? successWWithCustomResponse,
    TResult Function(NetworkExceptions error)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success value) success,
    required TResult Function(SuccessResponse value) successWWithCustomResponse,
    required TResult Function(Failure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success value)? success,
    TResult? Function(SuccessResponse value)? successWWithCustomResponse,
    TResult? Function(Failure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success value)? success,
    TResult Function(SuccessResponse value)? successWWithCustomResponse,
    TResult Function(Failure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResultCopyWith<$Res> {
  factory $ApiResultCopyWith(ApiResult value, $Res Function(ApiResult) then) = _$ApiResultCopyWithImpl<$Res, ApiResult>;
}

/// @nodoc
class _$ApiResultCopyWithImpl<$Res, $Val extends ApiResult> implements $ApiResultCopyWith<$Res> {
  _$ApiResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(_$SuccessImpl value, $Res Function(_$SuccessImpl) then) = __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BaseResponse data});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res> extends _$ApiResultCopyWithImpl<$Res, _$SuccessImpl> implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(_$SuccessImpl _value, $Res Function(_$SuccessImpl) _then) : super(_value, _then);

  /// Create a copy of ApiResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$SuccessImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as BaseResponse,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements Success {
  const _$SuccessImpl(this.data);

  @override
  final BaseResponse data;

  @override
  String toString() {
    return 'ApiResult.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$SuccessImpl && (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of ApiResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith => __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BaseResponse data) success,
    required TResult Function(dynamic data) successWWithCustomResponse,
    required TResult Function(NetworkExceptions error) failure,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BaseResponse data)? success,
    TResult? Function(dynamic data)? successWWithCustomResponse,
    TResult? Function(NetworkExceptions error)? failure,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BaseResponse data)? success,
    TResult Function(dynamic data)? successWWithCustomResponse,
    TResult Function(NetworkExceptions error)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success value) success,
    required TResult Function(SuccessResponse value) successWWithCustomResponse,
    required TResult Function(Failure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success value)? success,
    TResult? Function(SuccessResponse value)? successWWithCustomResponse,
    TResult? Function(Failure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success value)? success,
    TResult Function(SuccessResponse value)? successWWithCustomResponse,
    TResult Function(Failure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class Success implements ApiResult {
  const factory Success(final BaseResponse data) = _$SuccessImpl;

  BaseResponse get data;

  /// Create a copy of ApiResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessResponseImplCopyWith<$Res> {
  factory _$$SuccessResponseImplCopyWith(_$SuccessResponseImpl value, $Res Function(_$SuccessResponseImpl) then) = __$$SuccessResponseImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic data});
}

/// @nodoc
class __$$SuccessResponseImplCopyWithImpl<$Res> extends _$ApiResultCopyWithImpl<$Res, _$SuccessResponseImpl> implements _$$SuccessResponseImplCopyWith<$Res> {
  __$$SuccessResponseImplCopyWithImpl(_$SuccessResponseImpl _value, $Res Function(_$SuccessResponseImpl) _then) : super(_value, _then);

  /// Create a copy of ApiResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$SuccessResponseImpl(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$SuccessResponseImpl implements SuccessResponse {
  const _$SuccessResponseImpl(this.data);

  @override
  final dynamic data;

  @override
  String toString() {
    return 'ApiResult.successWWithCustomResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$SuccessResponseImpl && const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  /// Create a copy of ApiResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessResponseImplCopyWith<_$SuccessResponseImpl> get copyWith => __$$SuccessResponseImplCopyWithImpl<_$SuccessResponseImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BaseResponse data) success,
    required TResult Function(dynamic data) successWWithCustomResponse,
    required TResult Function(NetworkExceptions error) failure,
  }) {
    return successWWithCustomResponse(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BaseResponse data)? success,
    TResult? Function(dynamic data)? successWWithCustomResponse,
    TResult? Function(NetworkExceptions error)? failure,
  }) {
    return successWWithCustomResponse?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BaseResponse data)? success,
    TResult Function(dynamic data)? successWWithCustomResponse,
    TResult Function(NetworkExceptions error)? failure,
    required TResult orElse(),
  }) {
    if (successWWithCustomResponse != null) {
      return successWWithCustomResponse(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success value) success,
    required TResult Function(SuccessResponse value) successWWithCustomResponse,
    required TResult Function(Failure value) failure,
  }) {
    return successWWithCustomResponse(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success value)? success,
    TResult? Function(SuccessResponse value)? successWWithCustomResponse,
    TResult? Function(Failure value)? failure,
  }) {
    return successWWithCustomResponse?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success value)? success,
    TResult Function(SuccessResponse value)? successWWithCustomResponse,
    TResult Function(Failure value)? failure,
    required TResult orElse(),
  }) {
    if (successWWithCustomResponse != null) {
      return successWWithCustomResponse(this);
    }
    return orElse();
  }
}

abstract class SuccessResponse implements ApiResult {
  const factory SuccessResponse(final dynamic data) = _$SuccessResponseImpl;

  dynamic get data;

  /// Create a copy of ApiResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessResponseImplCopyWith<_$SuccessResponseImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> {
  factory _$$FailureImplCopyWith(_$FailureImpl value, $Res Function(_$FailureImpl) then) = __$$FailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NetworkExceptions error});

  $NetworkExceptionsCopyWith<$Res> get error;
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res> extends _$ApiResultCopyWithImpl<$Res, _$FailureImpl> implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(_$FailureImpl _value, $Res Function(_$FailureImpl) _then) : super(_value, _then);

  /// Create a copy of ApiResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$FailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as NetworkExceptions,
    ));
  }

  /// Create a copy of ApiResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NetworkExceptionsCopyWith<$Res> get error {
    return $NetworkExceptionsCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc

class _$FailureImpl implements Failure {
  const _$FailureImpl(this.error);

  @override
  final NetworkExceptions error;

  @override
  String toString() {
    return 'ApiResult.failure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$FailureImpl && (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of ApiResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith => __$$FailureImplCopyWithImpl<_$FailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BaseResponse data) success,
    required TResult Function(dynamic data) successWWithCustomResponse,
    required TResult Function(NetworkExceptions error) failure,
  }) {
    return failure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BaseResponse data)? success,
    TResult? Function(dynamic data)? successWWithCustomResponse,
    TResult? Function(NetworkExceptions error)? failure,
  }) {
    return failure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BaseResponse data)? success,
    TResult Function(dynamic data)? successWWithCustomResponse,
    TResult Function(NetworkExceptions error)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success value) success,
    required TResult Function(SuccessResponse value) successWWithCustomResponse,
    required TResult Function(Failure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success value)? success,
    TResult? Function(SuccessResponse value)? successWWithCustomResponse,
    TResult? Function(Failure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success value)? success,
    TResult Function(SuccessResponse value)? successWWithCustomResponse,
    TResult Function(Failure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class Failure implements ApiResult {
  const factory Failure(final NetworkExceptions error) = _$FailureImpl;

  NetworkExceptions get error;

  /// Create a copy of ApiResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith => throw _privateConstructorUsedError;
}
