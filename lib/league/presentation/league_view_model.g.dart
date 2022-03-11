// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LeagueViewModel on _LeagueViewModel, Store {
  final _$leagueAtom = Atom(name: '_LeagueViewModel.league');

  @override
  LeagueModel? get league {
    _$leagueAtom.reportRead();
    return super.league;
  }

  @override
  set league(LeagueModel? value) {
    _$leagueAtom.reportWrite(value, super.league, () {
      super.league = value;
    });
  }

  final _$mediaAtom = Atom(name: '_LeagueViewModel.media');

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

  final _$statusAtom = Atom(name: '_LeagueViewModel.status');

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

  final _$flowAtom = Atom(name: '_LeagueViewModel.flow');

  @override
  LeagueFlow get flow {
    _$flowAtom.reportRead();
    return super.flow;
  }

  @override
  set flow(LeagueFlow value) {
    _$flowAtom.reportWrite(value, super.flow, () {
      super.flow = value;
    });
  }

  final _$stateAtom = Atom(name: '_LeagueViewModel.state');

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

  final _$playerEventsAtom = Atom(name: '_LeagueViewModel.playerEvents');

  @override
  ObservableList<EventModel?>? get playerEvents {
    _$playerEventsAtom.reportRead();
    return super.playerEvents;
  }

  @override
  set playerEvents(ObservableList<EventModel?>? value) {
    _$playerEventsAtom.reportWrite(value, super.playerEvents, () {
      super.playerEvents = value;
    });
  }

  final _$leaguesAtom = Atom(name: '_LeagueViewModel.leagues');

  @override
  ObservableList<LeagueModel?>? get leagues {
    _$leaguesAtom.reportRead();
    return super.leagues;
  }

  @override
  set leagues(ObservableList<LeagueModel?>? value) {
    _$leaguesAtom.reportWrite(value, super.leagues, () {
      super.leagues = value;
    });
  }

  final _$menusAtom = Atom(name: '_LeagueViewModel.menus');

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

  final _$tagsAtom = Atom(name: '_LeagueViewModel.tags');

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

  final _$membersAtom = Atom(name: '_LeagueViewModel.members');

  @override
  ObservableList<LeagueMembersModel?>? get members {
    _$membersAtom.reportRead();
    return super.members;
  }

  @override
  set members(ObservableList<LeagueMembersModel?>? value) {
    _$membersAtom.reportWrite(value, super.members, () {
      super.members = value;
    });
  }

  final _$socialMediasAtom = Atom(name: '_LeagueViewModel.socialMedias');

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

  @override
  String toString() {
    return '''
league: ${league},
media: ${media},
status: ${status},
flow: ${flow},
state: ${state},
playerEvents: ${playerEvents},
leagues: ${leagues},
menus: ${menus},
tags: ${tags},
members: ${members},
socialMedias: ${socialMedias}
    ''';
  }
}
