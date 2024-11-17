// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../../domain/data/entities/comment_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CommentEntity _$CommentEntityFromJson(Map<String, dynamic> json) {
  return _CommentEntity.fromJson(json);
}

/// @nodoc
mixin _$CommentEntity {
  String? get id => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  List<String>? get images => throw _privateConstructorUsedError;
  int? get likeCount => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this CommentEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentEntityCopyWith<CommentEntity> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentEntityCopyWith<$Res> {
  factory $CommentEntityCopyWith(CommentEntity value, $Res Function(CommentEntity) then) = _$CommentEntityCopyWithImpl<$Res, CommentEntity>;
  @useResult
  $Res call({String? id, String? userId, List<String>? images, int? likeCount, String? content, String? createdAt});
}

/// @nodoc
class _$CommentEntityCopyWithImpl<$Res, $Val extends CommentEntity> implements $CommentEntityCopyWith<$Res> {
  _$CommentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? images = freezed,
    Object? likeCount = freezed,
    Object? content = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      likeCount: freezed == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentEntityImplCopyWith<$Res> implements $CommentEntityCopyWith<$Res> {
  factory _$$CommentEntityImplCopyWith(_$CommentEntityImpl value, $Res Function(_$CommentEntityImpl) then) = __$$CommentEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? userId, List<String>? images, int? likeCount, String? content, String? createdAt});
}

/// @nodoc
class __$$CommentEntityImplCopyWithImpl<$Res> extends _$CommentEntityCopyWithImpl<$Res, _$CommentEntityImpl> implements _$$CommentEntityImplCopyWith<$Res> {
  __$$CommentEntityImplCopyWithImpl(_$CommentEntityImpl _value, $Res Function(_$CommentEntityImpl) _then) : super(_value, _then);

  /// Create a copy of CommentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? images = freezed,
    Object? likeCount = freezed,
    Object? content = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$CommentEntityImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      likeCount: freezed == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$CommentEntityImpl implements _CommentEntity {
  const _$CommentEntityImpl({this.id = '', this.userId = '', final List<String>? images = const <String>[], this.likeCount = 0, this.content = '', this.createdAt = ''}) : _images = images;

  factory _$CommentEntityImpl.fromJson(Map<String, dynamic> json) => _$$CommentEntityImplFromJson(json);

  @override
  @JsonKey()
  final String? id;
  @override
  @JsonKey()
  final String? userId;
  final List<String>? _images;
  @override
  @JsonKey()
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final int? likeCount;
  @override
  @JsonKey()
  final String? content;
  @override
  @JsonKey()
  final String? createdAt;

  @override
  String toString() {
    return 'CommentEntity(id: $id, userId: $userId, images: $images, likeCount: $likeCount, content: $content, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.likeCount, likeCount) || other.likeCount == likeCount) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, const DeepCollectionEquality().hash(_images), likeCount, content, createdAt);

  /// Create a copy of CommentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentEntityImplCopyWith<_$CommentEntityImpl> get copyWith => __$$CommentEntityImplCopyWithImpl<_$CommentEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentEntityImplToJson(
      this,
    );
  }
}

abstract class _CommentEntity implements CommentEntity {
  const factory _CommentEntity({final String? id, final String? userId, final List<String>? images, final int? likeCount, final String? content, final String? createdAt}) = _$CommentEntityImpl;

  factory _CommentEntity.fromJson(Map<String, dynamic> json) = _$CommentEntityImpl.fromJson;

  @override
  String? get id;
  @override
  String? get userId;
  @override
  List<String>? get images;
  @override
  int? get likeCount;
  @override
  String? get content;
  @override
  String? get createdAt;

  /// Create a copy of CommentEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentEntityImplCopyWith<_$CommentEntityImpl> get copyWith => throw _privateConstructorUsedError;
}
