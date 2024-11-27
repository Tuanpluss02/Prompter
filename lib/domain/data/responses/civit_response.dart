// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part '../../../generated/domain/data/responses/civit_response.g.dart';

final availabilityValues = EnumValues({"Public": Availability.PUBLIC});

final baseModelValues = EnumValues({"": BaseModel.EMPTY, "Flux.1 D": BaseModel.FLUX_1_D, "Illustrious": BaseModel.ILLUSTRIOUS, "SD 3.5 Large": BaseModel.SD_35_LARGE});

final cosmeticTypeValues =
    EnumValues({"Badge": CosmeticType.BADGE, "NamePlate": CosmeticType.NAME_PLATE, "ProfileBackground": CosmeticType.PROFILE_BACKGROUND, "ProfileDecoration": CosmeticType.PROFILE_DECORATION});

final ingestionValues = EnumValues({"Scanned": Ingestion.SCANNED});

final itemTypeValues = EnumValues({"image": ItemType.IMAGE});

final offsetValues = EnumValues({"20%": Offset.THE_20, "25%": Offset.THE_25, "27%": Offset.THE_27, "30%": Offset.THE_30});

final sourceValues = EnumValues({"Claim": Source.CLAIM, "Event": Source.EVENT, "Membership": Source.MEMBERSHIP, "Purchase": Source.PURCHASE, "Trophy": Source.TROPHY});

CivitAiResponse civitAiResultFromJson(String str) => CivitAiResponse.fromJson(json.decode(str));

String civitAiResultToJson(CivitAiResponse data) => json.encode(data.toJson());

enum Availability {
  @JsonValue("Public")
  PUBLIC
}

enum BaseModel {
  @JsonValue("")
  EMPTY,
  @JsonValue("Flux.1 D")
  FLUX_1_D,
  @JsonValue("Illustrious")
  ILLUSTRIOUS,
  @JsonValue("SD 3.5 Large")
  SD_35_LARGE
}

@JsonSerializable()
class CivitAiResponse {
  @JsonKey(name: "result")
  final Result? result;

  CivitAiResponse({
    this.result,
  });

  factory CivitAiResponse.fromJson(Map<String, dynamic> json) => _$CivitAiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CivitAiResponseToJson(this);
}

@JsonSerializable()
class CosmeticCosmetic {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "data")
  final FluffyData? data;
  @JsonKey(name: "type")
  final CosmeticType? type;
  @JsonKey(name: "source")
  final Source? source;
  @JsonKey(name: "name")
  final String? name;

  CosmeticCosmetic({
    this.id,
    this.data,
    this.type,
    this.source,
    this.name,
  });

  factory CosmeticCosmetic.fromJson(Map<String, dynamic> json) => _$CosmeticCosmeticFromJson(json);

  Map<String, dynamic> toJson() => _$CosmeticCosmeticToJson(this);
}

@JsonSerializable()
class CosmeticElement {
  @JsonKey(name: "data")
  final dynamic data;
  @JsonKey(name: "cosmetic")
  final CosmeticCosmetic? cosmetic;

  CosmeticElement({
    this.data,
    this.cosmetic,
  });

  factory CosmeticElement.fromJson(Map<String, dynamic> json) => _$CosmeticElementFromJson(json);

  Map<String, dynamic> toJson() => _$CosmeticElementToJson(this);
}

enum CosmeticType {
  @JsonValue("Badge")
  BADGE,
  @JsonValue("NamePlate")
  NAME_PLATE,
  @JsonValue("ProfileBackground")
  PROFILE_BACKGROUND,
  @JsonValue("ProfileDecoration")
  PROFILE_DECORATION
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

@JsonSerializable()
class FluffyData {
  @JsonKey(name: "url")
  final String? url;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "offset")
  final Offset? offset;
  @JsonKey(name: "animated")
  final bool? animated;
  @JsonKey(name: "variant")
  final String? variant;
  @JsonKey(name: "gradient")
  final Gradient? gradient;

  FluffyData({
    this.url,
    this.type,
    this.offset,
    this.animated,
    this.variant,
    this.gradient,
  });

  factory FluffyData.fromJson(Map<String, dynamic> json) => _$FluffyDataFromJson(json);

  Map<String, dynamic> toJson() => _$FluffyDataToJson(this);
}

