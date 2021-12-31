import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/service/http_request.dart';

class GetMediaUseCase<T> extends BaseUseCase<T> {
  final String id;

  GetMediaUseCase(this.id);

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/media",
        verb: HTTPVerb.get,
        params: HTTPRequesParams(query: id)));
    if (response.isSuccessfully) {
      success(MediaModel.fromJson(response.data) as T);
    } else {
      error.call();
    }
  }
}
