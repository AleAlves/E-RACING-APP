
enum Operation { select, create, delete }

class StoreRequest<T> {
  late T? data;
  final String key;
  final Operation operation;

  StoreRequest(this.key, this.operation, {this.data});
}
