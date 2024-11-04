// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/responses/ai_image_generated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AiPhotoGenerated _$AiPhotoGeneratedFromJson(Map<String, dynamic> json) =>
    AiPhotoGenerated(
      code: (json['code'] as num?)?.toInt(),
      msg: json['msg'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AiPhotoGeneratedToJson(AiPhotoGenerated instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      image: json['image'] == null
          ? null
          : Image.fromJson(json['image'] as Map<String, dynamic>),
      deepSearch: json['deep_search'] == null
          ? null
          : DeepSearch.fromJson(json['deep_search'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'image': instance.image,
      'deep_search': instance.deepSearch,
    };

DeepSearch _$DeepSearchFromJson(Map<String, dynamic> json) => DeepSearch(
      template: json['template'] == null
          ? null
          : DeepSearchTemplate.fromJson(
              json['template'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeepSearchToJson(DeepSearch instance) =>
    <String, dynamic>{
      'template': instance.template,
    };

DeepSearchTemplate _$DeepSearchTemplateFromJson(Map<String, dynamic> json) =>
    DeepSearchTemplate();

Map<String, dynamic> _$DeepSearchTemplateToJson(DeepSearchTemplate instance) =>
    <String, dynamic>{};

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      template: json['template'] == null
          ? null
          : ImageTemplate.fromJson(json['template'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'meta': instance.meta,
      'template': instance.template,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      categoryList: (json['category_list'] as List<dynamic>?)
          ?.map((e) => CategoryList.fromJson(e as Map<String, dynamic>))
          .toList(),
      optionList: (json['option_list'] as List<dynamic>?)
          ?.map((e) => OptionList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'category_list': instance.categoryList,
      'option_list': instance.optionList,
    };

CategoryList _$CategoryListFromJson(Map<String, dynamic> json) => CategoryList(
      categoryId: (json['category_id'] as num?)?.toInt(),
      categoryName: json['category_name'] as String?,
    );

Map<String, dynamic> _$CategoryListToJson(CategoryList instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
    };

OptionList _$OptionListFromJson(Map<String, dynamic> json) => OptionList(
      type: (json['type'] as num?)?.toInt(),
      value: json['value'] as String?,
      showName: json['show_name'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OptionListToJson(OptionList instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
      'show_name': instance.showName,
      'options': instance.options,
    };

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      showName: json['show_name'] as String?,
      value: json['value'] as String?,
      isDefault: json['is_default'] as bool?,
      backgroundUrl: json['background_url'] as String?,
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'show_name': instance.showName,
      'value': instance.value,
      'is_default': instance.isDefault,
      'background_url': instance.backgroundUrl,
    };

ImageTemplate _$ImageTemplateFromJson(Map<String, dynamic> json) =>
    ImageTemplate(
      imageList: (json['image_list'] as List<dynamic>?)
          ?.map((e) => ImageList.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginator: json['paginator'] == null
          ? null
          : Paginator.fromJson(json['paginator'] as Map<String, dynamic>),
      seed: json['seed'] as String?,
    );

Map<String, dynamic> _$ImageTemplateToJson(ImageTemplate instance) =>
    <String, dynamic>{
      'image_list': instance.imageList,
      'paginator': instance.paginator,
      'seed': instance.seed,
    };

ImageList _$ImageListFromJson(Map<String, dynamic> json) => ImageList(
      id: (json['id'] as num?)?.toInt(),
      prompt: json['prompt'] as String?,
      showValue: json['show_value'] as String?,
      createTime: (json['create_time'] as num?)?.toInt(),
      updateTime: (json['update_time'] as num?)?.toInt(),
      category: json['category'],
      defaultImage: json['default_image'] == null
          ? null
          : DefaultImage.fromJson(
              json['default_image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ImageListToJson(ImageList instance) => <String, dynamic>{
      'id': instance.id,
      'prompt': instance.prompt,
      'show_value': instance.showValue,
      'create_time': instance.createTime,
      'update_time': instance.updateTime,
      'category': instance.category,
      'default_image': instance.defaultImage,
    };

DefaultImage _$DefaultImageFromJson(Map<String, dynamic> json) => DefaultImage(
      uri: json['uri'] as String?,
      url: json['url'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DefaultImageToJson(DefaultImage instance) =>
    <String, dynamic>{
      'uri': instance.uri,
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };

Paginator _$PaginatorFromJson(Map<String, dynamic> json) => Paginator(
      hasMore: json['has_more'] as bool?,
      total: (json['total'] as num?)?.toInt(),
      nextCursor: json['next_cursor'] as String?,
    );

Map<String, dynamic> _$PaginatorToJson(Paginator instance) => <String, dynamic>{
      'has_more': instance.hasMore,
      'total': instance.total,
      'next_cursor': instance.nextCursor,
    };
