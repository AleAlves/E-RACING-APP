import 'dart:convert';

import 'package:e_racing_app/core/tools/crypto/crypto_service.dart';
import 'package:e_racing_app/core/tools/session.dart';

import '../model/pair_model.dart';

enum HTTPVerb { get, post, delete, put }

enum CypherSchema { rsa, aes }

class Request {
  late HTTPRequesParams? params;
  late String endpoint;
  late HTTPVerb verb;

  Request({required this.endpoint, required this.verb, this.params});
}

class HTTPRequesParams {
  late dynamic data;
  late Pair<dynamic, dynamic>? query;
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
            data = CryptoService.instance
                .rsaEncrypt(Session.instance.getRSAKey()?.publicKey, _encode());
            break;
          case CypherSchema.aes:
          default:
            data = CryptoService.instance.aesEncrypt(_encode());
            break;
        }
      } else {
        if (jsonEncoded) {
          data = _encode();
        }
      }
    }
    if (query?.second != null) {
      if (safe) {
        switch (cypherSchema) {
          case CypherSchema.rsa:
            query?.second = CryptoService.instance.rsaEncrypt(
                Session.instance.getRSAKey()?.publicKey, query?.second);
            break;
          case CypherSchema.aes:
          default:
            query?.second = CryptoService.instance.aesEncrypt(query?.second);
            break;
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {"data": data, "safe": safe};
    return json;
  }

  String _encode() {
    try {
      return jsonEncode(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
