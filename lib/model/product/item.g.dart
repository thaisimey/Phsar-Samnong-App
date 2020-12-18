// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    json['id'] as int,
    json['client_id'] as int,
    json['item_type'] as String,
    json['item_img'] as String,
    json['code'] as String,
    json['name_en'] as String,
    json['name_kh'] as String,
    json['name_ch'] as String,
    json['vdo_url'] as String,
    json['ordering'] as String,
    (json['prices'] as List)
        ?.map((e) =>
            e == null ? null : Prices.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'client_id': instance.clientId,
      'item_type': instance.itemType,
      'item_img': instance.itemImg,
      'code': instance.code,
      'name_en': instance.nameEn,
      'name_kh': instance.nameKh,
      'name_ch': instance.nameCh,
      'vdo_url': instance.vdoUrl,
      'ordering': instance.ordering,
      'prices': instance.prices,
    };

Prices _$PricesFromJson(Map<String, dynamic> json) {
  return Prices(
    json['id'] as int,
    json['variation'] as String,
    (json['price'] as num)?.toDouble(),
    json['discount_dollar'] as int,
    json['uom'] == null
        ? null
        : Uom.fromJson(json['uom'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PricesToJson(Prices instance) => <String, dynamic>{
      'id': instance.id,
      'variation': instance.variation,
      'price': instance.price,
      'discount_dollar': instance.discountDollar,
      'uom': instance.uom,
    };

Uom _$UomFromJson(Map<String, dynamic> json) {
  return Uom(
    json['id'] as int,
    json['name_en'] as String,
    json['name_kh'] as String,
    json['name_ch'] as String,
  );
}

Map<String, dynamic> _$UomToJson(Uom instance) => <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_kh': instance.nameKh,
      'name_ch': instance.nameCh,
    };

ItemResponse _$ItemResponseFromJson(Map<String, dynamic> json) {
  return ItemResponse(
    json['success'] as bool,
    (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['code'] as int,
    json['message'] as String,
    json['count'] as int,
  );
}

Map<String, dynamic> _$ItemResponseToJson(ItemResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'code': instance.code,
      'message': instance.message,
      'count': instance.count,
    };
