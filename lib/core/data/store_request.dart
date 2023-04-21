enum Operation { fetch, save, erase }

class StoreRequest<T> {
  late T? data;
  final String key;
  final Operation operation;

  StoreRequest(this.key, this.operation, {this.data});
}
