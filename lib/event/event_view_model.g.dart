// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EventViewModel on _EventViewModel, Store {
  late final _$eventAtom =
      Atom(name: '_EventViewModel.event', context: context);

  @override
  EventModel? get event {
    _$eventAtom.reportRead();
    return super.event;
  }

  @override
  set event(EventModel? value) {
    _$eventAtom.reportWrite(value, super.event, () {
      super.event = value;
    });
  }

  late final _$standingsAtom =
      Atom(name: '_EventViewModel.standings', context: context);

  @override
  EventStandingsModel? get standings {
    _$standingsAtom.reportRead();
    return super.standings;
  }

  @override
  set standings(EventStandingsModel? value) {
    _$standingsAtom.reportWrite(value, super.standings, () {
      super.standings = value;
    });
  }

  late final _$mediaAtom =
      Atom(name: '_EventViewModel.media', context: context);

  @override
  MediaModel? get media {
    _$mediaAtom.reportRead();
    return super.media;
  }

  @override
  set media(MediaModel? value) {
    _$mediaAtom.reportWrite(value, super.media, () {
      super.media = value;
    });
  }

  late final _$raceAtom = Atom(name: '_EventViewModel.race', context: context);

  @override
  RaceModel? get race {
    _$raceAtom.reportRead();
    return super.race;
  }

  @override
  set race(RaceModel? value) {
    _$raceAtom.reportWrite(value, super.race, () {
      super.race = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_EventViewModel.status', context: context);

  @override
  StatusModel? get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(StatusModel? value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$raceStandingsAtom =
      Atom(name: '_EventViewModel.raceStandings', context: context);

  @override
  RaceStandingsModel? get raceStandings {
    _$raceStandingsAtom.reportRead();
    return super.raceStandings;
  }

  @override
  set raceStandings(RaceStandingsModel? value) {
    _$raceStandingsAtom.reportWrite(value, super.raceStandings, () {
      super.raceStandings = value;
    });
  }

  late final _$raceTeamsStandingsAtom =
      Atom(name: '_EventViewModel.raceTeamsStandings', context: context);

  @override
  EventTeamsStandingsModel? get raceTeamsStandings {
    _$raceTeamsStandingsAtom.reportRead();
    return super.raceTeamsStandings;
  }

  @override
  set raceTeamsStandings(EventTeamsStandingsModel? value) {
    _$raceTeamsStandingsAtom.reportWrite(value, super.raceTeamsStandings, () {
      super.raceTeamsStandings = value;
    });
  }

  late final _$flowAtom = Atom(name: '_EventViewModel.flow', context: context);

  @override
  EventFlows get flow {
    _$flowAtom.reportRead();
    return super.flow;
  }

  @override
  set flow(EventFlows value) {
    _$flowAtom.reportWrite(value, super.flow, () {
      super.flow = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_EventViewModel.state', context: context);

  @override
  ViewState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ViewState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$eventsAtom =
      Atom(name: '_EventViewModel.events', context: context);

  @override
  ObservableList<EventModel?>? get events {
    _$eventsAtom.reportRead();
    return super.events;
  }

  @override
  set events(ObservableList<EventModel?>? value) {
    _$eventsAtom.reportWrite(value, super.events, () {
      super.events = value;
    });
  }

  late final _$menusAtom =
      Atom(name: '_EventViewModel.menus', context: context);

  @override
  ObservableList<ShortcutModel>? get menus {
    _$menusAtom.reportRead();
    return super.menus;
  }

  @override
  set menus(ObservableList<ShortcutModel>? value) {
    _$menusAtom.reportWrite(value, super.menus, () {
      super.menus = value;
    });
  }

  late final _$tagsAtom = Atom(name: '_EventViewModel.tags', context: context);

  @override
  ObservableList<TagModel?>? get tags {
    _$tagsAtom.reportRead();
    return super.tags;
  }

  @override
  set tags(ObservableList<TagModel?>? value) {
    _$tagsAtom.reportWrite(value, super.tags, () {
      super.tags = value;
    });
  }

  late final _$usersAtom =
      Atom(name: '_EventViewModel.users', context: context);

  @override
  ObservableList<UserModel?>? get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(ObservableList<UserModel?>? value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  late final _$socialMediasAtom =
      Atom(name: '_EventViewModel.socialMedias', context: context);

  @override
  ObservableList<SocialPlatformModel?>? get socialMedias {
    _$socialMediasAtom.reportRead();
    return super.socialMedias;
  }

  @override
  set socialMedias(ObservableList<SocialPlatformModel?>? value) {
    _$socialMediasAtom.reportWrite(value, super.socialMedias, () {
      super.socialMedias = value;
    });
  }

  late final _$isUpdatingDriverResultAtom =
      Atom(name: '_EventViewModel.isUpdatingDriverResult', context: context);

  @override
  bool get isUpdatingDriverResult {
    _$isUpdatingDriverResultAtom.reportRead();
    return super.isUpdatingDriverResult;
  }

  @override
  set isUpdatingDriverResult(bool value) {
    _$isUpdatingDriverResultAtom
        .reportWrite(value, super.isUpdatingDriverResult, () {
      super.isUpdatingDriverResult = value;
    });
  }

  late final _$creatingEventAtom =
      Atom(name: '_EventViewModel.creatingEvent', context: context);

  @override
  EventModel? get creatingEvent {
    _$creatingEventAtom.reportRead();
    return super.creatingEvent;
  }

  @override
  set creatingEvent(EventModel? value) {
    _$creatingEventAtom.reportWrite(value, super.creatingEvent, () {
      super.creatingEvent = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_EventViewModel.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  @override
  String toString() {
    return '''
event: ${event},
standings: ${standings},
media: ${media},
race: ${race},
status: ${status},
raceStandings: ${raceStandings},
raceTeamsStandings: ${raceTeamsStandings},
flow: ${flow},
state: ${state},
events: ${events},
menus: ${menus},
tags: ${tags},
users: ${users},
socialMedias: ${socialMedias},
isUpdatingDriverResult: ${isUpdatingDriverResult},
creatingEvent: ${creatingEvent}
    ''';
  }
}
