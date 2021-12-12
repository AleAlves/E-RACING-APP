import 'dart:convert';

import 'package:e_racing_app/core/tools/crypto/crypto_service.dart';
import 'package:e_racing_app/core/tools/session.dart';

enum HTTPVerb { get, post, delete, put }
enum CypherSchema { rsa, aes }

class HTTPRequest {
  late HTTPRequesParams? params;
  late String endpoint;
  late HTTPVerb verb;

  HTTPRequest({required this.endpoint, required this.verb, this.params});
}

class HTTPRequesParams {
  late dynamic data;
  late dynamic query;
  bool safe;
  bool jsonEncoded;
  CypherSchema? cypherSchema = CypherSchema.aes;

  HTTPRequesParams(
      {this.data,
      this.query,
      this.safe = true,
      this.jsonEncoded = true,
      this.cypherSchema = CypherSchema.aes}) {
    if (data != null) {
      if (safe) {
        switch (cypherSchema) {
          case CypherSchema.rsa:
            data = CryptoService.instance.rsaEncrypt(
                Session.instance.getRSAKey()?.publicKey, jsonEncode(data));
            break;
          case CypherSchema.aes:
          default:
            data = CryptoService.instance.aesEncrypt(jsonEncode(data));
            break;
        }
      } else {
        if (jsonEncoded) {
          data = jsonEncode(data);
        }
      }
    }
    if (query != null) {
      if (safe) {
        switch (cypherSchema) {
          case CypherSchema.rsa:
            query = CryptoService.instance
                .rsaEncrypt(Session.instance.getRSAKey()?.publicKey, query);
            break;
          case CypherSchema.aes:
          default:
            query = CryptoService.instance.aesEncrypt(query);
            break;
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {"data": data, "safe": safe};
    return json;
  }
}
