import 'package:e_racing_app/login/legacy/domain/model/user_model.dart';
import 'package:e_racing_app/profile/presentation/profile_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/model/media_model.dart';
import '../../shared/media/get_media.usecase.dart';
import '../../shared/tag/get_tag_usecase.dart';
import '../domain/update_profile_usecase.dart';
import '../presentation/profile_screen.dart';

class ProfileModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => ProfileViewModel()),
        Bind.factory((i) => GetTagUseCase()),
        Bind.factory((i) => GetMediaUseCase<MediaModel?>()),
        Bind.factory((i) => UpdateProfileUseCase<UserModel>()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const ProfileScreen()),
      ];
}
