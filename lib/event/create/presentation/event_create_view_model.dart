import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/event/core/data/event_create_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/model/status_model.dart';
import '../../../core/model/tag_model.dart';
import '../../../core/tools/session.dart';
import '../../../core/ui/view_state.dart';
import '../../../shared/tag/get_tag_usecase.dart';
import '../../core/data/session_race_model.dart';
import '../domain/create_event_usecase.dart';
import '../domain/model/race_create_model.dart';
import 'navigation/event_create_flow.dart';

part 'event_create_view_model.g.dart';

class EventCreateViewModel = _EventCreateViewModel with _$EventCreateViewModel;

abstract class _EventCreateViewModel extends BaseViewModel<EventCreateNavigator>
    with Store {
  _EventCreateViewModel();

  @override
  @observable
  EventCreateNavigator? flow;

  @override
  @observable
  ViewState state = ViewState.ready;

  @observable
  int maxSteps = 10;

  @observable
  int currentStep = 1;

  @override
  @observable
  String? title = "";

  @override
  @observable
  StatusModel? status;

  @observable
  int editingRaceIndex = 0;

  @observable
  String? eventName = "";

  @observable
  String? eventRules = "";

  @observable
  String? eventBanner;

  @observable
  bool? eventAllowTeams = false;

  @observable
  bool? eventAllowMembersOnly = false;

  @observable
  ObservableList<String?> eventTags = ObservableList();

  @observable
  ObservableList<TagModel?>? tags = ObservableList();

  @observable
  ObservableList<SettingsModel?> eventSettings = ObservableList();

  @observable
  ObservableList<ClassesModel?> eventClasses = ObservableList();

  @observable
  ObservableList<int?> eventScore = ObservableList();

  @observable
  List<EventRaceModel?> racesModel = ObservableList();

  @observable
  EventRaceModel? editingRaceModel;

  final _getTagUseCase = Modular.get<GetTagUseCase>();
  final _createEventUseCase = Modular.get<CreateEventUseCase<StatusModel>>();

  increaseStep() {
    currentStep++;
  }

  decreaseStep() {
    currentStep--;
  }

  void setAgreement(bool termsAgreement) {
    onRoute(EventCreateNavigator.eventName);
  }

  void setEventName(String name) {
    eventName = name;
    onRoute(EventCreateNavigator.eventRules);
  }

  void setEventRules(String rules) {
    eventRules = rules;
    onRoute(EventCreateNavigator.eventScore);
  }

  void setEventBanner(String base64encodedBanner) {
    eventBanner = base64encodedBanner;
  }

  void onFinishEventBanner() {
    onRoute(EventCreateNavigator.eventClasses);
  }

  void onFinishEventTags() {
    onRoute(EventCreateNavigator.eventSettings);
  }

  void onFinishEventSettings() {
    onRoute(EventCreateNavigator.eventRaceList);
  }

  void addEventClasses(ClassesModel classesModel) {
    eventClasses.add(classesModel);
  }

  void removeClasses(int index) {
    eventClasses.removeAt(index);
  }

  void onFinishClasses() {
    onRoute(EventCreateNavigator.eventTags);
  }

  void onFinishScore() {
    onRoute(EventCreateNavigator.eventBanner);
  }

  void setToggleEventAllowTeamsOption(bool? allowTeams) {
    eventAllowTeams = allowTeams;
  }

  void setToggleEventAllowMembersOnly(bool? allowMembersOnly) {
    eventAllowMembersOnly = allowMembersOnly;
  }

  void onCreateNewRace() {
    editingRaceModel = null;
    onRoute(EventCreateNavigator.eventRaceCreation);
  }

  void onRaceEditing(EventRaceModel? race) {
    editingRaceModel = race;
    editingRaceIndex = racesModel.indexOf(race);
    onRoute(EventCreateNavigator.eventRaceEditing);
  }

  void addRace(EventRaceModel? model) {
    racesModel.add(model);
    onRoute(EventCreateNavigator.eventRaceList);
  }

  void updateRace(EventRaceModel? model) {
    racesModel.removeAt(editingRaceIndex);
    racesModel.insert(editingRaceIndex, model);
    onRoute(EventCreateNavigator.eventRaceList);
  }

  void removeRace(EventRaceModel? racesModel) {
    this.racesModel.remove(racesModel);
  }

  void createEvent() async {
    state = ViewState.loading;

    var races = racesModel.map((race) => RaceCreateModel(
        date: race?.eventDate,
        title: race?.title,
        poster: race?.poster,
        sessions: race?.sessions,
        broadcasting: race?.hasBroadcasting,
        broadcastLink: race?.broadcastLink));

    var event = EventCreateModel(
        races: races.toList(),
        tags: eventTags,
        settings: eventSettings,
        classes: eventClasses,
        teamsEnabled: eventAllowTeams,
        membersOnly: eventAllowMembersOnly,
        title: eventName,
        rules: eventRules,
        scoring: eventScore,
        leagueId: Session.instance.getLeagueId());

    var media = MediaModel(eventBanner.toString());

    await _createEventUseCase
        .build(
            event: event,
            leagueId: Session.instance.getLeagueId(),
            media: media)
        .invoke(
            success: (data) {
              status = data;
              state = ViewState.ready;
              onRoute(EventCreateNavigator.eventStatus);
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
}
