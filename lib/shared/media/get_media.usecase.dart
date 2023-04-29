import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

import '../../core/model/pair_model.dart';

class GetMediaUseCase<T> extends BaseUseCase<T> {
  late String? _id;

  GetMediaUseCase<T> params({required String? id}) {
    _id = id;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/media",
        verb: HTTPVerb.get,
        params: HTTPRequesParams(query: Pair("id", _id))));
    if (response.isSuccessfully) {
      success(MediaModel.fromJson(response.data) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
