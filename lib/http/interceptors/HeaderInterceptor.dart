// network/interceptors/header_interceptor.dart
import 'package:dio/dio.dart';


class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 添加认证 token
    final token = _getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // 添加设备信息等公共参数
    options.headers['Device-Type'] = 'flutter';
    options.headers['App-Version'] = '1.0.0';

    handler.next(options);
  }

   String? _getToken() {
    // 从本地存储获取 token
     return "";
  }
}

