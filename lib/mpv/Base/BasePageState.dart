import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common_utils/utils/loading_util.dart';

import '../../utils/error_handle.dart';
import '../IALL/IView.dart';
import 'BasePresenter.dart';

/// 页面状态基类
abstract class BasePageState<T extends StatefulWidget, P extends BasePresenter>
    extends State<T> implements IView {

  late P presenter;


  @override
  void initState() {
    super.initState();
    presenter = createPresenter();
    presenter.init();
    presenter.attachView(this);
    setupPresenterListeners();
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  /// 创建Presenter实例
  P createPresenter();

  /// 设置Presenter监听器
  void setupPresenterListeners() {}


  /// IView接口实现
  @override
  void showLoading() {
    LoadingUtil.showLoading();
  }

  @override
  void hideLoading() {
    LoadingUtil.dismissLoading();
  }

  @override
  void showError(String message) {
    ErrorHandle.handleError(message);
  }
}