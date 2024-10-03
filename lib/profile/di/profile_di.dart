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
  void binds(i) {
    i.add<ProfileViewModel>(ProfileViewModel.new);
    i.add<GetTagUseCase>(GetTagUseCase.new);
    i.add<GetMediaUseCase<MediaModel?>>(GetMediaUseCase.new);
    i.add<UpdateProfileUseCase<UserModel>>(UpdateProfileUseCase.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const ProfileScreen());
  }
}
