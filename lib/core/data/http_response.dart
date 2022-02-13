class HTTPResponse<T> {
  T? data;
  late bool safe;
  bool isSuccessfully = false;
  Response? response;

  HTTPResponse();

  HTTPResponse.onResponse(this.data, this.response, this.safe, this.isSuccessfully);
}

class Response {
  final String? status;
  final int? code;

  Response({this.status, this.code});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
        status: json['status'] as String?, code: json['code'] as int?);
  }
}
