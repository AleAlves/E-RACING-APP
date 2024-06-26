import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

import '../../../core/model/pair_model.dart';
import '../data/league_members_model.dart';

class GetMembersUseCase<T> extends BaseUseCase<T> {
  late String _id;

  GetMembersUseCase<T> req({required String id}) {
    _id = id;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T?) success, required Function failure}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/leagues/members",
        params: HTTPRequesParams(query: Pair("id", _id)),
        verb: HTTPVerb.get));
    if (response.isSuccessfully) {
      var list = response.data == null
          ? null
          : response.data
              .map<LeagueMembersModel>(
                  (members) => LeagueMembersModel.fromJson(members))
              .toList() as T;
      success.call(list);
    } else {
      failure.call(ApiException(message: response.response?.status));
    }
  }
}
