
import 'package:e_racing_app/core/data/store_request.dart';
import 'package:e_racing_app/core/data/store_response.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

abstract class RemoteRepository {
  Future<dynamic> call(StoreRequest query);
}

class LocalRepository {
  final LocalStorage storage = LocalStorage('localstorage_app');

  Future<StoreResponse> save({@required key, @required data}) async {
    try{
      await storage.setItem(key, data);
      return StoreResponse(null, true);
    }catch(e){
      return StoreResponse(null, false);
    }
  }

  Future<StoreResponse> get({@required key}) async {
    try{
      return StoreResponse(await storage.getItem(key), true);
    }catch(e){
      return StoreResponse(null, false);
    }
  }

  Future<StoreResponse> delete({@required key}) async {
    try{
      await storage.deleteItem(key);
      return StoreResponse(null, true);
    }catch(e){
      return StoreResponse(null, false);
    }
  }

  call(StoreRequest query) async {
    await storage.ready;
    switch (query.operation) {
      case Operation.select:
        return get(key: query.key);
      case Operation.create:
        return save(key: query.key, data: query.data);
      case Operation.delete:
        return delete(key: query.key);
    }
  }
}
