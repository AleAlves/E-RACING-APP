import 'package:e_racing_app/core/data/http_response.dart';
import 'package:e_racing_app/core/data/local_repository.dart';
import 'package:e_racing_app/core/data/remote_repository.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/data/store_request.dart';
import 'package:e_racing_app/core/data/store_response.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseUseCase<T> {
  final _remote = RemoteRepositoryImpl();
  final _local = LocalRepository();

  void invoke({required Function(T?) success, required Function error});

  @protected
  Future<HTTPResponse> remote(Request request) async {
    return await _remote.call(request);
  }

  @protected
  Future<StoreResponse> local(StoreRequest request) async {
    return await _local.call(request);
  }
}
