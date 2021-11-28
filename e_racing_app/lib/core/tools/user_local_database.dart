import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:e_racing_app/login/domain/model/user_model.dart';


class UserLocalDatabase {
  final key = 'user';
  final LocalStorage storage = LocalStorage('localstorage_app');

  void saveUser(UserModel userModel) async {
    final user = json.encode(userModel.toJson());
    await storage.ready;
    storage.setItem(key, user);
  }

  Future<UserModel?> getUser() async {
    await storage.ready;
    var user = storage.getItem(key);
    if(user == null) {
      return null;
    } else {
      return UserModel.fromJson(json.decode(user));
    }
  }

  void deleteUser() {
    storage.deleteItem(key);
  }
}
