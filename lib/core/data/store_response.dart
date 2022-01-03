class StoreResponse<T> {
  T? data;
  late bool isSuccessfully;

  StoreResponse(this.data, this.isSuccessfully);

  StoreResponse.onResponse(this.data, this.isSuccessfully);
}
