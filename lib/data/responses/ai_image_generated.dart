import 'package:json_annotation/json_annotation.dart';

part '../../generated/data/responses/ai_image_generated.g.dart';

@JsonSerializable()
class Data {
  @JsonKey(name: "image")
  final Image? image;
  @JsonKey(name: "deep_search")
  final DeepSearch? deepSearch;

  Data({
    this.image,
    this.deepSearch,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class DeepSearch {
  @JsonKey(name: "template")
  final DeepSearchTemplate? template;

  DeepSearch({
    this.template,
  });

  factory DeepSearch.fromJson(Map<String, dynamic> json) => _$DeepSearchFromJson(json);

  Map<String, dynamic> toJson() => _$DeepSearchToJson(this);
}

@JsonSerializable()
class DeepSearchTemplate {
  DeepSearchTemplate();

  factory DeepSearchTemplate.fromJson(Map<String, dynamic> json) => _$DeepSearchTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$DeepSearchTemplateToJson(this);
}

@JsonSerializable()
class Image {
  @JsonKey(name: "meta")
  final Meta? meta;
  @JsonKey(name: "template")
  final ImageTemplate? template;

  Image({
    this.meta,
    this.template,
  });

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: "category_list")
  final List<CategoryList>? categoryList;
  @JsonKey(name: "option_list")
  final List<OptionList>? optionList;

  Meta({
    this.categoryList,
    this.optionList,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

@JsonSerializable()
class CategoryList {
  @JsonKey(name: "category_id")
  final int? categoryId;
  @JsonKey(name: "category_name")
  final String? categoryName;

  CategoryList({
    this.categoryId,
    this.categoryName,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => _$CategoryListFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryListToJson(this);
}

@JsonSerializable()
class OptionList {
  @JsonKey(name: "type")
  final int? type;
  @JsonKey(name: "value")
  final String? value;
  @JsonKey(name: "show_name")
  final String? showName;
  @JsonKey(name: "options")
  final List<Option>? options;

  OptionList({
    this.type,
    this.value,
    this.showName,
    this.options,
  });

  factory OptionList.fromJson(Map<String, dynamic> json) => _$OptionListFromJson(json);

  Map<String, dynamic> toJson() => _$OptionListToJson(this);
}

@JsonSerializable()
class Option {
  @JsonKey(name: "show_name")
  final String? showName;
  @JsonKey(name: "value")
  final String? value;
  @JsonKey(name: "is_default")
  final bool? isDefault;
  @JsonKey(name: "background_url")
  final String? backgroundUrl;

  Option({
    this.showName,
    this.value,
    this.isDefault,
    this.backgroundUrl,
  });

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionToJson(this);
}

@JsonSerializable()
class ImageTemplate {
  @JsonKey(name: "image_list")
  final List<ImageList>? imageList;
  @JsonKey(name: "paginator")
  final Paginator? paginator;
  @JsonKey(name: "seed")
  final String? seed;

  ImageTemplate({
    this.imageList,
    this.paginator,
    this.seed,
  });

  factory ImageTemplate.fromJson(Map<String, dynamic> json) => _$ImageTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$ImageTemplateToJson(this);
}

@JsonSerializable()
class ImageList {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "prompt")
  final String? prompt;
  @JsonKey(name: "show_value")
  final String? showValue;
  @JsonKey(name: "create_time")
  final int? createTime;
  @JsonKey(name: "update_time")
  final int? updateTime;
  @JsonKey(name: "category")
  final dynamic category;
  @JsonKey(name: "default_image")
  final DefaultImage? defaultImage;

  ImageList({
    this.id,
    this.prompt,
    this.showValue,
    this.createTime,
    this.updateTime,
    this.category,
    this.defaultImage,
  });

  factory ImageList.fromJson(Map<String, dynamic> json) => _$ImageListFromJson(json);

  Map<String, dynamic> toJson() => _$ImageListToJson(this);
}

@JsonSerializable()
class DefaultImage {
  @JsonKey(name: "uri")
  final String? uri;
  @JsonKey(name: "url")
  final String? url;
  @JsonKey(name: "width")
  final int? width;
  @JsonKey(name: "height")
  final int? height;

  DefaultImage({
    this.uri,
    this.url,
    this.width,
    this.height,
  });

  factory DefaultImage.fromJson(Map<String, dynamic> json) => _$DefaultImageFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultImageToJson(this);
}

@JsonSerializable()
class Paginator {
  @JsonKey(name: "has_more")
  final bool? hasMore;
  @JsonKey(name: "total")
  final int? total;
  @JsonKey(name: "next_cursor")
  final String? nextCursor;

  Paginator({
    this.hasMore,
    this.total,
    this.nextCursor,
  });

  factory Paginator.fromJson(Map<String, dynamic> json) => _$PaginatorFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatorToJson(this);
}
