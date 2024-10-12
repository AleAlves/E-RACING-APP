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
  void binds(i) {
    i.add<LeagueListViewModel>(LeagueListViewModel.new);
    i.add<GetTagUseCase<dynamic>>(GetTagUseCase<dynamic>.new);
    i.add<FetchLeagueUseCase<List<LeagueModel>>>(FetchLeagueUseCase<List<LeagueModel>>.new);
    i.add<SearchLeagueUseCase<List<LeagueModel>>>(SearchLeagueUseCase<List<LeagueModel>>.new);
    i.add<GetOwnedLeagueUseCase<List<LeagueModel>>>(GetOwnedLeagueUseCase<List<LeagueModel>>.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => LeagueListScreen(router: router));
  }
}
