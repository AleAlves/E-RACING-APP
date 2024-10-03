import 'package:e_racing_app/core/data/store_request.dart';
import 'package:e_racing_app/core/data/store_response.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

abstract class RemoteRepository {
  Future<dynamic> call(StoreRequest query);
}

class LocalRepository {
  Future<StoreResponse> save({@required key, @required data}) async {
    try {
      localStorage.setItem(key, data);
      return StoreResponse(null, true);
    } catch (e) {
      return StoreResponse(null, false);
    }
  }

  Future<StoreResponse> get({@required key}) async {
    try {
      return StoreResponse(localStorage.getItem(key), true);
    } catch (e) {
      return StoreResponse(null, false);
    }
  }

  Future<StoreResponse> delete({@required key}) async {
    try {
      localStorage.removeItem(key);
      return StoreResponse(null, true);
    } catch (e) {
      return StoreResponse(null, false);
    }
  }

  call(StoreRequest query) async {
    switch (query.operation) {
      case Operation.fetch:
        return get(key: query.key);
      case Operation.save:
        return save(key: query.key, data: query.data);
      case Operation.erase:
        return delete(key: query.key);
    }
  }
}
