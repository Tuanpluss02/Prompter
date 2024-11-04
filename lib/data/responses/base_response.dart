import 'package:json_annotation/json_annotation.dart';

part '../../generated/data/responses/base_response.g.dart';

typedef Decoder<T> = T Function(dynamic data);

@JsonSerializable()
class BaseResponse {
  int? code;
  String? message;
  dynamic data;
  Meta? meta;

  BaseResponse({
    this.code,
    this.message,
    this.data,
    this.meta,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}

@JsonSerializable()
class Meta {
  int? pageSize;
  int? pageIndex;
  int? totalPages;
  int? totalItems;

  Meta({this.totalItems, this.pageSize, this.pageIndex, this.totalPages});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
