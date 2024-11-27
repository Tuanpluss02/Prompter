// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../domain/data/responses/civit_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CivitAiDetailResponse _$CivitAiDetailResponseFromJson(
        Map<String, dynamic> json) =>
    CivitAiDetailResponse(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CivitAiDetailResponseToJson(
        CivitAiDetailResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json: json['json'] == null
          ? null
          : Json.fromJson(json['json'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? null
          : DataMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'json': instance.json,
      'meta': instance.meta,
    };

Json _$JsonFromJson(Map<String, dynamic> json) => Json(
      type: json['type'] as String?,
      onSite: json['onSite'] as bool?,
      process: json['process'] as String?,
      meta: json['meta'] == null
          ? null
          : JsonMeta.fromJson(json['meta'] as Map<String, dynamic>),
      resources: (json['resources'] as List<dynamic>?)
          ?.map((e) => JsonResource.fromJson(e as Map<String, dynamic>))
          .toList(),
      tools: json['tools'] as List<dynamic>?,
      techniques: json['techniques'] as List<dynamic>?,
      jsonExternal: json['external'],
      canRemix: json['canRemix'] as bool?,
    );

Map<String, dynamic> _$JsonToJson(Json instance) => <String, dynamic>{
      'type': instance.type,
      'onSite': instance.onSite,
      'process': instance.process,
      'meta': instance.meta,
      'resources': instance.resources,
      'tools': instance.tools,
      'techniques': instance.techniques,
      'external': instance.jsonExternal,
      'canRemix': instance.canRemix,
    };

JsonMeta _$JsonMetaFromJson(Map<String, dynamic> json) => JsonMeta(
      prompt: json['prompt'] as String?,
      negativePrompt: json['negativePrompt'] as String?,
      cfgScale: (json['cfgScale'] as num?)?.toInt(),
      steps: (json['steps'] as num?)?.toInt(),
      sampler: json['sampler'] as String?,
      seed: (json['seed'] as num?)?.toInt(),
      hashes: json['hashes'] == null
          ? null
          : Hashes.fromJson(json['hashes'] as Map<String, dynamic>),
      size: json['Size'] as String?,
      model: json['Model'] as String?,
      version: json['Version'] as String?,
      resources: (json['resources'] as List<dynamic>?)
          ?.map((e) => MetaResource.fromJson(e as Map<String, dynamic>))
          .toList(),
      modelHash: json['Model hash'] as String?,
      clipSkip: (json['clipSkip'] as num?)?.toInt(),
    );

Map<String, dynamic> _$JsonMetaToJson(JsonMeta instance) => <String, dynamic>{
      'prompt': instance.prompt,
      'negativePrompt': instance.negativePrompt,
      'cfgScale': instance.cfgScale,
      'steps': instance.steps,
      'sampler': instance.sampler,
      'seed': instance.seed,
      'hashes': instance.hashes,
      'Size': instance.size,
      'Model': instance.model,
      'Version': instance.version,
      'resources': instance.resources,
      'Model hash': instance.modelHash,
      'clipSkip': instance.clipSkip,
    };

Hashes _$HashesFromJson(Map<String, dynamic> json) => Hashes(
      model: json['model'] as String?,
      loraSdxlKimPossible: json['lora:sdxl_Kim_Possible'] as String?,
      loraSdxlLongneckV21: json['lora:sdxl_longneck-v2.1'] as String?,
      loraSdxlDarkerThanDarkV1: json['lora:sdxl_DarkerThanDarkV1'] as String?,
      loraSdxlS1DramaticLightingV2:
          json['lora:sdxl_S1_Dramatic_Lighting_v2'] as String?,
      loraSdxlPonyv4Noob12AdamW000017:
          json['lora:sdxl_ponyv4_noob1_2_adamW-000017'] as String?,
      loraSdxlUnderlightingUnderlightLightFromBelowStyle:
          json['lora:sdxl_Underlighting Underlight light from below style']
              as String?,
    );

Map<String, dynamic> _$HashesToJson(Hashes instance) => <String, dynamic>{
      'model': instance.model,
      'lora:sdxl_Kim_Possible': instance.loraSdxlKimPossible,
      'lora:sdxl_longneck-v2.1': instance.loraSdxlLongneckV21,
      'lora:sdxl_DarkerThanDarkV1': instance.loraSdxlDarkerThanDarkV1,
      'lora:sdxl_S1_Dramatic_Lighting_v2':
          instance.loraSdxlS1DramaticLightingV2,
      'lora:sdxl_ponyv4_noob1_2_adamW-000017':
          instance.loraSdxlPonyv4Noob12AdamW000017,
      'lora:sdxl_Underlighting Underlight light from below style':
          instance.loraSdxlUnderlightingUnderlightLightFromBelowStyle,
    };

MetaResource _$MetaResourceFromJson(Map<String, dynamic> json) => MetaResource(
      hash: json['hash'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MetaResourceToJson(MetaResource instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'name': instance.name,
      'type': instance.type,
      'weight': instance.weight,
    };

JsonResource _$JsonResourceFromJson(Map<String, dynamic> json) => JsonResource(
      id: (json['id'] as num?)?.toInt(),
      strength: (json['strength'] as num?)?.toDouble(),
      modelId: (json['modelId'] as num?)?.toInt(),
      modelName: json['modelName'] as String?,
      modelType: json['modelType'] as String?,
      versionId: (json['versionId'] as num?)?.toInt(),
      versionName: json['versionName'] as String?,
      baseModel: json['baseModel'] as String?,
    );

Map<String, dynamic> _$JsonResourceToJson(JsonResource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'strength': instance.strength,
      'modelId': instance.modelId,
      'modelName': instance.modelName,
      'modelType': instance.modelType,
      'versionId': instance.versionId,
      'versionName': instance.versionName,
      'baseModel': instance.baseModel,
    };

DataMeta _$DataMetaFromJson(Map<String, dynamic> json) => DataMeta(
      values: json['values'] == null
          ? null
          : Values.fromJson(json['values'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataMetaToJson(DataMeta instance) => <String, dynamic>{
      'values': instance.values,
    };

Values _$ValuesFromJson(Map<String, dynamic> json) => Values(
      resources2Strength: (json['resources.2.strength'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      valuesExternal: (json['external'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ValuesToJson(Values instance) => <String, dynamic>{
      'resources.2.strength': instance.resources2Strength,
      'external': instance.valuesExternal,
    };
