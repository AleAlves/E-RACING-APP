import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/event/data/event_home_model.dart';

class GetEventUseCase<T> extends BaseUseCase<T> {
  late String _id;

  GetEventUseCase<T> params({required String id}) {
    _id = id;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T?) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event/home",
        params: HTTPRequesParams(query: _id),
        verb: HTTPVerb.get));
    if (response.isSuccessfully) {
      success.call(response.data == null
          ? null
          : EventHomeModel.fromJson(response.data) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
