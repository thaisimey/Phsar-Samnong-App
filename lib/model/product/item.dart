import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'item.g.dart';

@JsonSerializable()
class Item {
  int id;
  @JsonKey(name: "client_id")
  int clientId;
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
  @JsonKey(name: "vdo_url")
  String vdoUrl;
  String ordering;
  List<Prices> prices;

  Item(
      this.id,
      this.clientId,
      this.itemType,
      this.itemImg,
      this.code,
      this.nameEn,
      this.nameKh,
      this.nameCh,
      this.vdoUrl,
      this.ordering,
      this.prices);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);

  
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
class ItemResponse {
  bool success;
  List<Item> data;
  int code;
  String message;
  int count;

  ItemResponse(this.success, this.data, this.code, this.message, this.count);
  factory ItemResponse.fromJson(Map<String, dynamic> json) => _$ItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ItemResponseToJson(this);
}