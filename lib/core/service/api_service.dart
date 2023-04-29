import 'dart:convert';
import 'dart:io';

import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/data/http_response.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/tools/crypto/crypto_service.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:http/http.dart' as http;

import 'base/base_service.dart';

class ApiService extends BaseService {
  Uri parseRequestParams(String endpoint, Pair<dynamic, dynamic>? query) {
    if (query != null) {
      var encoded = base64Encode(utf8.encode(query.second));
      endpoint += '?${query.first}=$encoded';
      print(" *** Request query (base64): $encoded \n");
    }
    print(" *** Request query (raw): ${query?.second} \n");
    print(" *** Request endpoint: $endpoint \n");
    return parseRequest(endpoint);
  }

  Uri parseRequest(String endpoint) {
    print(" *** Request URL: ${Session.instance.getURL() + endpoint} \n");
    return Uri.parse(Session.instance.getURL() + endpoint);
  }

  Map<String, String> headers() {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': Session.instance.getBearerToken()?.token ?? ''
    };
    print(" *** Autorization:  $headers \n");
    return headers;
  }

  HTTPResponse handleResponse(response) {
    dynamic data = response['data'];
    bool isSafe = response['safe'];
    if (isSafe) {
      data = CryptoService.instance.aesDecrypt(data);
    }

    return HTTPResponse.onResponse(
        data, Response.fromJson(response['response']), isSafe, true);
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
          response = await http.post(parseRequest(request.endpoint),
              headers: headers(), body: jsonEncode(request.params));
          break;
        case HTTPVerb.delete:
          response = await http.delete(
              parseRequestParams(request.endpoint, request.params?.query),
              headers: headers(),
              body: jsonEncode(request.params));
          break;
        case HTTPVerb.put:
          response = await http.put(
              parseRequestParams(request.endpoint, request.params?.query),
              headers: headers(),
              body: jsonEncode(request.params));
          break;
      }
      print(" *** Response URL: ${response.request?.url.path} \n");
      print(" *** Response Head: ${response.request?.headers} \n");
      print(" *** Response Status: ${response.statusCode} \n");
      print(" *** Response body: ${response.body} \n");
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
        return HTTPResponse.onResponse(
            responseJson['data'],
            Response.fromJson(responseJson['response']),
            responseJson['safe'] ?? false,
            false);
    }
  }
}
