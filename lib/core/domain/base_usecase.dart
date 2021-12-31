import 'package:e_racing_app/core/data/local_repository.dart';
import 'package:e_racing_app/core/data/remote_repository.dart';
import 'package:e_racing_app/core/service/http_request.dart';
import 'package:e_racing_app/core/service/http_response.dart';
import 'package:e_racing_app/core/service/store_request.dart';
import 'package:e_racing_app/core/service/store_response.dart';

abstract class BaseUseCase<T> {

  final _remote =  RemoteRepositoryImpl();
  final _local = LocalRepository();

  void invoke({required Function(T) success, required Function error});

  Future<HTTPResponse> remote(Request request) async {
    return await _remote.call(request);
  }

  Future<StoreResponse> local(StoreRequest request) async {
    return await _local.call(request);
  }
}
