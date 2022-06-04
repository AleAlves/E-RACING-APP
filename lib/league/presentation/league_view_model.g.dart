// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LeagueViewModel on _LeagueViewModel, Store {
  late final _$leagueAtom =
      Atom(name: '_LeagueViewModel.league', context: context);

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

  late final _$mediaAtom =
      Atom(name: '_LeagueViewModel.media', context: context);

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

  late final _$statusAtom =
      Atom(name: '_LeagueViewModel.status', context: context);

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

  late final _$flowAtom = Atom(name: '_LeagueViewModel.flow', context: context);

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

  late final _$stateAtom =
      Atom(name: '_LeagueViewModel.state', context: context);

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

  late final _$playerEventsAtom =
      Atom(name: '_LeagueViewModel.playerEvents', context: context);

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

  late final _$leaguesAtom =
      Atom(name: '_LeagueViewModel.leagues', context: context);

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

  late final _$menusAtom =
      Atom(name: '_LeagueViewModel.menus', context: context);

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

  late final _$tagsAtom = Atom(name: '_LeagueViewModel.tags', context: context);

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

  late final _$membersAtom =
      Atom(name: '_LeagueViewModel.members', context: context);

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

  late final _$socialMediasAtom =
      Atom(name: '_LeagueViewModel.socialMedias', context: context);

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
