class UseCaseResponse<T> {
  UseCaseResponse(this.success, this.data);
  final T? data;
  final bool success;
}
