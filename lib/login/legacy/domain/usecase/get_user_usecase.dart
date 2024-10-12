import 'dart:convert';

import 'package:e_racing_app/core/data/store_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

import '../model/user_model.dart';

class GetUserUseCase<T> extends BaseUseCase<T?> {
  @override
  Future<void> invoke(
      {required Function(T?) success, required Function failure}) async {
    var response = await super.local(StoreRequest("user", Operation.fetch));
    if (response.isSuccessfully) {
      var user = json.decode(response.data);
      var data = response.data == null ? null : UserModel.fromJson(user) as T;
      success.call(data);
    } else {
      failure.call(ApiException(message: "error trying to retrive local data"));
    }
  }
}
