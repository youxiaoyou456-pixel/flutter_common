// models/base_response.dart
import 'package:json_annotation/json_annotation.dart';
part 'User.g.dart';
@JsonSerializable()
class User {
  @JsonKey(name: 'age')
  final int age;

  @JsonKey(name: 'name')
  final String name;


  User({
    required this.name,
    required this.age,
  });


  // 从JSON映射到User对象的工厂方法
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // 将User对象映射到JSON的方法
  Map<String, dynamic> toJson() => _$UserToJson(this);

}