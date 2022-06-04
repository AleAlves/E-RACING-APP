// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on _HomeViewModel, Store {
  late final _$flowAtom = Atom(name: '_HomeViewModel.flow', context: context);

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

  late final _$stateAtom = Atom(name: '_HomeViewModel.state', context: context);

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

  late final _$profileModelAtom =
      Atom(name: '_HomeViewModel.profileModel', context: context);

  @override
  ProfileModel? get profileModel {
    _$profileModelAtom.reportRead();
    return super.profileModel;
  }

  @override
  set profileModel(ProfileModel? value) {
    _$profileModelAtom.reportWrite(value, super.profileModel, () {
      super.profileModel = value;
    });
  }

  late final _$notificationsCountAtom =
      Atom(name: '_HomeViewModel.notificationsCount', context: context);

  @override
  String? get notificationsCount {
    _$notificationsCountAtom.reportRead();
    return super.notificationsCount;
  }

  @override
  set notificationsCount(String? value) {
    _$notificationsCountAtom.reportWrite(value, super.notificationsCount, () {
      super.notificationsCount = value;
    });
  }

  late final _$leaguesAtom =
      Atom(name: '_HomeViewModel.leagues', context: context);

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

  late final _$statusAtom =
      Atom(name: '_HomeViewModel.status', context: context);

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

  @override
  String toString() {
    return '''
flow: ${flow},
state: ${state},
profileModel: ${profileModel},
notificationsCount: ${notificationsCount},
leagues: ${leagues},
status: ${status}
    ''';
  }
}
