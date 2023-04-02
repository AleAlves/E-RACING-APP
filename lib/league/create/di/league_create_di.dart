import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/league/domain/create_league_usecase.dart';
import 'package:e_racing_app/social/get_social_media_usecase.dart';
import 'package:e_racing_app/tag/get_tag_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../presentation/league_create_view_model.dart';
import '../presentation/navigation/league_create_flow.dart';
import '../presentation/ui/league_create_screen.dart';

class LeagueCreateModule extends Module {
  final LeagueCreateNavigator flow;

  LeagueCreateModule({this.flow = LeagueCreateNavigator.terms});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => LeagueCreateViewModel()),
        Bind.factory((i) => CreateLeagueUseCase<StatusModel>()),
        Bind.factory((i) => GetTagUseCase()),
        Bind.factory((i) => GetSocialMediaUseCase()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => LeagueCreateScreen(flow)),
      ];
}