// To parse this JSON data, do
//
//     final civitAiDetailResponse = civitAiDetailResponseFromJson(jsonString);
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part '../../../generated/domain/data/responses/civit_detail_response.g.dart';

CivitAiDetailResponse civitAiDetailResponseFromJson(String str) => CivitAiDetailResponse.fromJson(json.decode(str));

String civitAiDetailResponseToJson(CivitAiDetailResponse data) => json.encode(data.toJson());

@JsonSerializable()
class CivitAiDetailResponse {
  @JsonKey(name: "result")
  final Result? result;

  CivitAiDetailResponse({
    this.result,
  });

  factory CivitAiDetailResponse.fromJson(Map<String, dynamic> json) => _$CivitAiDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CivitAiDetailResponseToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: "data")
  final Data? data;

  Result({
    this.data,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "json")
  final Json? json;
  @JsonKey(name: "meta")
  final DataMeta? meta;

  Data({
    this.json,
    this.meta,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Json {
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "onSite")
  final bool? onSite;
  @JsonKey(name: "process")
  final String? process;
  @JsonKey(name: "meta")
  final JsonMeta? meta;
  @JsonKey(name: "resources")
  final List<JsonResource>? resources;
  @JsonKey(name: "tools")
  final List<dynamic>? tools;
  @JsonKey(name: "techniques")
  final List<dynamic>? techniques;
  @JsonKey(name: "external")
  final dynamic jsonExternal;
  @JsonKey(name: "canRemix")
  final bool? canRemix;

  Json({
    this.type,
    this.onSite,
    this.process,
    this.meta,
    this.resources,
    this.tools,
    this.techniques,
    this.jsonExternal,
    this.canRemix,
  });

  factory Json.fromJson(Map<String, dynamic> json) => _$JsonFromJson(json);

  Map<String, dynamic> toJson() => _$JsonToJson(this);
}

@JsonSerializable()
class JsonMeta {
  @JsonKey(name: "prompt")
  final String? prompt;
  @JsonKey(name: "negativePrompt")
  final String? negativePrompt;
  @JsonKey(name: "cfgScale")
  final int? cfgScale;
  @JsonKey(name: "steps")
  final int? steps;
  @JsonKey(name: "sampler")
  final String? sampler;
  @JsonKey(name: "seed")
  final int? seed;
  @JsonKey(name: "hashes")
  final Hashes? hashes;
  @JsonKey(name: "Size")
  final String? size;
  @JsonKey(name: "Model")
  final String? model;
  @JsonKey(name: "Version")
  final String? version;
  @JsonKey(name: "resources")
  final List<MetaResource>? resources;
  @JsonKey(name: "Model hash")
  final String? modelHash;
  @JsonKey(name: "clipSkip")
  final int? clipSkip;

  JsonMeta({
    this.prompt,
    this.negativePrompt,
    this.cfgScale,
    this.steps,
    this.sampler,
    this.seed,
    this.hashes,
    this.size,
    this.model,
    this.version,
    this.resources,
    this.modelHash,
    this.clipSkip,
  });

  factory JsonMeta.fromJson(Map<String, dynamic> json) => _$JsonMetaFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMetaToJson(this);
}

@JsonSerializable()
class Hashes {
  @JsonKey(name: "model")
  final String? model;
  @JsonKey(name: "lora:sdxl_Kim_Possible")
  final String? loraSdxlKimPossible;
  @JsonKey(name: "lora:sdxl_longneck-v2.1")
  final String? loraSdxlLongneckV21;
  @JsonKey(name: "lora:sdxl_DarkerThanDarkV1")
  final String? loraSdxlDarkerThanDarkV1;
  @JsonKey(name: "lora:sdxl_S1_Dramatic_Lighting_v2")
  final String? loraSdxlS1DramaticLightingV2;
  @JsonKey(name: "lora:sdxl_ponyv4_noob1_2_adamW-000017")
  final String? loraSdxlPonyv4Noob12AdamW000017;
  @JsonKey(name: "lora:sdxl_Underlighting Underlight light from below style")
  final String? loraSdxlUnderlightingUnderlightLightFromBelowStyle;

  Hashes({
    this.model,
    this.loraSdxlKimPossible,
    this.loraSdxlLongneckV21,
    this.loraSdxlDarkerThanDarkV1,
    this.loraSdxlS1DramaticLightingV2,
    this.loraSdxlPonyv4Noob12AdamW000017,
    this.loraSdxlUnderlightingUnderlightLightFromBelowStyle,
  });

  factory Hashes.fromJson(Map<String, dynamic> json) => _$HashesFromJson(json);

  Map<String, dynamic> toJson() => _$HashesToJson(this);
}

@JsonSerializable()
class MetaResource {
  @JsonKey(name: "hash")
  final String? hash;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "weight")
  final double? weight;

  MetaResource({
    this.hash,
    this.name,
    this.type,
    this.weight,
  });

  factory MetaResource.fromJson(Map<String, dynamic> json) => _$MetaResourceFromJson(json);

  Map<String, dynamic> toJson() => _$MetaResourceToJson(this);
}

@JsonSerializable()
class JsonResource {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "strength")
  final double? strength;
  @JsonKey(name: "modelId")
  final int? modelId;
  @JsonKey(name: "modelName")
  final String? modelName;
  @JsonKey(name: "modelType")
  final String? modelType;
  @JsonKey(name: "versionId")
  final int? versionId;
  @JsonKey(name: "versionName")
  final String? versionName;
  @JsonKey(name: "baseModel")
  final String? baseModel;

  JsonResource({
    this.id,
    this.strength,
    this.modelId,
    this.modelName,
    this.modelType,
    this.versionId,
    this.versionName,
    this.baseModel,
  });

  factory JsonResource.fromJson(Map<String, dynamic> json) => _$JsonResourceFromJson(json);

  Map<String, dynamic> toJson() => _$JsonResourceToJson(this);
}

@JsonSerializable()
class DataMeta {
  @JsonKey(name: "values")
  final Values? values;

  DataMeta({
    this.values,
  });

  factory DataMeta.fromJson(Map<String, dynamic> json) => _$DataMetaFromJson(json);

  Map<String, dynamic> toJson() => _$DataMetaToJson(this);
}

@JsonSerializable()
class Values {
  @JsonKey(name: "resources.2.strength")
  final List<String>? resources2Strength;
  @JsonKey(name: "external")
  final List<String>? valuesExternal;

  Values({
    this.resources2Strength,
    this.valuesExternal,
  });

  factory Values.fromJson(Map<String, dynamic> json) => _$ValuesFromJson(json);

  Map<String, dynamic> toJson() => _$ValuesToJson(this);
}
