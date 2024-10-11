import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/league/create/domain/create_league_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/social/get_social_media_usecase.dart';
import '../../../shared/tag/get_tag_usecase.dart';
import '../presentation/league_create_screen.dart';
import '../presentation/league_create_view_model.dart';
import '../presentation/navigation/league_create_flow.dart';

class LeagueCreateModule extends Module {
  final LeagueCreateNavigator flow;

  LeagueCreateModule({this.flow = LeagueCreateNavigator.terms});

  @override
  void binds(i) {
    i.add<LeagueCreateViewModel>(LeagueCreateViewModel.new);
    i.add<CreateLeagueUseCase<StatusModel>>(CreateLeagueUseCase<StatusModel>.new);
    i.add<GetTagUseCase<dynamic>>(GetTagUseCase<dynamic>.new);
    i.add<GetSocialMediaUseCase<dynamic>>(GetSocialMediaUseCase<dynamic>.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => LeagueCreateScreen(flow));
  }
}
