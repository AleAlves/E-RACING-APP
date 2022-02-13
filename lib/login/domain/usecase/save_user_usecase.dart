import 'package:e_racing_app/core/data/store_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/login/domain/model/auth_model.dart';
import 'package:e_racing_app/login/domain/model/profile_model.dart';
import 'package:e_racing_app/login/domain/model/user_model.dart';

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
      {required Function(T) success, required Function error}) async {
    var response = await super.local(StoreRequest("user", Operation.create,
        data: UserModel(
            profile: ProfileModel(email: _email),
            auth: AuthModel(password: _password))));
    if (response.isSuccessfully) {
      success.call(UserModel.fromJson(response.data ?? {}) as T);
    } else {
      error.call(ApiException(
          message: "error trying to retrive local data",
          isBusinessError: false));
    }
  }
}
