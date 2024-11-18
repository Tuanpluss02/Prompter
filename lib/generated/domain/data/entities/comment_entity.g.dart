// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../domain/data/entities/comment_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentEntityImpl _$$CommentEntityImplFromJson(Map<String, dynamic> json) =>
    _$CommentEntityImpl(
      id: json['id'] as String? ?? '',
      authorId: json['authorId'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      likes:
          (json['likes'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
      content: json['content'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$CommentEntityImplToJson(_$CommentEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'images': instance.images,
      'likes': instance.likes,
      'content': instance.content,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
