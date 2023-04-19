import 'package:e_racing_app/login/legacy/domain/model/bearer_token_model.dart';
import 'package:e_racing_app/login/legacy/domain/model/keychain_model.dart';
import 'package:e_racing_app/login/legacy/domain/model/public_key_model.dart';
import 'package:e_racing_app/login/legacy/domain/model/user_model.dart';

import '../model/pair_model.dart';

class Session {
  static UserModel? _userModel;
  static late KeyChainModel _keyChain;
  static PublicKeyModel? _publicKeyModel;
  static BearerTokenModel? _bearerTokenModel;
  static String? _currentLeagueId;
  static String? _currenEventId;
  static String? _currenRaceId;
  static String _server = "https://e-racing-api-dev.herokuapp.com/";
  static String? _fcmToken;
  static String? _deeplink;
  static bool _hasDeeplink = false;

  Session._();

  static Session? _instance;

  static Session get instance {
    return _instance = Session._();
  }

  static void dispose() {
    _instance = null;
  }

  void setUser(UserModel userModel) {
    _userModel = userModel;
  }

  UserModel? getUser() {
    return _userModel;
  }

  void setRSAKey(PublicKeyModel publicKeyModel) {
    _publicKeyModel = publicKeyModel;
  }

  PublicKeyModel? getRSAKey() {
    return _publicKeyModel;
  }

  void setKeyChain(KeyChainModel keyChain) {
    _keyChain = keyChain;
  }

  KeyChainModel getKeyChain() {
    return _keyChain;
  }

  void setBearerToken(BearerTokenModel? bearerTokenModel) {
    _bearerTokenModel = bearerTokenModel;
  }

  BearerTokenModel? getBearerToken() {
    return _bearerTokenModel;
  }

  void setLeagueId(String? id) {
    _currentLeagueId = id;
  }

  String? getLeagueId() {
    return _currentLeagueId;
  }

  void setEventId(String? id) {
    _currenEventId = id;
  }

  String? getEventId() {
    return _currenEventId;
  }

  void setRaceId(String? id) {
    _currenRaceId = id;
  }

  String? getRaceId() {
    return _currenRaceId;
  }

  void setDrive(String url) {
    _server = url;
  }

  String getURL() {
    return _server;
  }

  void setURL(String url) {
    _server = url;
  }

  String? getFCMToken() {
    return _fcmToken;
  }

  void setFCMToken(String? fcmToken) {
    print("TOKEN FCM: $fcmToken");
    _fcmToken = fcmToken;
  }

  String? getDeeplink() {
    return _deeplink;
  }

  void setDeeplink(String? deeplink) {
    _deeplink = deeplink;
  }

  bool onDeeplinkFlow() {
    return _hasDeeplink;
  }

  void setOnDeeplinkFlow(bool isOnDeeplinkFlow) {
    _hasDeeplink = isOnDeeplinkFlow;
  }
}
