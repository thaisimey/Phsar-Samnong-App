// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfor _$UserInforFromJson(Map<String, dynamic> json) {
  return UserInfor(
    json['name'] as String,
    json['picture'] == null
        ? null
        : Picture.fromJson(json['picture'] as Map<String, dynamic>),
    json['first_name'] as String,
    json['last_name'] as String,
    json['email'] as String,
    json['id'] as String,
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfor instance) => <String, dynamic>{
      'name': instance.name,
      'picture': instance.picture,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'id': instance.id,
    };

Picture _$PictureFromJson(Map<String, dynamic> json) {
  return Picture(
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PictureToJson(Picture instance) => <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['height'] as int,
    json['is_silhouette'] as bool,
    json['url'] as String,
    json['width'] as int,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'height': instance.height,
      'is_silhouette': instance.isSilhouette,
      'url': instance.url,
      'width': instance.width,
    };
