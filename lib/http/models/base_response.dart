import 'package:json_annotation/json_annotation.dart';
//指定自动生成_$BaseResponseFromJson 和 _$BaseResponseToJson两个方法的文件，并指定其名字是base_response.g.dart
part 'base_response.g.dart';

/// 通用的响应基类
@JsonSerializable(genericArgumentFactories: true) // 关键：启用泛型支持
class BaseResponse<T> {
  @JsonKey(name: 'code') // 可自定义JSON字段名
  final int? code;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'msg')
  final String? msg;

  @JsonKey(name: 'resultCode')
  final String? resultCode;


  @JsonKey(name: 'data')
  final T? data; // 泛型数据字段

  BaseResponse({
    this.code,
    this.message,
    this.resultCode,
    this.data,
    this.msg
  });

  /// 反序列化：从JSON映射到BaseResponse<T>对象
  /// 需要传入一个负责解析T类型数据的函数 fromJsonT
  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) => _$BaseResponseFromJson(json, fromJsonT);

  /// 序列化：将BaseResponse<T>对象映射到JSON
  /// 需要传入一个负责将T类型数据转换为JSON的函数 toJsonT
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);

  /// 示例：判断请求是否成功
  bool get isSuccess => (code ==1 || resultCode =="SUCCESS" || code == 20);
}