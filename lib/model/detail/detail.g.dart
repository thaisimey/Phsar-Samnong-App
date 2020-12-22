// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Detail _$DetailFromJson(Map<String, dynamic> json) {
  return Detail(
    json['id'] as int,
    json['item_type'] as String,
    json['item_img'] as String,
    json['code'] as String,
    json['name_en'] as String,
    json['name_kh'] as String,
    json['name_ch'] as String,
    json['description_en'] as String,
    json['description_kh'] as String,
    json['description_ch'] as String,
    json['specification_en'] as String,
    json['specification_kh'] as String,
    json['specification_ch'] as String,
    json['categories_id'] as int,
    json['vdo_url'] as String,
    json['view_cnt'] as int,
    json['ordering'] as String,
    json['is_favorite'] as bool,
    (json['gallery'] as List)?.map((e) => e as String)?.toList(),
    (json['prices'] as List)
        ?.map((e) =>
            e == null ? null : Price.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['mobile'] as List)
        ?.map((e) =>
            e == null ? null : Mobile.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DetailToJson(Detail instance) => <String, dynamic>{
      'id': instance.id,
      'item_type': instance.itemType,
      'item_img': instance.itemImg,
      'code': instance.code,
      'name_en': instance.nameEn,
      'name_kh': instance.nameKh,
      'name_ch': instance.nameCh,
      'description_en': instance.descriptionEn,
      'description_kh': instance.descriptionKh,
      'description_ch': instance.descriptionCh,
      'specification_en': instance.specificationEn,
      'specification_kh': instance.specificationKh,
      'specification_ch': instance.specificationCh,
      'categories_id': instance.categoriesId,
      'vdo_url': instance.vdoUrl,
      'view_cnt': instance.viewCnt,
      'ordering': instance.ordering,
      'is_favorite': instance.isFavorite,
      'gallery': instance.gallery,
      'prices': instance.prices,
      'mobile': instance.mobile,
    };

Price _$PricesFromJson(Map<String, dynamic> json) {
  return Price(
    json['id'] as int,
    json['variation'] as String,
    (json['price'] as num)?.toDouble(),
    json['discount_dollar'] as int,
    json['uom'] == null
        ? null
        : Uom.fromJson(json['uom'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PricesToJson(Price instance) => <String, dynamic>{
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

Mobile _$MobileFromJson(Map<String, dynamic> json) {
  return Mobile(
    json['id'] as int,
    json['item_id'] as int,
    json['phone'] as String,
    json['ordering'] as String,
    json['created_at'] as String,
    json['updated_at'] as String,
    json['deleted_at'] as String,
    json['company'] == null
        ? null
        : Company.fromJson(json['company'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MobileToJson(Mobile instance) => <String, dynamic>{
      'id': instance.id,
      'item_id': instance.itemId,
      'phone': instance.phone,
      'ordering': instance.ordering,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'company': instance.company,
    };

Company _$CompanyFromJson(Map<String, dynamic> json) {
  return Company(
    json['id'] as int,
    json['name'] as String,
    json['logo'] as String,
    json['created_at'] as String,
    json['updated_at'] as String,
    json['deleted_at'] as String,
  );
}

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };

DetailResponse _$DetailResponseFromJson(Map<String, dynamic> json) {
  return DetailResponse(
    json['success'] as bool,
    json['data'] == null
        ? null
        : Detail.fromJson(json['data'] as Map<String, dynamic>),
    json['code'] as String,
    json['message'] as String,
  );
}

Map<String, dynamic> _$DetailResponseToJson(DetailResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'code': instance.code,
      'message': instance.message,
    };
