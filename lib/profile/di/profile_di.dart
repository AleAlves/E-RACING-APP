import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/login/domain/usecase/sign_in_usecase.dart';
import 'package:e_racing_app/profile/presentation/ui/profile_screen.dart';
import 'package:e_racing_app/profile/presentation/profile_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.factory((i) => ProfileViewModel()),
    Bind.factory((i) => SignInUseCase<StatusModel>()),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const ProfileScreen()),
  ];
}
