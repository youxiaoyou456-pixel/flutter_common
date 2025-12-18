// services/user_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common_utils/http/models/base_response.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/error_handle.dart';
import '../api/user_api.dart';
import '../interceptors/exceptions.dart';

import '../models/User.dart';
import '../network/dio_client.dart';

class UserService {
  final UserApi _userApi;
  String baseUrl = "";

  UserService({String this.baseUrl = "https://api.pearktrue.cn"}) : _userApi = UserApi(DioClient().dio ,baseUrl :baseUrl);


  Future<BaseResponse> getGoldprice({bool? showLoading}) async {
    try {
      //处理业务内的请求失败问题，例如code= -1
      final response = await _userApi.getGoldprice(showLoading:showLoading);
      if (response.isSuccess) {
        return response;
      } else {
        throw BusinessException(response.message?? response.msg?? "未知错误",code:response.code );
      }
    } catch (e) {
      // 统一错误处理
      ErrorHandle.handleError(e);
      rethrow;
    }
  }


}