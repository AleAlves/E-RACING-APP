import 'package:flutter_modular/flutter_modular.dart';

import '../../legacy/data/model/login_response.dart';
import '../../legacy/domain/model/public_key_model.dart';
import '../../legacy/domain/model/user_model.dart';
import '../../legacy/domain/usecase/get_public_key_usecase.dart';
import '../../legacy/domain/usecase/get_user_usecase.dart';
import '../../legacy/domain/usecase/save_user_usecase.dart';
import '../domain/sign_in_usecase.dart';
import '../presentation/login_sign_in_screen.dart';
import '../presentation/login_sign_in_view_model.dart';
import '../presentation/navigation/login_sign_in_navigation.dart';

class LoginSignInModule extends Module {
  final LoginSignInNavigationSet flow;

  LoginSignInModule({this.flow = LoginSignInNavigationSet.home});

  @override
  void binds(i) {
    i.add<LoginSignInViewModel>(LoginSignInViewModel.new);
    i.add<GetPublicKeyUseCase<PublicKeyModel>>(GetPublicKeyUseCase<PublicKeyModel>.new);
    i.add<SignInUseCase<LoginResponse>>(SignInUseCase<LoginResponse>.new);
    i.add<GetUserUseCase<UserModel?>>(GetUserUseCase<UserModel?>.new);
    i.add<SaveUserUseCase<dynamic>>(SaveUserUseCase<dynamic>.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const LoginSignInScreen());
  }
}
