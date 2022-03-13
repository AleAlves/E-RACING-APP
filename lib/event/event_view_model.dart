import 'dart:convert';
import 'dart:io';

import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/race_model.dart';
import 'package:e_racing_app/core/model/shortcut_model.dart';
import 'package:e_racing_app/core/model/social_platform_model.dart';
import 'package:e_racing_app/core/model/status_model.dart';
import 'package:e_racing_app/core/model/tag_model.dart';
import 'package:e_racing_app/core/model/team_model.dart';
import 'package:e_racing_app/core/service/api_exception.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/data/event_home_model.dart';
import 'package:e_racing_app/event/domain/fetch_events_use_case.dart';
import 'package:e_racing_app/event/presentation/ui/model/championship_races_model.dart';
import 'package:e_racing_app/login/domain/model/user_model.dart';
import 'package:e_racing_app/media/get_media.usecase.dart';
import 'package:e_racing_app/social/get_social_media_usecase.dart';
import 'package:e_racing_app/tag/get_tag_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'data/event_standings_model.dart';
import 'data/race_standings_model.dart';
import 'domain/create_event_usecase.dart';
import 'domain/create_team_usecase.dart';
import 'domain/delete_team_usecase.dart';
import 'domain/finish_event_usecase.dart';
import 'domain/get_event_standing_usecase.dart';
import 'domain/get_race_standing_usecase.dart';
import 'domain/join_team_usecase.dart';
import 'domain/leave_team_usecase.dart';
import 'domain/remove_subcription_usecase.dart';
import 'domain/start_event_usecase.dart';
import 'domain/subscribe_event_usecase.dart';
import 'domain/get_event_usecase.dart';
import 'domain/toogle_members_only_usecase.dart';
import 'domain/toogle_subscriptions_usecase.dart';
import 'domain/unsubscribe_event_usecase.dart';
import 'domain/update_event_usecase.dart';
import 'presentation/ui/event_flow.dart';

part 'event_view_model.g.dart';

class EventViewModel = _EventViewModel with _$EventViewModel;

abstract class _EventViewModel with Store {
  _EventViewModel();

  @observable
  EventModel? event;

  @observable
  EventStandingsModel? standings;

  @observable
  MediaModel? media;

  @observable
  RaceModel? race;

  @observable
  StatusModel? status;

  @observable
  EventFlows flow = EventFlows.list;

  @observable
  ViewState state = ViewState.ready;

  @observable
  ObservableList<EventModel?>? events = ObservableList();

  @observable
  ObservableList<ShortcutModel>? menus = ObservableList();

  @observable
  ObservableList<TagModel?>? tags = ObservableList();

  @observable
  ObservableList<UserModel?>? users = ObservableList();

  @observable
  ObservableList<SocialPlatformModel?>? socialMedias = ObservableList();

  @observable
  ObservableList<RaceStandingsModel?>? raceStandings = ObservableList();

  @observable
  EventModel? creatingEvent;

  List<RaceModel>? creatingRaces;
  List<MediaModel>? creatingMedias;
  File? bannerFile;
  List<ChampionshipRacesModel>? racesModel;

  final _getMediaUseCase = Modular.get<GetMediaUseCase<MediaModel>>();
  final _getTagUseCase = Modular.get<GetTagUseCase>();
  final _getSocialMediaUseCase = Modular.get<GetSocialMediaUseCase>();
  final _fetchEventHomeUseCase =
      Modular.get<FetchEventsUseCase<List<EventModel>>>();
  final _createEventUseCase = Modular.get<CreateEventUseCase<StatusModel>>();
  final _updateEventUseCase = Modular.get<UpdateEventUseCase<StatusModel>>();
  final _doSubscribeEventUseCase =
      Modular.get<SubscribeEventUseCase<StatusModel>>();
  final _unsubscribeEventUseCase =
      Modular.get<UnsubscribeEventUseCase<StatusModel>>();
  final _removeSubscriptiontUseCase =
      Modular.get<RemoveSubscriptionUseCase<StatusModel>>();
  final _createTeamEventUseCase = Modular.get<CreateTeamUseCase<StatusModel>>();
  final _leaveTeamUseCase = Modular.get<LeaveTeamUseCase<StatusModel>>();
  final _joinTeamUseCase = Modular.get<JoinTeamUseCase<StatusModel>>();
  final _deleteTeamUseCase = Modular.get<DeleteTeamUseCase<StatusModel>>();
  final _startEventUseCase = Modular.get<StartEventUseCase<StatusModel>>();
  final _getRaceStandingdUseCase =
      Modular.get<GetRaceStandingsUseCase<List<RaceStandingsModel>>>();
  final _finishEventUseCase = Modular.get<FinishEventUseCase<StatusModel>>();
  final _toogleSubscriptionsUseCase =
      Modular.get<ToogleSubscriptionsUseCase<StatusModel>>();
  final _toogleMembersOnlyUseCase =
      Modular.get<ToogleMembersOnlyUseCase<StatusModel>>();
  final _getEventUseCase = Modular.get<GetEventUseCase<EventHomeModel>>();
  final _getEventStandingsUseCase =
      Modular.get<GetEventStandingUseCase<EventStandingsModel>>();

