import 'package:json_annotation/json_annotation.dart';
part 'detail.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Detail {
  int id;
  String itemType;
  String itemImg;
  String code;
  String nameEn;
  String nameKh;
  String nameCh;
  String descriptionEn;
  String descriptionKh;
  String descriptionCh;
  String specificationEn;
  String specificationKh;
  String specificationCh;
  int categoriesId;
  String vdoUrl;
  int viewCnt;
  String ordering;
  bool isFavorite;
  List<String> gallery;
  List<Price> prices;
  List<Mobile> mobile;

  Detail(
      this.id,
      this.itemType,
      this.itemImg,
      this.code,
      this.nameEn,
      this.nameKh,
      this.nameCh,
      this.descriptionEn,
      this.descriptionKh,
      this.descriptionCh,
      this.specificationEn,
      this.specificationKh,
      this.specificationCh,
      this.categoriesId,
      this.vdoUrl,
      this.viewCnt,
      this.ordering,
      this.isFavorite,
      this.gallery,
      this.prices,
      this.mobile);

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);
  Map<String, dynamic> toJson() => _$DetailToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Price {
  int id;
  String variation;
  double price;
  int discountDollar;
  Uom uom;

  Price(this.id, this.variation, this.price, this.discountDollar, this.uom);

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Uom  {
  int id;
  String nameEn;
  String nameKh;
  String nameCh;

  Uom(this.id, this.nameEn, this.nameKh, this.nameCh);

  factory Uom.fromJson(Map<String, dynamic> json) => _$UomFromJson(json);
  Map<String, dynamic> toJson() => _$UomToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Mobile {
  int id;
  int itemId;
  String phone;
  String ordering;
  String createdAt;
  String updatedAt;
  String deletedAt;
  Company company;

  Mobile(this.id, this.itemId, this.phone, this.ordering, this.createdAt,
      this.updatedAt, this.deletedAt, this.company);

  factory Mobile.fromJson(Map<String, dynamic> json) => _$MobileFromJson(json);
  Map<String, dynamic> toJson() => _$MobileToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Company {
  int id;
  String name;
  String logo;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Company(this.id, this.name, this.logo, this.createdAt, this.updatedAt,
      this.deletedAt);

  factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyToJson(this);


}

@JsonSerializable()
class DetailResponse {
  bool success;
  Detail data;
  String code;
  String message;

  DetailResponse(this.success, this.data, this.code, this.message);

  factory DetailResponse.fromJson(Map<String, dynamic> json) => _$DetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DetailResponseToJson(this);
}
