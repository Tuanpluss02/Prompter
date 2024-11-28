// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../domain/data/responses/seaart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeaArtResponse _$SeaArtResponseFromJson(Map<String, dynamic> json) =>
    SeaArtResponse(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeaArtResponseToJson(SeaArtResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      hasMore: json['has_more'] as bool?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      batchId: json['batch_id'] as String?,
      offset: (json['offset'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'has_more': instance.hasMore,
      'items': instance.items,
      'batch_id': instance.batchId,
      'offset': instance.offset,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['id'] as String?,
      objType: (json['obj_type'] as num?)?.toInt(),
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      cover: json['cover'] as String?,
      coverHeight: (json['cover_height'] as num?)?.toInt(),
      coverWidth: (json['cover_width'] as num?)?.toInt(),
      stat: json['stat'] == null
          ? null
          : Stat.fromJson(json['stat'] as Map<String, dynamic>),
      tag: json['tag'],
      nsfw: (json['nsfw'] as num?)?.toInt(),
      nsfwPlus: json['nsfw_plus'] as bool?,
      remark: json['remark'] as String?,
      prompt: json['prompt'] as String?,
      collect: json['collect'],
      liked: json['liked'] as bool?,
      parentArtWorkNo: json['parent_art_work_no'] as String?,
      type: (json['type'] as num?)?.toInt(),
      green: (json['green'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      sysTag: json['sys_tag'],
      folderNo: json['folder_no'],
      sourceType: (json['source_type'] as num?)?.toInt(),
      primary: (json['primary'] as num?)?.toInt(),
      rankScore: (json['rank_score'] as num?)?.toInt(),
      pt: json['pt'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'obj_type': instance.objType,
      'author': instance.author,
      'cover': instance.cover,
      'cover_height': instance.coverHeight,
      'cover_width': instance.coverWidth,
      'stat': instance.stat,
      'tag': instance.tag,
      'nsfw': instance.nsfw,
      'nsfw_plus': instance.nsfwPlus,
      'remark': instance.remark,
      'prompt': instance.prompt,
      'collect': instance.collect,
      'liked': instance.liked,
      'parent_art_work_no': instance.parentArtWorkNo,
      'type': instance.type,
      'green': instance.green,
      'status': instance.status,
      'sys_tag': instance.sysTag,
      'folder_no': instance.folderNo,
      'source_type': instance.sourceType,
      'primary': instance.primary,
      'rank_score': instance.rankScore,
      'pt': instance.pt,
      'title': instance.title,
      'content': instance.content,
    };

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      id: json['id'] as String?,
      head: json['head'] as String?,
      isFollow: json['is_follow'] as bool?,
      name: json['name'] as String?,
      isActive: json['is_active'] as bool?,
      joinStimulate: (json['join_stimulate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'id': instance.id,
      'head': instance.head,
      'is_follow': instance.isFollow,
      'name': instance.name,
      'is_active': instance.isActive,
      'join_stimulate': instance.joinStimulate,
    };

Stat _$StatFromJson(Map<String, dynamic> json) => Stat(
      numOfLike: (json['num_of_like'] as num?)?.toInt(),
      numOfCollection: (json['num_of_collection'] as num?)?.toInt(),
      numOfTask: (json['num_of_task'] as num?)?.toInt(),
      numOfView: (json['num_of_view'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StatToJson(Stat instance) => <String, dynamic>{
      'num_of_like': instance.numOfLike,
      'num_of_collection': instance.numOfCollection,
      'num_of_task': instance.numOfTask,
      'num_of_view': instance.numOfView,
      'rating': instance.rating,
    };

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
      code: (json['code'] as num?)?.toInt(),
      msg: json['msg'] as String?,
      requestId: json['request_id'] as String?,
    );

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'request_id': instance.requestId,
    };
