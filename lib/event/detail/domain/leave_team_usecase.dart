import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

import '../../core/data/team_request_model.dart';
import '../presentation/router/event_detail_router.dart';

class LeaveTeamUseCase<T> extends BaseUseCase<T> {
  late String? _teamId;
  late String? _eventId;

  LeaveTeamUseCase<T> build({
    required String? teamId,
    required String? eventId,
  }) {
    _teamId = teamId;
    _eventId = eventId;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/team/leave",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(
            data: TeamRequestModel(eventId: _eventId, teamId: _teamId))));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Exited the team",
          action: "Ok",
          route: EventDetailRouter.info) as T);
    } else {
      failure.call(ApiException(message: response.response?.status));
    }
  }
}
