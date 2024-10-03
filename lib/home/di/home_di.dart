import 'package:e_racing_app/home/presentation/home_screen.dart';
import 'package:e_racing_app/home/presentation/home_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/model/media_model.dart';
import '../../league/core/league_model.dart';
import '../../push/domain/get_notifications_count_usecase.dart';
import '../../shared/media/get_media.usecase.dart';
import '../domain/get_user_league_use_case.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.add<HomeViewModel>(HomeViewModel.new);
    i.add<GetUserLeagueUseCase<List<LeagueModel>>>(GetUserLeagueUseCase.new);
    i.add<GetNotificationsCountUseCase<String>>(
        GetNotificationsCountUseCase.new);
    i.add<GetMediaUseCase<MediaModel?>>(GetMediaUseCase.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomeScreen());
  }
}
