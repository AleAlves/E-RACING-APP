import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/event/detail/presentation/router/event_detail_router.dart';
import 'package:e_racing_app/event/event_router.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/domain/share_model.dart';
import '../../../core/model/event_model.dart';
import '../../../core/model/media_model.dart';
import '../../../core/model/race_model.dart';
import '../../../core/model/status_model.dart';
import '../../../core/model/team_model.dart';
import '../../../core/tools/session.dart';
import '../../../core/ui/view_state.dart';
import '../../../login/legacy/domain/model/user_model.dart';
import '../../../shared/media/get_media.usecase.dart';
import '../../core/data/event_home_model.dart';
import '../../core/data/event_standings_model.dart';
import '../../core/data/event_teams_standings_model.dart';
import '../../core/data/race_standings_model.dart';
import '../domain/create_team_usecase.dart';
import '../domain/delete_team_usecase.dart';
import '../domain/get_event_usecase.dart';
import '../domain/get_standing_usecase.dart';
import '../domain/join_team_usecase.dart';
import '../domain/leave_team_usecase.dart';
import '../domain/race_standing_usecase.dart';
import '../domain/subscribe_event_usecase.dart';
import '../domain/teams_standing_usecase.dart';
import '../domain/unsubscribe_event_usecase.dart';

part 'event_detail_view_model.g.dart';

class EventDetailViewModel = _EventDetailViewModel with _$EventDetailViewModel;

abstract class _EventDetailViewModel extends BaseViewModel<EventDetailRouter>
    with Store {
  _EventDetailViewModel();

  @override
  @observable
  EventDetailRouter? flow = EventDetailRouter.main;

  @override
  @observable
  ViewState state = ViewState.loading;

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
  EventTeamsStandingsModel? teamsStandings;

  @observable
  ObservableList<EventModel?>? events = ObservableList();

  @observable
  ObservableList<UserModel?>? users = ObservableList();

  final _createTeamUC = Modular.get<CreateTeamUseCase<StatusModel>>();
  final _leaveTeamUseCase = Modular.get<LeaveTeamUseCase<StatusModel>>();
  final _joinTeamUseCase = Modular.get<JoinTeamUseCase<StatusModel>>();
  final _deleteTeamUseCase = Modular.get<DeleteTeamUseCase<StatusModel>>();
  final _getEventUseCase = Modular.get<GetEventUseCase<EventHomeModel>>();
  final _standingsUC = Modular.get<GetStandingUseCase<EventStandingsModel>>();
  final _doSubscribeUC = Modular.get<SubscribeEventUseCase<StatusModel>>();
  final _unsubscribeUC = Modular.get<UnsubscribeEventUseCase<StatusModel>>();
  final _getMediaUC = Modular.get<GetMediaUseCase<MediaModel>>();
  final _teamStandingsUC =
      Modular.get<TeamsStandingUseCase<EventTeamsStandingsModel>>();
  final _raceStandingsUC =
      Modular.get<RaceStandingsUseCase<RaceStandingsModel>>();

  getEvent() async {
    state = ViewState.loading;
    media = null;
    _getEventUseCase
        .params(eventId: Session.instance.getEventId() ?? '')
        .invoke(
            success: (data) {
              event = data?.event;
              share = ShareModel(
                  route: EventRouter.detail,
                  leagueId: event?.leagueId,
                  eventId: event?.id,
                  name: event?.title,
                  message: "Check out this racing event");
              users = ObservableList.of(data?.users ?? []);
              getMedia(data?.event.id ?? '');
              _getStandings();
              state = ViewState.ready;
            },
            error: onError);
  }

  Future<void> getRaceStandings() async {
    raceStandings = null;
    await _raceStandingsUC.build(id: race?.id ?? '').invoke(
        success: (data) {
          raceStandings = data;
        },
        error: onError);
  }

  Future<void> getTeamsStandings() async {
    teamsStandings = null;
    await _teamStandingsUC.build(id: event?.id ?? '').invoke(
        success: (data) {
          teamsStandings = data;
        },
        error: onError);
  }

  void getMedia(String id) async {
    await _getMediaUC.params(id: id).invoke(
        success: (data) {
          media = data;
        },
        error: onError);
  }

  _getStandings() async {
    _standingsUC.build(id: event?.id ?? '').invoke(
        success: (data) {
          standings = data;
        },
        error: onError);
  }

  void subscribe(String? classId) async {
    state = ViewState.loading;
    await _doSubscribeUC.build(classId: classId, eventId: event?.id).invoke(
        success: (data) {
          status = data;
          state = ViewState.ready;
          onRoute(EventDetailRouter.status);
          getEvent();
        },
        error: onError);
  }

  void unsubscribe(String? classId) async {
    state = ViewState.loading;
    await _unsubscribeUC.build(classId: classId, eventId: event?.id).invoke(
        success: (data) {
          getEvent();
          status = data;
          state = ViewState.ready;
          onRoute(EventDetailRouter.status);
        },
        error: onError);
  }

  void createTeam(String name, List<String?> ids) async {
    state = ViewState.loading;
    var team = TeamModel(name: name, crew: ids);
    await _createTeamUC.build(id: event?.id, team: team).invoke(
        success: (data) {
          getEvent();
          status = data;
          state = ViewState.ready;
          onRoute(EventDetailRouter.status);
        },
        error: onError);
  }

  void joinTeam(String? id) async {
    state = ViewState.loading;
    await _joinTeamUseCase.build(teamId: id, eventId: event?.id).invoke(
        success: (data) {
          getEvent();
          status = data;
          state = ViewState.ready;
          onRoute(EventDetailRouter.status);
        },
        error: onError);
  }

  void leaveTeam(String? id) async {
    state = ViewState.loading;
    await _leaveTeamUseCase.build(teamId: id, eventId: event?.id).invoke(
        success: (data) {
          getEvent();
          status = data;
          state = ViewState.ready;
          onRoute(EventDetailRouter.status);
        },
        error: onError);
  }

  void deleteTeam(String? id) async {
    state = ViewState.loading;
    await _deleteTeamUseCase.build(teamId: id, eventId: event?.id).invoke(
        success: (data) {
          getEvent();
          status = data;
          state = ViewState.ready;
          onRoute(EventDetailRouter.status);
        },
        error: onError);
  }

  goToRace(String id) {
    race = event?.races?.firstWhere((element) => element?.id == id);
    onRoute(EventDetailRouter.race);
  }
}
