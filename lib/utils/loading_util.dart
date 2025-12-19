// utils/loading_util.dart
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingUtil {
  static int _requestCount = 0; // 请求计数器，用于处理并发请求
  static bool _isShowing = false; // 当前是否正在显示Loading

  // 可配置的选项
  static Duration _debounceDelay = Duration(milliseconds: 100); // 防抖延迟，避免请求太快时闪烁
  static Duration _maxShowTime = Duration(seconds: 30); // 最大显示时间，防止网络异常时Loading一直存在
  static Timer? _maxShowTimer; // 最大显示时长定时器

  /// 显示Loading
  static void showLoading() {
    _requestCount++; // 有新请求时，计数器加1

    // 防抖处理：如果已经在显示，则不再重复弹出
    if (_isShowing) {
      return;
    }

    _isShowing = true;

    // 设置最大显示时长定时器，超时自动关闭
    _maxShowTimer = Timer(_maxShowTime, () {
      if (_isShowing) {
        dismissLoading();
        Get.snackbar('提示', '请求超时，请检查网络');
      }
    });

    // 利用防抖避免频繁操作，提升体验
    Future.delayed(_debounceDelay, () {
      if (_requestCount > 0 && _isShowing) {
        Get.dialog(
          WillPopScope(
            // 拦截返回键，避免用户误触关闭Loading
            onWillPop: () async => false,
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          ),
          barrierDismissible: false, // 不可通过点击遮罩关闭
        );
      }
    });
  }

  /// 隐藏Loading
  static void dismissLoading() {
    if (_requestCount > 0) {
      _requestCount--; // 请求完成，计数器减1
    }

    // 只有当所有请求都完成时，才真正关闭Loading
    if (_requestCount == 0 && _isShowing) {
      _maxShowTimer?.cancel(); // 取消超时定时器
      _isShowing = false;
      if (Get.isDialogOpen ?? false) {
        Get.back(closeOverlays: true);
      }
    }
  }

  // 可选：用于特殊场景下手动控制
  static void show() => showLoading();
  static void dismiss() => dismissLoading();

  // 可选：重置计数器（在用户登出或App进入后台等场景时调用）
  static void reset() {
    _requestCount = 0;
    if (_isShowing) {
      _maxShowTimer?.cancel();
      _isShowing = false;
      if (Get.isDialogOpen ?? false) {
        Get.back(closeOverlays: true);
      }
    }
  }
}