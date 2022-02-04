import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';

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
        endpoint: "api/v1/event",
        params: HTTPRequesParams(query: _id),
        verb: HTTPVerb.get));
    if (response.isSuccessfully) {
      success.call(response.data == null
          ? null
          : EventModel.fromJson(response.data) as T);
    } else {
      error.call();
    }
  }
}
