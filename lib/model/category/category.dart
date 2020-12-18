import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable()
class Category {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "item_type")
  String itemType;
  @JsonKey(name: "name_en")
  String nameEn;
  @JsonKey(name: "name_kh")
  String nameKh;
  @JsonKey(name: "name_ch")
  String nameCh;
  @JsonKey(name: "icon")
  String icon;

  Category({
      this.id, this.itemType, this.nameEn, this.nameKh, this.nameCh, this.icon});

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class CategoryResponse {

  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "data")
  List<Category> data;
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "message")
  String message;

  CategoryResponse({this.success, this.data, this.code, this.message});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => _$CategoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}

