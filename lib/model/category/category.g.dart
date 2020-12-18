// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    id: json['id'] as int,
    itemType: json['item_type'] as String,
    nameEn: json['name_en'] as String,
    nameKh: json['name_kh'] as String,
    nameCh: json['name_ch'] as String,
    icon: json['icon'] as String,
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'item_type': instance.itemType,
      'name_en': instance.nameEn,
      'name_kh': instance.nameKh,
      'name_ch': instance.nameCh,
      'icon': instance.icon,
    };

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) {
  return CategoryResponse(
    success: json['success'] as bool,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    code: json['code'] as int,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'code': instance.code,
      'message': instance.message,
    };