  @action
  init() async {
    state = ViewState.ready;
  }

  void fetchEvents() async {
    state = ViewState.loading;
    _fetchEventHomeUseCase.invoke(
        success: (data) {
          events = ObservableList.of(data);
          state = ViewState.ready;
        },
        error: onError);
  }

  void getEvent() async {
    state = ViewState.loading;
    media = null;
    _getEventUseCase.params(id: Session.instance.getEventId() ?? '').invoke(
        success: (data) {
          event = data?.event;
          users = ObservableList.of(data?.users ?? []);
          if (data?.event.type == EventType.race) {
            setFlow(EventFlows.detailRace);
          } else {
            getMedia(data?.event.id ?? '');
          }
          getStandings();
          state = ViewState.ready;
        },
        error: onError);
  }

  void getStandings() async {
    _getEventStandingsUseCase.build(id: event?.id ?? '').invoke(
        success: (data) {
          standings = data;
        },
        error: onError);
  }

  void toogleSubscriptions() {
    state = ViewState.loading;
    _toogleSubscriptionsUseCase.build(eventId: event?.id ?? '').invoke(
        success: (data) {
          status = data;
          setFlow(EventFlows.status);
        },
        error: onError);
  }

  void toogleMembersOnly() {
    state = ViewState.loading;
    _toogleMembersOnlyUseCase.build(eventId: event?.id ?? '').invoke(
        success: (data) {
          status = data;
          setFlow(EventFlows.status);
        },
        error: onError);
  }

  void getMedia(String id) async {
    await _getMediaUseCase.params(id: id).invoke(
        success: (data) {
          media = data;
        },
        error: onError);
  }

  void fetchTags() async {
    state = ViewState.loading;
    await _getTagUseCase.invoke(
        success: (data) {
          tags = ObservableList.of(data);
          state = ViewState.ready;
        },
        error: onError);
  }

  void fetchSocialMedias() async {
    state = ViewState.loading;
    await _getSocialMediaUseCase.invoke(
        success: (data) {
          socialMedias = ObservableList.of(data);
          state = ViewState.ready;
        },
        error: onError);
  }

  void deeplink({String? deepLink, EventFlows? flow}) {
    if (deepLink != null) {
      Modular.to.pushNamed(deepLink);
    } else if (flow != null) {
      setFlow(flow);
    }
  }

  void create(EventModel event) async {
    state = ViewState.loading;
    await _createEventUseCase.build(event: event).invoke(
        success: (data) {
          status = data;
          setFlow(EventFlows.status);
        },
        error: onError);
  }

  void subscribe(String? classId) async {
    state = ViewState.loading;
    await _doSubscribeEventUseCase
        .build(classId: classId, eventId: event?.id)
        .invoke(
            success: (data) {
              status = data;
              setFlow(EventFlows.status);
            },
            error: onError);
  }

  void unsubscribe(String? classId) async {
    state = ViewState.loading;
    await _unsubscribeEventUseCase
        .build(classId: classId, eventId: event?.id)
        .invoke(
            success: (data) {
              status = data;
              setFlow(EventFlows.status);
            },
            error: onError);
  }

  void createChampionshipEventStep(
      EventModel event, MediaModel media, File banner) {
    bannerFile = banner;
    creatingEvent = event;
    creatingMedias?.add(media);
    setFlow(EventFlows.createRaces);
  }

  void updateChampionshipRaces(List<ChampionshipRacesModel> races) async {
    racesModel = races;
  }

  void createChampionshipRacesStep(
      List<ChampionshipRacesModel> racesModel) async {
    List<RaceModel> races = [];
    for (var element in racesModel) {
      var poster;
      try {
        List<int> posterBytes =
            element.posterFile?.readAsBytesSync() as List<int>;
        poster = base64Encode(posterBytes);
      } catch (e) {}
      races.add(RaceModel(
          poster: poster,
          sessions: element.sessions,
          broadcasting: element.hasBroadcasting,
          date: element.eventDate?.toIso8601String(),
          title: element.titleController?.text));
    }
    var banner;
    try {
      List<int> bannerBytes = bannerFile?.readAsBytesSync() ?? [];
      banner = base64Encode(bannerBytes);
    } catch (e) {}

    var media = MediaModel(banner);

    var event = EventModel(
        races: races,
        title: creatingEvent?.title,
        rules: creatingEvent?.rules,
        scoring: creatingEvent?.scoring,
        classes: creatingEvent?.classes,
        settings: creatingEvent?.settings,
        membersOnly: creatingEvent?.membersOnly,
        teamsEnabled: creatingEvent?.teamsEnabled);

    await _createEventUseCase
        .build(
            event: event,
            media: media,
            leagueId: Session.instance.getLeagueId())
        .invoke(
            success: (data) {
              status = data;
              setFlow(EventFlows.status);
            },
            error: onError);
  }

