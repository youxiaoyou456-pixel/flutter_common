// network/interceptors/error_interceptor.dart
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'exceptions.dart';

class ErrorInterceptor extends Interceptor {
  //是否将网络请求错误翻译成为详细描述，否则自行catch异常，自行翻译
  bool isChangeNetWorkErrorToDetail = false;
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppException? appException;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        appException = NetworkException('网络连接超时，请检查网络设置');
        break;
      case DioExceptionType.badCertificate:
        appException = NetworkException('证书验证失败');
        break;
      case DioExceptionType.badResponse:
        appException = _handleBadResponse(err);
        break;
      case DioExceptionType.cancel:
        appException = NetworkException('请求已取消');
        break;
      case DioExceptionType.connectionError:
        appException = NetworkException('网络连接失败，请检查网络设置');
        break;
      case DioExceptionType.unknown:
        appException = NetworkException('网络异常，请稍后重试');
        break;
    }

    // 关键修改：使用handler.reject来传递转换后的异常
    if (!GetUtils.isNull(appException) && isChangeNetWorkErrorToDetail) {
      // 创建一个新的DioException，将我们的自定义异常作为其error属性
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: appException, // 您的自定义异常被放在这里
          type: err.type,
          response: err.response,
          message: appException?.toString() ?? err.message, // 更新消息
        ),
      );
    } else {
      // 如果没有转换，继续传递原始异常
      handler.next(err);
    }
  }

  AppException? _handleBadResponse(DioException err) {
    final statusCode = err.response?.statusCode;
    final data = err.response?.data;


    if (statusCode == 401) {
      return UnauthorizedException('登录已过期，请重新登录');
    } else if (statusCode == 403) {
      return PermissionDeniedException('权限不足');
    } else if (statusCode == 404) {
      return NotFoundException('请求的资源不存在');
    } else if (statusCode == 500) {
      return ServerException('服务器内部错误');
    } else if (data is Map<String, dynamic>) {
      // 处理业务错误
      final code = data['code'];
      final message = data['message'] ?? '请求失败';
      return BusinessException(message, code: code);
    } else {
      // 对于其他未明确处理的badResponse，返回基础的NetworkException
      return NetworkException('网络请求失败: $statusCode');
    }
  }
}