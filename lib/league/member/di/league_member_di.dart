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
  List<Bind> get binds => [
        Bind.factory((i) => LeagueMemberViewModel()),
        Bind.factory((i) => RemoveMemberUseCase<StatusModel>()),
        Bind.factory((i) => FetchMembersUseCase<List<LeagueMembersModel>>())
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LeagueMemberScreen()),
      ];
}
