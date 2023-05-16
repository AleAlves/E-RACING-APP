import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/league/member/presentation/navigation/league_member_navigation.dart';

import '../data/remove_member_model.dart';

class RemoveMemberUseCase<T> extends BaseUseCase<T> {
  late String _memberId;
  late String _leagueId;

  RemoveMemberUseCase<T> req(
      {required String memberId, required String leagueId}) {
    _memberId = memberId;
    _leagueId = leagueId;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T?) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/league/membership/remove",
        params: HTTPRequesParams(data: RemoveMemberModel(_leagueId, _memberId)),
        verb: HTTPVerb.post));
    if (response.isSuccessfully) {
      success.call(StatusModel(
          message: "Member successfully removed",
          action: "Ok",
          route: LeagueMemberNavigationSet.main) as T);
    } else {
      failure.call(ApiException(message: response.response?.status));
    }
  }
}
