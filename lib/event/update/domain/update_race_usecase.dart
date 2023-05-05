import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/race_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/event/event_router.dart';

import '../../../core/model/media_model.dart';
import '../data/update_race_model.dart';

class UpdateRaceUseCase<T> extends BaseUseCase<T> {
  late String? _eventId;
  late RaceModel? _raceModel;
  late MediaModel? _media;

  UpdateRaceUseCase<T> build(
      {required RaceModel? raceModel,
      required String? eventId,
      required MediaModel? media}) {
    _eventId = eventId;
    _raceModel = raceModel;
    _media = media;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/event/race",
        verb: HTTPVerb.put,
        params: HTTPRequesParams(
            data: UpdateRaceModel(
                eventId: _eventId, raceModel: _raceModel, media: _media))));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Race Updated",
          action: "Ok",
          route: EventRouter.update) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
