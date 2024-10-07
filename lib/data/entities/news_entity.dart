import 'package:json_annotation/json_annotation.dart';

part '../../generated/data/entities/news_entity.g.dart';

@JsonSerializable()
class NewsEntity {
  int? id;
  String? title;
  double? price;
  String? shortDesc;
  String? content;
  String? author;
  String? thumbnail;
  String? publishDate;
  int? isPublic;
  int? order;
  int? cateId;
  int? readCount;
  int? reactCount;
  int? shareCount;
  String? slug;
  List<String>? tags;

  NewsEntity({
    this.id,
    this.title,
    this.price = 0,
    this.shortDesc,
    this.content,
    this.author,
    this.thumbnail,
    this.publishDate,
    this.isPublic,
    this.order,
    this.cateId,
    this.readCount,
    this.reactCount,
    this.shareCount,
    this.slug,
    this.tags,
  });

  Map<String, dynamic> toJson() => _$NewsEntityToJson(this);

  factory NewsEntity.fromJson(Map<String, dynamic> json) => _$NewsEntityFromJson(json);
}
