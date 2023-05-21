import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:crypton/crypton.dart';
import 'package:e_racing_app/login/legacy/domain/model/keychain_model.dart';
import 'package:encrypt/encrypt.dart';

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
    return encrypt(data, Session.instance.getKeyChain().key,
        Session.instance.getKeyChain().iv);
  }

  dynamic aesDecrypt(String data) {
    print(Session.instance.getKeyChain().key);
    print(Session.instance.getKeyChain().iv);
    var decodedString = decrypt(data, Session.instance.getKeyChain().key,
        Session.instance.getKeyChain().iv);
    return jsonDecode(decodedString);
  }

  String rsaEncrypt(String? publicKey, String? data) {
    try {
      var cleanKey = publicKey
          ?.replaceAll("-----BEGIN PUBLIC KEY-----", "")
          .replaceAll("-----END PUBLIC KEY-----", "")
          .replaceAll("\n", "")
          .trim();
      return RSAPublicKey.fromString(cleanKey!).encrypt(data ?? "");
    } catch (e) {
      print(e);
    }
    return "";
  }

  String getSHA256Hah(String? data) {
    return sha256.convert(utf8.encode(data ?? "")).toString();
  }
}
