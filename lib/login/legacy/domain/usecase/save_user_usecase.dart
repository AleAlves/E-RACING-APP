import 'package:e_racing_app/core/data/store_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/login/legacy/domain/model/auth_model.dart';
import 'package:e_racing_app/login/legacy/domain/model/user_model.dart';

import '../../../../profile/domain/model/profile_model.dart';

class SaveUserUseCase<T> extends BaseUseCase<T> {
  late String _email;
  late String _password;

  SaveUserUseCase<T> params({required String email, required String password}) {
    _email = email;
    _password = password;
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T) success, required Function failure}) async {
    var response = await super.local(StoreRequest("user", Operation.save,
        data: UserModel(
            profile: ProfileModel(email: _email),
            auth: AuthModel(password: _password))));
    if (response.isSuccessfully) {
      success.call(UserModel.fromJson(response.data ?? {}) as T);
    } else {
      failure.call(ApiException(message: "error trying to retrive local data"));
    }
  }
}
