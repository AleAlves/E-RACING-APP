import 'package:e_racing_app/league/list/presentation/router/league_list_router.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/tag/get_tag_usecase.dart';
import '../../core/league_model.dart';
import '../domain/fetch_league_usecase.dart';
import '../domain/get_owned_league_usecase.dart';
import '../domain/search_league_usecase.dart';
import '../presentation/league_list_screen.dart';
import '../presentation/league_list_view_model.dart';

class LeagueListModule extends Module {
  final LeagueListRouterSet router;

  LeagueListModule({this.router = LeagueListRouterSet.main});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => LeagueListViewModel()),
        Bind.factory((i) => GetTagUseCase()),
        Bind.factory((i) => FetchLeagueUseCase<List<LeagueModel>>()),
        Bind.factory((i) => SearchLeagueUseCase<List<LeagueModel>>()),
        Bind.factory((i) => GetOwnedLeagueUseCase<List<LeagueModel>>()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => LeagueListScreen(router: router)),
      ];
}
