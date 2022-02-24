import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/login/domain/model/user_model.dart';

class GetMembersUseCase<T> extends BaseUseCase<T> {
  late String _id;

  GetMembersUseCase<T> req({required String id}) {
    _id = id;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T?) success, required Function error}) async {
    var response = await super.remote(Request(
        endpoint: "api/v1/leagues/members",
        params: HTTPRequesParams(query: _id),
        verb: HTTPVerb.get));
    if (response.isSuccessfully) {
      var list = response.data == null
          ? null
          : response.data
          .map<UserModel>((league) => UserModel.fromJson(league))
          .toList() as T;
      success.call(list);
    } else {
      error.call(ApiException(
          message: response.response?.status,
          isBusinessError: response.response?.code == 422));
    }
  }
}
