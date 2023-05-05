import 'package:e_racing_app/league/trophies/domain/model/podium_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../domain/get_trophies_usecase.dart';
import '../presentation/league_trophies_screen.dart';
import '../presentation/league_trophies_view_model.dart';
import '../presentation/router/league_trophies_router.dart';

class LeagueTrophiesModule extends Module {
  final LeagueTrophiesRouter flow;

  LeagueTrophiesModule({this.flow = LeagueTrophiesRouter.main});

  @override
  List<Bind> get binds => [
        Bind.factory((i) => LeagueTrophiesViewModel()),
        Bind.factory((i) => GetTrophiesUseCase<List<PodiumModel>>()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LeagueTrophiesScreen()),
      ];
}
