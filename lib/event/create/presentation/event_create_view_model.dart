import 'package:e_racing_app/core/model/classes_model.dart';
import 'package:e_racing_app/core/model/race_model.dart';
import 'package:e_racing_app/core/model/settings_model.dart';
import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/model/event_model.dart';
import '../../../core/model/status_model.dart';
import '../../../core/model/tag_model.dart';
import '../../../core/ui/view_state.dart';
import '../../../tag/get_tag_usecase.dart';
import '../../domain/create_event_usecase.dart';
import '../../presentation/ui/model/championship_races_model.dart';
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

  @override
  @observable
  StatusModel? status;

  @observable
  String? name;

  @observable
  String? rules;

  @observable
  String? banner;

  @observable
  String? date;

  @observable
  bool? allowTeams = false;

  @observable
  bool? allowMembersOnly = false;

  @observable
  ObservableList<String?>? eventTags;

  @observable
  ObservableList<TagModel?>? tags = ObservableList();

  @observable
  ObservableList<SettingsModel?> eventSettings = ObservableList();

  @observable
  ObservableList<ClassesModel?> eventClasses = ObservableList();

  @observable
  ObservableList<int?> eventScore = ObservableList();

  @observable
  List<ChampionshipRacesModel?> racesModel = [];

  final _getTagUseCase = Modular.get<GetTagUseCase>();
  final _createEventUseCase = Modular.get<CreateEventUseCase<StatusModel>>();

  void setAgreement(bool termsAgreement) {
    onNavigate(EventCreateNavigator.name);
  }

  void setEventName(String name) {
    onNavigate(EventCreateNavigator.rules);
  }

  void setEventRules(String rules) {
    onNavigate(EventCreateNavigator.score);
  }

  void setEventTags(List<String?> tags) {
    eventTags?.addAll(tags);
    onNavigate(EventCreateNavigator.settings);
  }

  void setEventSettings(List<SettingsModel?> settingsModel) {
    eventSettings.clear();
    eventSettings.addAll(settingsModel);
    onNavigate(EventCreateNavigator.racesList);
  }

  void setEventClasses(List<ClassesModel?> classesModel) {
    eventClasses.clear();
    eventClasses.addAll(classesModel);
    onNavigate(EventCreateNavigator.tags);
  }

  void setEventScore(List<int?> scoreSchema) {
    eventScore.clear();
    eventScore.addAll(scoreSchema);
    onNavigate(EventCreateNavigator.banner);
  }

  void setToggleEventAllowTeamsOption(bool? allowTeams) {
    this.allowTeams = allowTeams;
  }

  void setToggleEventAllowMembersOnly(bool? allowMembersOnly) {
    this.allowMembersOnly = allowMembersOnly;
  }

  void addRace(ChampionshipRacesModel? model) {
    racesModel.add(model);
    onNavigate(EventCreateNavigator.racesList);
  }

  void removeRace(ChampionshipRacesModel? racesModel) {
    this.racesModel.remove(racesModel);
  }

  void createEvent() async {
    state = ViewState.loading;

    var races = racesModel.map((race) => RaceModel(
        date: race?.eventDate.toString(),
        title: race?.titleController?.text,
        broadcasting: race?.hasBroadcasting));

    var event = EventModel(
        races: races.toList(),
        tags: eventTags,
        settings: eventSettings,
        classes: eventClasses,
        teamsEnabled: allowTeams,
        membersOnly: allowMembersOnly,
        title: name,
        rules: rules,
        scoring: eventScore);

    await _createEventUseCase.build(event: event).invoke(
        success: (data) {
          status = data;
          state = ViewState.ready;
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
