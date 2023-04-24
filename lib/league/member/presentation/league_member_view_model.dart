import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../home/data/league_members_model.dart';
import '../../home/domain/get_members_usecase.dart';
import '../../home/domain/remove_member_usecase.dart';
import 'navigation/league_member_navigation.dart';

part 'league_member_view_model.g.dart';

class LeagueMemberViewModel = _LeagueMemberViewModel
    with _$LeagueMemberViewModel;

abstract class _LeagueMemberViewModel
    extends BaseViewModel<LeagueMemberNavigationSet> with Store {
  _LeagueMemberViewModel();

  @observable
  MediaModel? media;

  @override
  @observable
  StatusModel? status;

  @override
  @observable
  String? title;

  @override
  @observable
  LeagueMemberNavigationSet? flow = LeagueMemberNavigationSet.main;

  @override
  @observable
  ViewState state = ViewState.ready;

  @observable
  ObservableList<LeagueMembersModel?>? members = ObservableList();

  final _removeMemberUC = Modular.get<RemoveMemberUseCase<StatusModel>>();
  final _fetchMembersUC =
      Modular.get<FetchMembersUseCase<List<LeagueMembersModel?>>>();

  void fetchMembers() {
    var leagueId = Session.instance.getLeagueId();
    state = ViewState.loading;
    _fetchMembersUC.req(id: leagueId ?? '').invoke(
        success: (data) {
          members = ObservableList.of(data!);
          state = ViewState.ready;
        },
        error: onError);
  }

  void removeMember(String id) {
    var leagueId = Session.instance.getLeagueId();
    state = ViewState.loading;
    _removeMemberUC.req(memberId: id, leagueId: leagueId ?? '').invoke(
        success: (data) {
          status = data;
          onNavigate(LeagueMemberNavigationSet.status);
        },
        error: onError);
  }
}
