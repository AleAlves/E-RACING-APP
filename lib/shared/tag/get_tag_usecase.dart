import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/tag_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

class GetTagUseCase<T> extends BaseUseCase<T> {
  @override
  Future<void> invoke(
      {required Function(T) success, required Function failure}) async {
    var response = await super
        .remote(Request(endpoint: "api/v1/tags", verb: HTTPVerb.get));
    if (response.isSuccessfully) {
      success.call((response.data as List)
          .map<TagModel>((tags) => TagModel.fromJson(tags))
          .toList() as T);
    } else {
      failure.call(ApiException(message: response.response?.status));
    }
  }
}
