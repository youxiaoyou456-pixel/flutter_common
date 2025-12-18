import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../http/interceptors/exceptions.dart';

class ErrorHandle{
   static void handleError(dynamic error) {
     String message;
     if (error == null) {
       message = "发生了一个未知错误";
     } else if (error is AppException) {
       message = error.message;
     } else if (error is Map && error['error'] is AppException) {
       // 或者根据你的封装格式判断
       message = (error['error'] as AppException).message;
     } else {
       message = "error";
     }
     _showToast(message);
  }

   static void _showToast(String message) {
    Get.snackbar('提示',message);
  }
}