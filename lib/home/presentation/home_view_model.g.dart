// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeViewModel on _HomeViewModel, Store {
  final _$flowAtom = Atom(name: '_HomeViewModel.flow');

  @override
  HomeFlow get flow {
    _$flowAtom.reportRead();
    return super.flow;
  }

  @override
  set flow(HomeFlow value) {
    _$flowAtom.reportWrite(value, super.flow, () {
      super.flow = value;
    });
  }

  final _$stateAtom = Atom(name: '_HomeViewModel.state');

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

  final _$leaguesAtom = Atom(name: '_HomeViewModel.leagues');

  @override
  List<LeagueModel>? get leagues {
    _$leaguesAtom.reportRead();
    return super.leagues;
  }

  @override
  set leagues(List<LeagueModel>? value) {
    _$leaguesAtom.reportWrite(value, super.leagues, () {
      super.leagues = value;
    });
  }

  final _$statusAtom = Atom(name: '_HomeViewModel.status');

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

  final _$initAsyncAction = AsyncAction('_HomeViewModel.init');

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
status: ${status}
    ''';
  }
}
