import 'dart:convert';
import 'dart:io';
import 'package:e_racing_app/core/service/http_request.dart';
import 'package:e_racing_app/core/service/http_response.dart';
import 'package:e_racing_app/core/tools/crypto/crypto_service.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

import 'base/base_service.dart';



class ApiService extends BaseService {
  @visibleForTesting
  returnResponse(http.Response response, Function(HTTPResponse) success,
      Function(HTTPResponse) error) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
      case 203:
      case 204:
        success(handleResponse(jsonDecode(response.body)));
        return;
      case 422:
      case 400:
      case 401:
      case 403:
      case 500:
      default:
        dynamic responseJson = jsonDecode(response.body);
        error(HTTPResponse.onResponse(responseJson['data'],
            Response.fromJson(responseJson['response']),
            responseJson['safe']));
    }
  }

  @override
  Future getResponse(HTTPRequest request, Function(HTTPResponse) success,
      Function(HTTPResponse) error) async {
    try {
      http.Response response;
      switch (request.verb) {
        case HTTPVerb.get:
          response = await http.get(parseRequestParams(request.endpoint, request.params?.data),
              headers: headers());
          break;
        case HTTPVerb.post:
          response = await http.post(parseRequest(request.endpoint),
              headers: headers(), body: jsonEncode(request.params));
          break;
        case HTTPVerb.delete:
          response = await http.delete(parseRequest(request.endpoint));
          break;
        case HTTPVerb.put:
          response = await http.put(parseRequest(request.endpoint),
              body: request.params);
          break;
      }
      returnResponse(response, success, error);
    } on SocketException {
      error(HTTPResponse());
    }
  }

  Uri parseRequestParams(String endpoint, String? param) {
    if(param != null){
      endpoint += '/$param';
    }
    return parseRequest(endpoint);
  }

  Uri parseRequest(String endpoint) {
    return Uri.parse(server + endpoint);
  }

  Map<String, String> headers() {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'bearer_token': Session.instance.getBearerToken()?.token ?? ''
    };
    return headers;
  }

  HTTPResponse handleResponse(response) {
    dynamic data = response['data'];
    bool isSafe = response['safe'];
    if (isSafe) {
      data = CryptoService.instance.aesDecrypt(data);
    }

    return HTTPResponse.onResponse(
        data, Response.fromJson(response['response']), isSafe);
  }
}
