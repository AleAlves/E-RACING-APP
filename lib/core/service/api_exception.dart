class ApiException implements Exception {

  final String? message;
  final bool? isBusinessError;

  ApiException({this.message, required this.isBusinessError});

  bool isBusiness(){
    return isBusinessError ?? false;
  }
}