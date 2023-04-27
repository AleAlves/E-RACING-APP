import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/event/manage/presentation/router/event_manage_router.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/domain/share_model.dart';
import '../../../core/model/event_model.dart';
import '../../../core/model/media_model.dart';
import '../../../core/model/race_model.dart';
import '../../../core/model/status_model.dart';
import '../../../core/model/team_model.dart';
import '../../../core/ui/view_state.dart';
import '../../../login/legacy/domain/model/user_model.dart';
import '../../core/data/event_standings_model.dart';
import '../../core/data/race_standings_model.dart';
import '../../core/domain/leave_team_usecase.dart';
import '../../detail/domain/create_team_usecase.dart';
import '../../detail/domain/delete_team_usecase.dart';
import '../../detail/domain/join_team_usecase.dart';

part 'event_manage_view_model.g.dart';

class EventManageViewModel = _EventManageViewModel with _$EventManageViewModel;

abstract class _EventManageViewModel extends BaseViewModel<EventManageRouter>
    with Store {
  _EventManageViewModel();

  @override
  @observable
  EventManageRouter? flow = EventManageRouter.main;

  @override
  @observable
  ViewState state = ViewState.ready;

  @override
  @observable
  String? title = "";

  @override
  @observable
  StatusModel? status;

  @observable
  MediaModel? media;

  @observable
  ShareModel? share;

  @observable
  EventModel? event;

  @observable
  RaceModel? race;

  @observable
  EventStandingsModel? standings;

  @observable
  RaceStandingsModel? raceStandings;

  @observable
  ObservableList<EventModel?>? events = ObservableList();

  @observable
  ObservableList<UserModel?>? users = ObservableList();

  final _createTeamEventUseCase = Modular.get<CreateTeamUseCase<StatusModel>>();
  final _leaveTeamUseCase = Modular.get<LeaveTeamUseCase<StatusModel>>();
  final _joinTeamUseCase = Modular.get<JoinTeamUseCase<StatusModel>>();
  final _deleteTeamUseCase = Modular.get<DeleteTeamUseCase<StatusModel>>();

  void createTeam(String name, List<String?> ids) async {
    state = ViewState.loading;
    var team = TeamModel(name: name, crew: ids);
    await _createTeamEventUseCase.build(id: event?.id, team: team).invoke(
        success: (data) {
          status = data;
          // setFlow(EventFlow.status);
        },
        error: onError);
  }

  void joinTeam(String? id) async {
    state = ViewState.loading;
    await _joinTeamUseCase.build(teamId: id, eventId: event?.id).invoke(
        success: (data) {
          status = data;
          // setFlow(EventFlow.status);
        },
        error: onError);
  }

  void leaveTeam(String? id) async {
    state = ViewState.loading;
    await _leaveTeamUseCase.build(teamId: id, eventId: event?.id).invoke(
        success: (data) {
          status = data;
          // setFlow(EventFlow.status);
        },
        error: onError);
  }

  void deleteTeam(String? id) async {
    state = ViewState.loading;
    await _deleteTeamUseCase.build(teamId: id, eventId: event?.id).invoke(
        success: (data) {
          status = data;
          // setFlow(EventFlow.status);
        },
        error: onError);
  }
}