  Future<void> updateEvent(EventModel? event, MediaModel? media) async {
    state = ViewState.loading;
    await _updateEventUseCase.build(event: event, media: media).invoke(
        success: (data) {
          status = data;
          setFlow(EventFlows.status);
        },
        error: onError);
  }

  void createTeam(String name, List<String?> ids) async {
    state = ViewState.loading;
    var team = TeamModel(name: name, crew: ids);
    await _createTeamEventUseCase.build(id: event?.id, team: team).invoke(
        success: (data) {
          status = data;
          setFlow(EventFlows.status);
        },
        error: onError);
  }

  void joinTeam(String? id) async {
    state = ViewState.loading;
    await _joinTeamUseCase.build(teamId: id, eventId: event?.id).invoke(
        success: (data) {
          status = data;
          setFlow(EventFlows.status);
        },
        error: onError);
  }

  void leaveTeam(String? id) async {
    state = ViewState.loading;
    await _leaveTeamUseCase.build(teamId: id, eventId: event?.id).invoke(
        success: (data) {
          status = data;
          setFlow(EventFlows.status);
        },
        error: onError);
  }

  void deleteTeam(String? id) async {
    state = ViewState.loading;
    await _deleteTeamUseCase.build(teamId: id, eventId: event?.id).invoke(
        success: (data) {
          status = data;
          setFlow(EventFlows.status);
        },
        error: onError);
  }

  Future<void> startEvent() async {
    state = ViewState.loading;
    await _startEventUseCase.build(id: event?.id ?? '').invoke(
        success: (data) {
          status = data;
          setFlow(EventFlows.status);
        },
        error: onError);
  }

  Future<void> finishEvent() async {
    state = ViewState.loading;
    await _finishEventUseCase.build(id: event?.id ?? '').invoke(
        success: (data) {
          status = data;
          setFlow(EventFlows.status);
        },
        error: onError);
  }

  Future<void> getRaceStandings() async {
    await _getRaceStandingdUseCase.build(id: race?.id ?? '').invoke(
        success: (data) {
          raceStandings = ObservableList.of(data);
        },
        error: onError);
  }

  void toRaceDetail(String id) {
    race = event?.races?.firstWhere((element) => element?.id == id);
    setFlow(EventFlows.raceDetail);
  }

  void toRaceResults(String id) {
    race = event?.races?.firstWhere((element) => element?.id == id);
    setFlow(EventFlows.managementEditRaceResultsEdit);
  }

  Future<void> removeSubscription(String? classId, String userId) async {
    state = ViewState.loading;
    await _removeSubscriptiontUseCase
        .build(classId: classId, eventId: Session.instance.getEventId(), userId: userId)
        .invoke(
            success: (data) {
              status = data;
              setFlow(EventFlows.status);
            },
            error: onError);
  }

  void editRace() {
    setFlow(EventFlows.managementEditRace);
  }

  void updateRace(ChampionshipRacesModel? model) {
    event?.races?.forEach((race) {
      if (race?.id == model?.id) {
        race?.broadcastLink = model?.broadcastingLinkController?.text;
        race?.date = model?.eventDate?.toIso8601String();
        race?.broadcasting = model?.hasBroadcasting;
        race?.title = model?.titleController?.text;
        if (model?.posterFile != null) {
          try {
            List<int> posterBytes =
                model?.posterFile?.readAsBytesSync() as List<int>;
            race?.poster = base64Encode(posterBytes);
          } catch (e) {}
        } else {
          race?.poster = model?.poster;
        }
        race?.leagueId = event?.leagueId;
        race?.sessions = model?.sessions;
        race?.finished = false;
      }
    });
    updateEvent(event, media);
  }

  void onError(ApiException error) {
    status = StatusModel(
      message: error.message,
      action: "Ok",
      next: EventFlows.list,
      previous: flow,
    );
    if (error.isBusiness()) {
      state = ViewState.ready;
      flow = EventFlows.status;
    } else {
      state = ViewState.error;
    }
  }

  void setFlow(EventFlows flow) {
    this.flow = flow;
  }
}
