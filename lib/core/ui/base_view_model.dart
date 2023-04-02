abstract class BaseViewModel<T> {
  void onNavigate(T route);

  void onError(T route);
}
