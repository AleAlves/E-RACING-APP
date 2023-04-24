import 'package:flutter_modular/flutter_modular.dart';

import '../../../tag/get_tag_usecase.dart';
import '../../home/domain/model/league_model.dart';
import '../domain/fetch_league_usecase.dart';
import '../presentation/league_list_screen.dart';
import '../presentation/league_list_view_model.dart';
import '../presentation/navigation/league_list_navigation.dart';

class LeagueListModule extends Module {
  final LeagueListNavigationSet flow;

  LeagueListModule({this.flow = LeagueListNavigationSet.main});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => LeagueListViewModel()),
        Bind.factory((i) => GetTagUseCase()),
        Bind.factory((i) => FetchLeagueUseCase<List<LeagueModel>>()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LeagueListScreen()),
      ];
}
