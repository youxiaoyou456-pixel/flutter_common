import 'package:dio/dio.dart';
import 'package:flutter_common_utils/http/interceptors/loading_interceptor.dart';

import '../interceptors/HeaderInterceptor.dart';
import '../interceptors/error_interceptor.dart';
import '../interceptors/logging_interceptor.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio _dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://api.example.com',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // 添加拦截器
    _dio.interceptors.addAll([
      HeaderInterceptor(),
      LoggingInterceptor(),
      LoadingInterceptor(),
      ErrorInterceptor(),
    ]);
  }

  Dio get dio => _dio;

  // 环境切换支持
  void updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }
}