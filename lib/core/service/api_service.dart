import 'dart:convert';
import 'dart:io';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/data/http_response.dart';
import 'package:e_racing_app/core/tools/crypto/crypto_service.dart';
import 'package:e_racing_app/core/tools/session.dart';

import 'package:http/http.dart' as http;

import 'base/base_service.dart';



class ApiService extends BaseService {

  Uri parseRequestParams(String endpoint, String? query) {
    if(query != null){
      var encoded = base64Encode(utf8.encode(query));
      endpoint += '?id=$encoded';
    }
    return parseRequest(endpoint);
  }

  Uri parseRequest(String endpoint) {
    return Uri.parse(Session.instance.getURL() + endpoint);
  }

  Map<String, String> headers() {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': Session.instance.getBearerToken()?.token ?? ''
    };
    return headers;
  }

  HTTPResponse handleResponse(response) {
    dynamic data = response['data'];
    bool isSafe = response['safe'];
    if (isSafe) {
      data = CryptoService.instance.aesDecrypt(data);
    }

    return HTTPResponse.onResponse(data, Response.fromJson(response['response']), isSafe, true);
  }

  @override
  Future<HTTPResponse> call(Request request) async {
    http.Response response;
    try {
      switch (request.verb) {
        case HTTPVerb.get:
          response = await http.get(
              parseRequestParams(request.endpoint, request.params?.query),
              headers: headers());
          break;
        case HTTPVerb.post:
          response = await http.post(
              parseRequest(request.endpoint),
              headers: headers(),
              body: jsonEncode(request.params));
          break;
        case HTTPVerb.delete:
          response = await http.delete(
              parseRequestParams(request.endpoint, request.params?.query),
              headers: headers());
          break;
        case HTTPVerb.put:
          response = await http.put(
              parseRequest(request.endpoint),
              headers: headers(),
              body: jsonEncode(request.params));
          break;
      }
      print("Response URL: ${response.request?.url.path}");
      print("Response Head: ${response.request?.headers}");
      print("Response Status: ${response.statusCode}");
      print("Response body: ${response.body}");
    } on SocketException {
      return HTTPResponse();
    }
    return returnResponses(response);
  }

  returnResponses(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
      case 203:
      case 204:
        return handleResponse(jsonDecode(response.body));
      case 422:
      case 400:
      case 401:
      case 402:
      case 403:
      case 404:
      case 500:
      case 501:
      case 502:
      case 503:
      default:
        dynamic responseJson = jsonDecode(response.body);
        return HTTPResponse.onResponse(responseJson['data'],
            Response.fromJson(responseJson['response']), responseJson['safe'] ?? false, false);
    }
  }
}
