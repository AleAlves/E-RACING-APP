class ApiException implements Exception {

  final String? _message;
  bool? isBusinessError;

  ApiException(this._message, {this.isBusinessError});

  String message() {
    return _message ?? '';
  }

  bool isBusiness(){
    return isBusinessError ?? false;
  }
}