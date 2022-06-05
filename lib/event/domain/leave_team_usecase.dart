import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/event/data/team_request_model.dart';
import 'package:e_racing_app/event/presentation/ui/event_flow.dart';

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
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/team/leave",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(
            data: TeamRequestModel(eventId: _eventId, teamId: _teamId))));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Exited the team",
          action: "Ok",
          next: EventFlow.eventDetail) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
