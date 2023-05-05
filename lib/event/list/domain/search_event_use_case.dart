import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

import '../data/event_search_request.dart';

class SearchEventsUseCase<T> extends BaseUseCase<T> {
  late List<String>? _tagIds;

  SearchEventsUseCase<T> build({required List<String>? tagIds}) {
    _tagIds = tagIds;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event/search",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(data: EventSearchRequest(_tagIds))));
    if (response.isSuccessfully) {
      var list = response.data == null
          ? null
          : response.data
              .map<EventModel>((event) => EventModel.fromJson(event))
              .toList() as T;
      success.call(list as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
