/// View层基础接口
abstract class IView {
  void showLoading();
  void hideLoading();
  void showError(String message);
}