import '../service/api_exception.dart';

abstract class BaseViewModel<T> {
  void onNavigate(T route);

  void onError(ApiException exception);
}
