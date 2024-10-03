import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/model/status_model.dart';
import '../data/league_members_model.dart';
import '../domain/get_members_usecase.dart';
import '../domain/remove_member_usecase.dart';
import '../presentation/league_member_screen.dart';
import '../presentation/league_member_view_model.dart';
import '../presentation/navigation/league_member_navigation.dart';

class LeagueMemberModule extends Module {
  final LeagueMemberNavigationSet flow;

  LeagueMemberModule({this.flow = LeagueMemberNavigationSet.main});

  @override
  void binds(i) {
    i.add<LeagueMemberViewModel>(LeagueMemberViewModel.new);
    i.add<RemoveMemberUseCase<StatusModel>>(RemoveMemberUseCase.new);
    i.add<GetMembersUseCase<List<LeagueMembersModel>>>(GetMembersUseCase.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const LeagueMemberScreen());
  }
}
