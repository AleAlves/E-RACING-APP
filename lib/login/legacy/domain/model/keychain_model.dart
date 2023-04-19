
import 'package:encrypt/encrypt.dart';

class KeyChainModel {

  late Key key;
  late IV iv;

  KeyChainModel(this.key, this.iv,);

  factory KeyChainModel.fromJson(Map<String, dynamic> json) {
    return KeyChainModel(json['key'], (json['iv']));
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> keychain = {"key": key.base16, "iv": iv.base16};
    return keychain;
  }
}