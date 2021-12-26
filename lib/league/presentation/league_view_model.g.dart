// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LeagueViewModel on _LeagueViewModel, Store {
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

  final _$mediasAtom = Atom(name: '_LeagueViewModel.medias');

  @override
  ObservableList<MediaModel?>? get medias {
    _$mediasAtom.reportRead();
    return super.medias;
  }

  @override
  set medias(ObservableList<MediaModel?>? value) {
    _$mediasAtom.reportWrite(value, super.medias, () {
      super.medias = value;
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

  final _$leaguesTagsAtom = Atom(name: '_LeagueViewModel.leaguesTags');

  @override
  ObservableList<Map<String, TagModel?>>? get leaguesTags {
    _$leaguesTagsAtom.reportRead();
    return super.leaguesTags;
  }

  @override
  set leaguesTags(ObservableList<Map<String, TagModel?>>? value) {
    _$leaguesTagsAtom.reportWrite(value, super.leaguesTags, () {
      super.leaguesTags = value;
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

  final _$idAtom = Atom(name: '_LeagueViewModel.id');

  @override
  String? get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String? value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
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

  final _$initAsyncAction = AsyncAction('_LeagueViewModel.init');

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  @override
  String toString() {
    return '''
flow: ${flow},
state: ${state},
leagues: ${leagues},
medias: ${medias},
tags: ${tags},
leaguesTags: ${leaguesTags},
socialMedias: ${socialMedias},
league: ${league},
media: ${media},
id: ${id},
status: ${status}
    ''';
  }
}
