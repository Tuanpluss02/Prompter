// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../domain/data/responses/civit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CivitAiResponse _$CivitAiResponseFromJson(Map<String, dynamic> json) =>
    CivitAiResponse(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CivitAiResponseToJson(CivitAiResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

CosmeticCosmetic _$CosmeticCosmeticFromJson(Map<String, dynamic> json) =>
    CosmeticCosmetic(
      id: (json['id'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : FluffyData.fromJson(json['data'] as Map<String, dynamic>),
      type: $enumDecodeNullable(_$CosmeticTypeEnumMap, json['type']),
      source: $enumDecodeNullable(_$SourceEnumMap, json['source']),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CosmeticCosmeticToJson(CosmeticCosmetic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
      'type': _$CosmeticTypeEnumMap[instance.type],
      'source': _$SourceEnumMap[instance.source],
      'name': instance.name,
    };

const _$CosmeticTypeEnumMap = {
  CosmeticType.BADGE: 'Badge',
  CosmeticType.NAME_PLATE: 'NamePlate',
  CosmeticType.PROFILE_BACKGROUND: 'ProfileBackground',
  CosmeticType.PROFILE_DECORATION: 'ProfileDecoration',
};

const _$SourceEnumMap = {
  Source.CLAIM: 'Claim',
  Source.EVENT: 'Event',
  Source.MEMBERSHIP: 'Membership',
  Source.PURCHASE: 'Purchase',
  Source.TROPHY: 'Trophy',
};

CosmeticElement _$CosmeticElementFromJson(Map<String, dynamic> json) =>
    CosmeticElement(
      data: json['data'],
      cosmetic: json['cosmetic'] == null
          ? null
          : CosmeticCosmetic.fromJson(json['cosmetic'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CosmeticElementToJson(CosmeticElement instance) =>
    <String, dynamic>{
      'data': instance.data,
      'cosmetic': instance.cosmetic,
    };

FluffyData _$FluffyDataFromJson(Map<String, dynamic> json) => FluffyData(
      url: json['url'] as String?,
      type: json['type'] as String?,
      offset: $enumDecodeNullable(_$OffsetEnumMap, json['offset']),
      animated: json['animated'] as bool?,
      variant: json['variant'] as String?,
      gradient: json['gradient'] == null
          ? null
          : Gradient.fromJson(json['gradient'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FluffyDataToJson(FluffyData instance) =>
    <String, dynamic>{
      'url': instance.url,
      'type': instance.type,
      'offset': _$OffsetEnumMap[instance.offset],
      'animated': instance.animated,
      'variant': instance.variant,
      'gradient': instance.gradient,
    };

const _$OffsetEnumMap = {
  Offset.THE_20: '20%',
  Offset.THE_25: '25%',
  Offset.THE_27: '27%',
  Offset.THE_30: '30%',
};

Gradient _$GradientFromJson(Map<String, dynamic> json) => Gradient(
      to: json['to'] as String?,
      deg: (json['deg'] as num?)?.toInt(),
      from: json['from'] as String?,
    );

Map<String, dynamic> _$GradientToJson(Gradient instance) => <String, dynamic>{
      'to': instance.to,
      'deg': instance.deg,
      'from': instance.from,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: (json['id'] as num?)?.toInt(),
      index: (json['index'] as num?)?.toInt(),
      postId: (json['postId'] as num?)?.toInt(),
      url: json['url'] as String?,
      nsfwLevel: (json['nsfwLevel'] as num?)?.toInt(),
      aiNsfwLevel: (json['aiNsfwLevel'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      hash: json['hash'] as String?,
      hideMeta: json['hideMeta'] as bool?,
      sortAt: json['sortAt'] == null
          ? null
          : DateTime.parse(json['sortAt'] as String),
      type: $enumDecodeNullable(_$ItemTypeEnumMap, json['type']),
      userId: (json['userId'] as num?)?.toInt(),
      needsReview: json['needsReview'],
      hasMeta: json['hasMeta'] as bool?,
      onSite: json['onSite'] as bool?,
      postedToId: (json['postedToId'] as num?)?.toInt(),
      reactionCount: (json['reactionCount'] as num?)?.toInt(),
      commentCount: (json['commentCount'] as num?)?.toInt(),
      collectedCount: (json['collectedCount'] as num?)?.toInt(),
      combinedNsfwLevel: (json['combinedNsfwLevel'] as num?)?.toInt(),
      baseModel: $enumDecodeNullable(_$BaseModelEnumMap, json['baseModel']),
      modelVersionIds: (json['modelVersionIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      toolIds: (json['toolIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      techniqueIds: (json['techniqueIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      existedAtUnix: (json['existedAtUnix'] as num?)?.toInt(),
      sortAtUnix: (json['sortAtUnix'] as num?)?.toInt(),
      tagIds: (json['tagIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      stats: json['stats'] == null
          ? null
          : Stats.fromJson(json['stats'] as Map<String, dynamic>),
      modelVersionId: (json['modelVersionId'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      reactions: json['reactions'] as List<dynamic>?,
      cosmetic: json['cosmetic'] == null
          ? null
          : ItemCosmetic.fromJson(json['cosmetic'] as Map<String, dynamic>),
      availability:
          $enumDecodeNullable(_$AvailabilityEnumMap, json['availability']),
      tags: json['tags'] as List<dynamic>?,
      name: json['name'],
      scannedAt: json['scannedAt'],
      mimeType: json['mimeType'],
      ingestion: $enumDecodeNullable(_$IngestionEnumMap, json['ingestion']),
      postTitle: json['postTitle'],
      meta: json['meta'],
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'postId': instance.postId,
      'url': instance.url,
      'nsfwLevel': instance.nsfwLevel,
      'aiNsfwLevel': instance.aiNsfwLevel,
      'width': instance.width,
      'height': instance.height,
      'hash': instance.hash,
      'hideMeta': instance.hideMeta,
      'sortAt': instance.sortAt?.toIso8601String(),
      'type': _$ItemTypeEnumMap[instance.type],
      'userId': instance.userId,
      'needsReview': instance.needsReview,
      'hasMeta': instance.hasMeta,
      'onSite': instance.onSite,
      'postedToId': instance.postedToId,
      'reactionCount': instance.reactionCount,
      'commentCount': instance.commentCount,
      'collectedCount': instance.collectedCount,
      'combinedNsfwLevel': instance.combinedNsfwLevel,
      'baseModel': _$BaseModelEnumMap[instance.baseModel],
      'modelVersionIds': instance.modelVersionIds,
      'toolIds': instance.toolIds,
      'techniqueIds': instance.techniqueIds,
      'existedAtUnix': instance.existedAtUnix,
      'sortAtUnix': instance.sortAtUnix,
      'tagIds': instance.tagIds,
      'stats': instance.stats,
      'modelVersionId': instance.modelVersionId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'metadata': instance.metadata,
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'user': instance.user,
      'reactions': instance.reactions,
      'cosmetic': instance.cosmetic,
      'availability': _$AvailabilityEnumMap[instance.availability],
      'tags': instance.tags,
      'name': instance.name,
      'scannedAt': instance.scannedAt,
      'mimeType': instance.mimeType,
      'ingestion': _$IngestionEnumMap[instance.ingestion],
      'postTitle': instance.postTitle,
      'meta': instance.meta,
    };

const _$ItemTypeEnumMap = {
  ItemType.IMAGE: 'image',
};

const _$BaseModelEnumMap = {
  BaseModel.EMPTY: '',
  BaseModel.FLUX_1_D: 'Flux.1 D',
  BaseModel.ILLUSTRIOUS: 'Illustrious',
  BaseModel.SD_35_LARGE: 'SD 3.5 Large',
};

const _$AvailabilityEnumMap = {
  Availability.PUBLIC: 'Public',
};

const _$IngestionEnumMap = {
  Ingestion.SCANNED: 'Scanned',
};

ItemCosmetic _$ItemCosmeticFromJson(Map<String, dynamic> json) => ItemCosmetic(
      id: (json['id'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : PurpleData.fromJson(json['data'] as Map<String, dynamic>),
      equippedToId: (json['equippedToId'] as num?)?.toInt(),
      claimKey: json['claimKey'] as String?,
      cachedAt: json['cachedAt'] == null
          ? null
          : DateTime.parse(json['cachedAt'] as String),
    );

Map<String, dynamic> _$ItemCosmeticToJson(ItemCosmetic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
      'equippedToId': instance.equippedToId,
      'claimKey': instance.claimKey,
      'cachedAt': instance.cachedAt?.toIso8601String(),
    };

Json _$JsonFromJson(Map<String, dynamic> json) => Json(
      nextCursor: json['nextCursor'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JsonToJson(Json instance) => <String, dynamic>{
      'nextCursor': instance.nextCursor,
      'items': instance.items,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      values: (json['values'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      referentialEqualities:
          (json['referentialEqualities'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'values': instance.values,
      'referentialEqualities': instance.referentialEqualities,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };

PurpleData _$PurpleDataFromJson(Map<String, dynamic> json) => PurpleData(
      glow: json['glow'] as bool?,
      cssFrame: json['cssFrame'] as String?,
    );

Map<String, dynamic> _$PurpleDataToJson(PurpleData instance) =>
    <String, dynamic>{
      'glow': instance.glow,
      'cssFrame': instance.cssFrame,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      data: json['data'] == null
          ? null
          : ResultData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'data': instance.data,
    };

ResultData _$ResultDataFromJson(Map<String, dynamic> json) => ResultData(
      json: json['json'] == null
          ? null
          : Json.fromJson(json['json'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResultDataToJson(ResultData instance) =>
    <String, dynamic>{
      'json': instance.json,
      'meta': instance.meta,
    };

Stats _$StatsFromJson(Map<String, dynamic> json) => Stats(
      likeCountAllTime: (json['likeCountAllTime'] as num?)?.toInt(),
      laughCountAllTime: (json['laughCountAllTime'] as num?)?.toInt(),
      heartCountAllTime: (json['heartCountAllTime'] as num?)?.toInt(),
      cryCountAllTime: (json['cryCountAllTime'] as num?)?.toInt(),
      commentCountAllTime: (json['commentCountAllTime'] as num?)?.toInt(),
      collectedCountAllTime: (json['collectedCountAllTime'] as num?)?.toInt(),
      tippedAmountCountAllTime:
          (json['tippedAmountCountAllTime'] as num?)?.toInt(),
      dislikeCountAllTime: (json['dislikeCountAllTime'] as num?)?.toInt(),
      viewCountAllTime: (json['viewCountAllTime'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StatsToJson(Stats instance) => <String, dynamic>{
      'likeCountAllTime': instance.likeCountAllTime,
      'laughCountAllTime': instance.laughCountAllTime,
      'heartCountAllTime': instance.heartCountAllTime,
      'cryCountAllTime': instance.cryCountAllTime,
      'commentCountAllTime': instance.commentCountAllTime,
      'collectedCountAllTime': instance.collectedCountAllTime,
      'tippedAmountCountAllTime': instance.tippedAmountCountAllTime,
      'dislikeCountAllTime': instance.dislikeCountAllTime,
      'viewCountAllTime': instance.viewCountAllTime,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String?,
      image: json['image'] as String?,
      deletedAt: json['deletedAt'],
      cosmetics: (json['cosmetics'] as List<dynamic>?)
          ?.map((e) => CosmeticElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      profilePicture: json['profilePicture'],
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'image': instance.image,
      'deletedAt': instance.deletedAt,
      'cosmetics': instance.cosmetics,
      'profilePicture': instance.profilePicture,
    };
