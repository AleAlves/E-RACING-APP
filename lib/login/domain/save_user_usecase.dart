import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/store_request.dart';

import 'model/auth_model.dart';
import 'model/profile_model.dart';
import 'model/user_model.dart';

class SaveUserUseCase<T> extends BaseUseCase<T> {
  final String _email;
  final String _password;

  SaveUserUseCase(this._email, this._password);

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
      error.call();
    }
  }
}
