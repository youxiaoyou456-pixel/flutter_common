// interceptors/loading_interceptor.dart
import 'package:dio/dio.dart';
import '../../utils/loading_util.dart';


class LoadingInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 关键：通过请求的extra配置判断是否需要为此请求显示Loading[8](@ref)
    // 默认值为true，即如果没有明确配置，则显示Loading
    final bool showLoading = options.queryParameters['showLoading'] ?? true;

    if (showLoading) {
      LoadingUtil.showLoading();
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 响应成功时，也需要判断该请求是否开启了Loading
    final bool showLoading = response.requestOptions.queryParameters['showLoading'] ?? true;
    if (showLoading) {
      LoadingUtil.dismissLoading();
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 请求失败时，同样需要隐藏Loading
    final bool showLoading = err.requestOptions.queryParameters['showLoading'] ?? true;
    if (showLoading) {
      LoadingUtil.dismissLoading();
    }
    handler.next(err);
  }
}