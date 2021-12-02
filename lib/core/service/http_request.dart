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
  late bool safe;
  bool jsonEncoded = true;
  CypherSchema? cypherSchema = CypherSchema.aes;

  HTTPRequesParams({this.data, required this.safe, this.cypherSchema, required this.jsonEncoded}) {
    if (safe) {
      dynamic safeData;
      switch (cypherSchema) {
        case CypherSchema.rsa:
          safeData = CryptoService.instance.rsaEncrypt(Session.instance.getRSAKey()!.publicKey, jsonEncode(data));
          break;
        case CypherSchema.aes:
          safeData =
          CryptoService.instance.aesEncrypt(jsonEncode(data));
          break;
        default:
          break;
      }
      data = safeData;
    }
    else{
      if(jsonEncoded == true){
        data = jsonEncode(data);
      }
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {"data": data, "safe": safe};
    return json;
  }
}
