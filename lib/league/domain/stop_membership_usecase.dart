import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/event/data/event_create_model.dart';
import 'package:e_racing_app/event/data/event_do_subscribe_model.dart';
import 'package:e_racing_app/event/presentation/ui/event_flow.dart';

class StopMembershipUseCase<T> extends BaseUseCase<T> {
  String? _leagueId;

  StopMembershipUseCase<T> build(
      {required String? leagueId}) {
    _leagueId = leagueId;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/league/stop-membership",
        verb: HTTPVerb.get,
        params: HTTPRequesParams(query: _leagueId ?? '')));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "You're no longer a member",
          action: "Ok",
          next: EventFlows.detail) as T);
    } else {
      error.call();
    }
  }
}
