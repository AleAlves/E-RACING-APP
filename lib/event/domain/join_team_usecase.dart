import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/model/team_model.dart';
import 'package:e_racing_app/event/data/event_create_model.dart';
import 'package:e_racing_app/event/data/team_create_model.dart';
import 'package:e_racing_app/event/data/team_request_model.dart';
import 'package:e_racing_app/event/presentation/ui/event_flow.dart';

class JoinTeamUseCase<T> extends BaseUseCase<T> {
  late String? _teamId;
  late String? _eventId;

  JoinTeamUseCase<T> build({
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
        endpoint: "api/v1/team/join",
        verb: HTTPVerb.post,
        params: HTTPRequesParams(
            data: TeamRequestModel(eventId: _eventId, teamId: _teamId))));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Added to the team",
          action: "Ok",
          next: EventFlows.detail) as T);
    } else {
      error.call();
    }
  }
}