@JsonSerializable()
class Gradient {
  @JsonKey(name: "to")
  final String? to;
  @JsonKey(name: "deg")
  final int? deg;
  @JsonKey(name: "from")
  final String? from;

  Gradient({
    this.to,
    this.deg,
    this.from,
  });

  factory Gradient.fromJson(Map<String, dynamic> json) => _$GradientFromJson(json);

  Map<String, dynamic> toJson() => _$GradientToJson(this);
}

enum Ingestion {
  @JsonValue("Scanned")
  SCANNED
}

@JsonSerializable()
class Item {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "index")
  final int? index;
  @JsonKey(name: "postId")
  final int? postId;
  @JsonKey(name: "url")
  final String? url;
  @JsonKey(name: "nsfwLevel")
  final int? nsfwLevel;
  @JsonKey(name: "aiNsfwLevel")
  final int? aiNsfwLevel;
  @JsonKey(name: "width")
  final int? width;
  @JsonKey(name: "height")
  final int? height;
  @JsonKey(name: "hash")
  final String? hash;
  @JsonKey(name: "hideMeta")
  final bool? hideMeta;
  @JsonKey(name: "sortAt")
  final DateTime? sortAt;
  @JsonKey(name: "type")
  final ItemType? type;
  @JsonKey(name: "userId")
  final int? userId;
  @JsonKey(name: "needsReview")
  final dynamic needsReview;
  @JsonKey(name: "hasMeta")
  final bool? hasMeta;
  @JsonKey(name: "onSite")
  final bool? onSite;
  @JsonKey(name: "postedToId")
  final int? postedToId;
  @JsonKey(name: "reactionCount")
  final int? reactionCount;
  @JsonKey(name: "commentCount")
  final int? commentCount;
  @JsonKey(name: "collectedCount")
  final int? collectedCount;
  @JsonKey(name: "combinedNsfwLevel")
  final int? combinedNsfwLevel;
  @JsonKey(name: "baseModel")
  final BaseModel? baseModel;
  @JsonKey(name: "modelVersionIds")
  final List<int>? modelVersionIds;
  @JsonKey(name: "toolIds")
  final List<int>? toolIds;
  @JsonKey(name: "techniqueIds")
  final List<int>? techniqueIds;
  @JsonKey(name: "existedAtUnix")
  final int? existedAtUnix;
  @JsonKey(name: "sortAtUnix")
  final int? sortAtUnix;
  @JsonKey(name: "tagIds")
  final List<int>? tagIds;
  @JsonKey(name: "stats")
  final Stats? stats;
  @JsonKey(name: "modelVersionId")
  final int? modelVersionId;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "publishedAt")
  final DateTime? publishedAt;
  @JsonKey(name: "user")
  final User? user;
  @JsonKey(name: "reactions")
  final List<dynamic>? reactions;
  @JsonKey(name: "cosmetic")
  final ItemCosmetic? cosmetic;
  @JsonKey(name: "availability")
  final Availability? availability;
  @JsonKey(name: "tags")
  final List<dynamic>? tags;
  @JsonKey(name: "name")
  final dynamic name;
  @JsonKey(name: "scannedAt")
  final dynamic scannedAt;
  @JsonKey(name: "mimeType")
  final dynamic mimeType;
  @JsonKey(name: "ingestion")
  final Ingestion? ingestion;
  @JsonKey(name: "postTitle")
  final dynamic postTitle;
  @JsonKey(name: "meta")
  final dynamic meta;

  Item({
    this.id,
    this.index,
    this.postId,
    this.url,
    this.nsfwLevel,
    this.aiNsfwLevel,
    this.width,
    this.height,
    this.hash,
    this.hideMeta,
    this.sortAt,
    this.type,
    this.userId,
    this.needsReview,
    this.hasMeta,
    this.onSite,
    this.postedToId,
    this.reactionCount,
    this.commentCount,
    this.collectedCount,
    this.combinedNsfwLevel,
    this.baseModel,
    this.modelVersionIds,
    this.toolIds,
    this.techniqueIds,
    this.existedAtUnix,
    this.sortAtUnix,
    this.tagIds,
    this.stats,
    this.modelVersionId,
    this.createdAt,
    this.metadata,
    this.publishedAt,
    this.user,
    this.reactions,
    this.cosmetic,
    this.availability,
    this.tags,
    this.name,
    this.scannedAt,
    this.mimeType,
    this.ingestion,
    this.postTitle,
    this.meta,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class ItemCosmetic {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "data")
  final PurpleData? data;
  @JsonKey(name: "equippedToId")
  final int? equippedToId;
  @JsonKey(name: "claimKey")
  final String? claimKey;
  @JsonKey(name: "cachedAt")
  final DateTime? cachedAt;

  ItemCosmetic({
    this.id,
    this.data,
    this.equippedToId,
    this.claimKey,
    this.cachedAt,
  });

  factory ItemCosmetic.fromJson(Map<String, dynamic> json) => _$ItemCosmeticFromJson(json);

  Map<String, dynamic> toJson() => _$ItemCosmeticToJson(this);
}

enum ItemType {
  @JsonValue("image")
  IMAGE
}

@JsonSerializable()
class Json {
  @JsonKey(name: "nextCursor")
  final String? nextCursor;
  @JsonKey(name: "items")
  final List<Item>? items;

  Json({
    this.nextCursor,
    this.items,
  });

  factory Json.fromJson(Map<String, dynamic> json) => _$JsonFromJson(json);

  Map<String, dynamic> toJson() => _$JsonToJson(this);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: "values")
  final Map<String, List<String>>? values;
  @JsonKey(name: "referentialEqualities")
  final Map<String, List<String>>? referentialEqualities;

  Meta({
    this.values,
    this.referentialEqualities,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: "width")
  final int? width;
  @JsonKey(name: "height")
  final int? height;

  Metadata({
    this.width,
    this.height,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

enum Offset {
  @JsonValue("20%")
  THE_20,
  @JsonValue("25%")
  THE_25,
  @JsonValue("27%")
  THE_27,
  @JsonValue("30%")
  THE_30
}

@JsonSerializable()
class PurpleData {
  @JsonKey(name: "glow")
  final bool? glow;
  @JsonKey(name: "cssFrame")
  final String? cssFrame;

  PurpleData({
    this.glow,
    this.cssFrame,
  });

  factory PurpleData.fromJson(Map<String, dynamic> json) => _$PurpleDataFromJson(json);

  Map<String, dynamic> toJson() => _$PurpleDataToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: "data")
  final ResultData? data;

  Result({
    this.data,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class ResultData {
  @JsonKey(name: "json")
  final Json? json;
  @JsonKey(name: "meta")
  final Meta? meta;

  ResultData({
    this.json,
    this.meta,
  });

  factory ResultData.fromJson(Map<String, dynamic> json) => _$ResultDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResultDataToJson(this);
}

enum Source {
  @JsonValue("Claim")
  CLAIM,
  @JsonValue("Event")
  EVENT,
  @JsonValue("Membership")
  MEMBERSHIP,
  @JsonValue("Purchase")
  PURCHASE,
  @JsonValue("Trophy")
  TROPHY
}

@JsonSerializable()
class Stats {
  @JsonKey(name: "likeCountAllTime")
  final int? likeCountAllTime;
  @JsonKey(name: "laughCountAllTime")
  final int? laughCountAllTime;
  @JsonKey(name: "heartCountAllTime")
  final int? heartCountAllTime;
  @JsonKey(name: "cryCountAllTime")
  final int? cryCountAllTime;
  @JsonKey(name: "commentCountAllTime")
  final int? commentCountAllTime;
  @JsonKey(name: "collectedCountAllTime")
  final int? collectedCountAllTime;
  @JsonKey(name: "tippedAmountCountAllTime")
  final int? tippedAmountCountAllTime;
  @JsonKey(name: "dislikeCountAllTime")
  final int? dislikeCountAllTime;
  @JsonKey(name: "viewCountAllTime")
  final int? viewCountAllTime;

  Stats({
    this.likeCountAllTime,
    this.laughCountAllTime,
    this.heartCountAllTime,
    this.cryCountAllTime,
    this.commentCountAllTime,
    this.collectedCountAllTime,
    this.tippedAmountCountAllTime,
    this.dislikeCountAllTime,
    this.viewCountAllTime,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);

  Map<String, dynamic> toJson() => _$StatsToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "username")
  final String? username;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "deletedAt")
  final dynamic deletedAt;
  @JsonKey(name: "cosmetics")
  final List<CosmeticElement>? cosmetics;
  @JsonKey(name: "profilePicture")
  final dynamic profilePicture;

  User({
    this.id,
    this.username,
    this.image,
    this.deletedAt,
    this.cosmetics,
    this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
