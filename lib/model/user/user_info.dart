import 'package:json_annotation/json_annotation.dart';
part 'user_info.g.dart';

@JsonSerializable()
class UserInfor {

  String name;
  Picture picture;
  @JsonKey(name: "first_name")
  String firstName;
  @JsonKey(name: "last_name")
  String lastName;
  String email;
  String id;

  UserInfor(this.name, this.picture, this.firstName, this.lastName, this.email,
      this.id);

  factory UserInfor.fromJson(Map<String, dynamic> json) => _$UserInforFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class Picture {
  Data data;

  Picture(this.data);

  factory Picture.fromJson(Map<String, dynamic> json) => _$PictureFromJson(json);
  Map<String, dynamic> toJson() => _$PictureToJson(this);
}

@JsonSerializable()
class Data {
  int height;
  @JsonKey(name: "is_silhouette")
  bool isSilhouette;
  String url;
  int width;

  Data(this.height, this.isSilhouette, this.url, this.width);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}