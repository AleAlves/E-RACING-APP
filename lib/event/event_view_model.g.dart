// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EventViewModel on _EventViewModel, Store {
  final _$eventIdAtom = Atom(name: '_EventViewModel.eventId');

  @override
  String? get eventId {
    _$eventIdAtom.reportRead();
    return super.eventId;
  }

  @override
  set eventId(String? value) {
    _$eventIdAtom.reportWrite(value, super.eventId, () {
      super.eventId = value;
    });
  }

  final _$eventAtom = Atom(name: '_EventViewModel.event');

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

  final _$standingsAtom = Atom(name: '_EventViewModel.standings');

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

  final _$mediaAtom = Atom(name: '_EventViewModel.media');

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

  final _$raceAtom = Atom(name: '_EventViewModel.race');

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

  final _$statusAtom = Atom(name: '_EventViewModel.status');

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

  final _$flowAtom = Atom(name: '_EventViewModel.flow');

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

  final _$stateAtom = Atom(name: '_EventViewModel.state');

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

  final _$eventsAtom = Atom(name: '_EventViewModel.events');

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

  final _$menusAtom = Atom(name: '_EventViewModel.menus');

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

  final _$tagsAtom = Atom(name: '_EventViewModel.tags');

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

  final _$usersAtom = Atom(name: '_EventViewModel.users');

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

  final _$socialMediasAtom = Atom(name: '_EventViewModel.socialMedias');

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

  final _$raceStandingsAtom = Atom(name: '_EventViewModel.raceStandings');

  @override
  ObservableList<RaceStandingsModel?>? get raceStandings {
    _$raceStandingsAtom.reportRead();
    return super.raceStandings;
  }

  @override
  set raceStandings(ObservableList<RaceStandingsModel?>? value) {
    _$raceStandingsAtom.reportWrite(value, super.raceStandings, () {
      super.raceStandings = value;
    });
  }

  final _$creatingEventAtom = Atom(name: '_EventViewModel.creatingEvent');

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

  final _$initAsyncAction = AsyncAction('_EventViewModel.init');

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  @override
  String toString() {
    return '''
eventId: ${eventId},
event: ${event},
standings: ${standings},
media: ${media},
race: ${race},
status: ${status},
flow: ${flow},
state: ${state},
events: ${events},
menus: ${menus},
tags: ${tags},
users: ${users},
socialMedias: ${socialMedias},
raceStandings: ${raceStandings},
creatingEvent: ${creatingEvent}
    ''';
  }
}
