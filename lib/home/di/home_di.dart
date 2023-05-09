import 'package:e_racing_app/home/presentation/home_screen.dart';
import 'package:e_racing_app/home/presentation/home_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/model/media_model.dart';
import '../../league/list/data/league_model.dart';
import '../../push/domain/get_notifications_count_usecase.dart';
import '../../shared/media/get_media.usecase.dart';
import '../domain/get_user_league_use_case.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => HomeViewModel()),
        Bind.factory((i) => GetUserLeagueUseCase<List<LeagueModel>>()),
        Bind.factory((i) => GetNotificationsCountUseCase<String>()),
        Bind.factory((i) => GetMediaUseCase<MediaModel?>()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomeScreen()),
      ];
}
