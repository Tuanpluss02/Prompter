import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/domain/data/responses/seaart_response.g.dart';

@JsonSerializable()
class SeaArtResponse {
  @JsonKey(name: "data")
  final Data? data;
  @JsonKey(name: "status")
  final Status? status;

  SeaArtResponse({
    this.data,
    this.status,
  });

  factory SeaArtResponse.fromJson(Map<String, dynamic> json) => _$SeaArtResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SeaArtResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "has_more")
  final bool? hasMore;
  @JsonKey(name: "items")
  final List<Item>? items;
  @JsonKey(name: "batch_id")
  final String? batchId;
  @JsonKey(name: "offset")
  final int? offset;

  Data({
    this.hasMore,
    this.items,
    this.batchId,
    this.offset,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "obj_type")
  final int? objType;
  @JsonKey(name: "author")
  final Author? author;
  @JsonKey(name: "cover")
  final String? cover;
  @JsonKey(name: "cover_height")
  final int? coverHeight;
  @JsonKey(name: "cover_width")
  final int? coverWidth;
  @JsonKey(name: "stat")
  final Stat? stat;
  @JsonKey(name: "tag")
  final dynamic tag;
  @JsonKey(name: "nsfw")
  final int? nsfw;
  @JsonKey(name: "nsfw_plus")
  final bool? nsfwPlus;
  @JsonKey(name: "remark")
  final String? remark;
  @JsonKey(name: "prompt")
  final String? prompt;
  @JsonKey(name: "collect")
  final dynamic collect;
  @JsonKey(name: "liked")
  final bool? liked;
  @JsonKey(name: "parent_art_work_no")
  final String? parentArtWorkNo;
  @JsonKey(name: "type")
  final int? type;
  @JsonKey(name: "green")
  final int? green;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "sys_tag")
  final dynamic sysTag;
  @JsonKey(name: "folder_no")
  final dynamic folderNo;
  @JsonKey(name: "source_type")
  final int? sourceType;
  @JsonKey(name: "primary")
  final int? primary;
  @JsonKey(name: "rank_score")
  final int? rankScore;
  @JsonKey(name: "pt")
  final String? pt;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "content")
  final String? content;

  Item({
    this.id,
    this.objType,
    this.author,
    this.cover,
    this.coverHeight,
    this.coverWidth,
    this.stat,
    this.tag,
    this.nsfw,
    this.nsfwPlus,
    this.remark,
    this.prompt,
    this.collect,
    this.liked,
    this.parentArtWorkNo,
    this.type,
    this.green,
    this.status,
    this.sysTag,
    this.folderNo,
    this.sourceType,
    this.primary,
    this.rankScore,
    this.pt,
    this.title,
    this.content,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Author {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "head")
  final String? head;
  @JsonKey(name: "is_follow")
  final bool? isFollow;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "is_active")
  final bool? isActive;
  @JsonKey(name: "join_stimulate")
  final int? joinStimulate;

  Author({
    this.id,
    this.head,
    this.isFollow,
    this.name,
    this.isActive,
    this.joinStimulate,
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}

@JsonSerializable()
class Stat {
  @JsonKey(name: "num_of_like")
  final int? numOfLike;
  @JsonKey(name: "num_of_collection")
  final int? numOfCollection;
  @JsonKey(name: "num_of_task")
  final int? numOfTask;
  @JsonKey(name: "num_of_view")
  final int? numOfView;
  @JsonKey(name: "rating")
  final int? rating;

  Stat({
    this.numOfLike,
    this.numOfCollection,
    this.numOfTask,
    this.numOfView,
    this.rating,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);

  Map<String, dynamic> toJson() => _$StatToJson(this);
}

@JsonSerializable()
class Status {
  @JsonKey(name: "code")
  final int? code;
  @JsonKey(name: "msg")
  final String? msg;
  @JsonKey(name: "request_id")
  final String? requestId;

  Status({
    this.code,
    this.msg,
    this.requestId,
  });

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);
}
