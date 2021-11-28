import 'package:encrypt/encrypt.dart';

String encrypt(String plainData, Key key, IV iv) {
  final cypher = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

  final encrypted = cypher.encrypt(plainData, iv: iv);
  return encrypted.base64;
}

String decrypt(String encryptedData, Key key, IV iv) {
  final cypher = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

  final decrypted = cypher.decrypt(Encrypted.fromBase64(encryptedData), iv: iv);
  return decrypted;
}
