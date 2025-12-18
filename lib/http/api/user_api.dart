// api/user_api.dart
import 'dart:io';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../models/User.dart';
import '../models/base_response.dart';


part 'user_api.g.dart';

@RestApi(baseUrl: 'https://api.pearktrue.cn')
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @GET("/api/goldprice/")
  @Extra({"test":false})
  Future<BaseResponse> getGoldprice({@Query("showLoading") bool? showLoading});


  @GET("search")
  Future<BaseResponse> searchNews(@Query("keyword") String keyword, @Query("page") int page);

// 或者使用 Map
  @GET("search")
  Future<BaseResponse> searchNews2(@Queries()  Map<String, Object> params);

  @FormUrlEncoded()
  @POST("user/login")
  Future<BaseResponse> userLogin(@Field("username") String username, @Field("password") String password);


  @POST("user/update")
  Future<BaseResponse> updateUser(@Body() User user);

  // 文件上传示例
  @POST('/upload')
  @MultiPart()
  Future<BaseResponse<String>> uploadAvatar(@Part() File file);
}