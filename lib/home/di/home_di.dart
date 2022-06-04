

import 'package:e_racing_app/home/presentation/home_view_model.dart';
import 'package:e_racing_app/home/presentation/ui/home_screen.dart';
import 'package:e_racing_app/league/domain/fetch_league_usecase.dart';
import 'package:e_racing_app/league/domain/model/league_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../notification/domain/get_notifications_count_usecase.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.factory((i) => HomeViewModel()),
    Bind.factory((i) => FetchLeagueUseCase<List<LeagueModel>>()),
    Bind.factory((i) => GetNotificationsCountUseCase<String>()),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const HomeScreen()),
  ];
}
