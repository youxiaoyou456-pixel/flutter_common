import 'dart:ui';

import '../IALL/IModel.dart';
import '../IALL/IPresenter.dart';
import '../IALL/IView.dart';

/// Presenter基类
abstract class BasePresenter<V extends IView, M extends IModel> implements IPresenter<V> {
  V? _view;
  M? _model;
  bool _isViewAttached = false;

  @override
  void attachView(V view) {
    _view = view;
    _isViewAttached = true;
    onViewAttached();
  }

  @override
  void detachView() {
    _isViewAttached = false;
    _view = null;
  }

  @override
  void init() {
    _model = createModel();
  }

  @override
  void dispose() {
    _model?.dispose();
    _model = null;
    detachView();
  }

  /// 获取View实例
  V? get view {
    if (!_isViewAttached) {
      return null;
    }
    return _view;
  }

  /// 检查View是否已挂载
  bool get isViewAttached => _isViewAttached;

  /// 创建Model实例
  M createModel();

  /// View挂载后的回调
  void onViewAttached() {}

  /// 安全执行View操作（检查View是否可用）
  void executeSafe(VoidCallback action) {
    if (isViewAttached) {
      action();
    }
  }
}