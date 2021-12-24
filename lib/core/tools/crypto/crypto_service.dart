import 'dart:convert';

import 'package:crypton/crypton.dart';
import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';
import 'package:e_racing_app/login/domain/model/keychain_model.dart';

import '../session.dart';
import 'aes_tools.dart';

class CryptoService {
  CryptoService._();

  static CryptoService? _instance;

  static CryptoService get instance {
    return _instance = CryptoService._();
  }

  static void dispose() {
    _instance = null;
  }

  KeyChainModel generateAESKeys() {
    return KeyChainModel(Key.fromSecureRandom(16), IV.fromSecureRandom(16));
  }

  String aesEncrypt(String data) {
    return encrypt(data, Session.instance.getKeyChain().key, Session.instance.getKeyChain().iv);
  }

  dynamic aesDecrypt(String data) {
    print(Session.instance.getKeyChain().key);
    print(Session.instance.getKeyChain().iv);
    var decodedString = decrypt(data, Session.instance.getKeyChain().key, Session.instance.getKeyChain().iv);
    return jsonDecode(decodedString);
  }

  String rsaEncrypt(String? publicKey, String? data) {
    try {
      var cleanKey = publicKey
          ?.replaceAll("-----BEGIN PUBLIC KEY-----", "")
          .replaceAll("-----END PUBLIC KEY-----", "")
          .replaceAll("\n", "")
          .trim();
      var rsaPublicKey = RSAPublicKey.fromString(cleanKey!);
      return rsaPublicKey.encrypt(data!);
    } catch (e) {
      print(e);
    }
    return "";
  }

  String sha256(String data) {
    return sha1.convert(utf8.encode(data)).toString();
  }
}
