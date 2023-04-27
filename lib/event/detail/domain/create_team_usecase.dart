import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/model/team_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

import '../../core/data/team_create_model.dart';
import '../../core/presentation/ui/event_flow.dart';

class CreateTeamUseCase<T> extends BaseUseCase<T> {
  late String? _eventId;
  late TeamModel _team;

  CreateTeamUseCase<T> build({required String? id, required TeamModel team}) {
    _eventId = id;
    _team = team;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/team",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(
            data: TeamCreateModel(eventId: _eventId, team: _team))));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Team Created",
          action: "Ok",
          next: EventFlow.eventDetail) as T);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
