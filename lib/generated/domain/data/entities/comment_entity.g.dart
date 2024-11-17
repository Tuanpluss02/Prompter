// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../domain/data/entities/comment_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentEntityImpl _$$CommentEntityImplFromJson(Map<String, dynamic> json) => _$CommentEntityImpl(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const <String>[],
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      content: json['content'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
    );

Map<String, dynamic> _$$CommentEntityImplToJson(_$CommentEntityImpl instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'images': instance.images,
      'likeCount': instance.likeCount,
      'content': instance.content,
      'createdAt': instance.createdAt,
    };
