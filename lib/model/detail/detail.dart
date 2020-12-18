import 'package:json_annotation/json_annotation.dart';
part 'detail.g.dart';

@JsonSerializable()
class Detail {
  int id;
  @JsonKey(name: "item_type")
  String itemType;
  @JsonKey(name: "item_img")
  String itemImg;
  String code;
  @JsonKey(name: "name_en")
  String nameEn;
  @JsonKey(name: "name_kh")
  String nameKh;
  @JsonKey(name: "name_ch")
  String nameCh;
  @JsonKey(name: "description_en")
  String descriptionEn;
  @JsonKey(name: "description_kh")
  String descriptionKh;
  @JsonKey(name: "description_ch")
  String descriptionCh;
  @JsonKey(name: "specification_en")
  String specificationEn;
  @JsonKey(name: "specification_kh")
  String specificationKh;
  @JsonKey(name: "specification_ch")
  String specificationCh;
  @JsonKey(name: "categories_id")
  int categoriesId;
  @JsonKey(name: "vdo_url")
  String vdoUrl;
  @JsonKey(name: "view_cnt")
  int viewCnt;
  String ordering;
  @JsonKey(name: "is_favorite")
  bool isFavorite;
  List<String> gallery;
  List<Prices> prices;
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

@JsonSerializable()
class Prices {
  int id;
  String variation;
  double price;
  @JsonKey(name: "discount_dollar")
  int discountDollar;
  Uom uom;

  Prices(this.id, this.variation, this.price, this.discountDollar, this.uom);

  factory Prices.fromJson(Map<String, dynamic> json) => _$PricesFromJson(json);
  Map<String, dynamic> toJson() => _$PricesToJson(this);
}

@JsonSerializable()
class Uom  {
  int id;
  @JsonKey(name: "name_en")
  String nameEn;
  @JsonKey(name: "name_kh")
  String nameKh;
  @JsonKey(name: "name_ch")
  String nameCh;

  Uom(this.id, this.nameEn, this.nameKh, this.nameCh);

  factory Uom.fromJson(Map<String, dynamic> json) => _$UomFromJson(json);
  Map<String, dynamic> toJson() => _$UomToJson(this);
}

@JsonSerializable()
class Mobile {
  int id;
  @JsonKey(name: "item_id")
  int itemId;
  String phone;
  String ordering;
  @JsonKey(name: "created_at")
  String createdAt;
  @JsonKey(name: "updated_at")
  String updatedAt;
  @JsonKey(name: "deleted_at")
  String deletedAt;
  Company company;

  Mobile(this.id, this.itemId, this.phone, this.ordering, this.createdAt,
      this.updatedAt, this.deletedAt, this.company);

  factory Mobile.fromJson(Map<String, dynamic> json) => _$MobileFromJson(json);
  Map<String, dynamic> toJson() => _$MobileToJson(this);
}

@JsonSerializable()
class Company {
  int id;
  String name;
  String logo;
  @JsonKey(name: "created_at")
  String createdAt;
  @JsonKey(name: "updated_at")
  String updatedAt;
  @JsonKey(name: "deleted_at")
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
