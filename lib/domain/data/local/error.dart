import 'package:json_annotation/json_annotation.dart';

part '../../../generated/domain/data/local/error.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ErrorModel {
  int code;
  String message;
  int statusCode;
  String statusMessage;
  bool success;

  ErrorModel(this.code, this.message, this.statusCode, this.statusMessage, this.success);

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return _$ErrorModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);
}
