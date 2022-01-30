// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EventViewModel on _EventViewModel, Store {
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

  final _$idAtom = Atom(name: '_EventViewModel.id');

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

  final _$initAsyncAction = AsyncAction('_EventViewModel.init');

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  @override
  String toString() {
    return '''
event: ${event},
media: ${media},
id: ${id},
status: ${status},
flow: ${flow},
state: ${state},
events: ${events},
menus: ${menus},
tags: ${tags},
socialMedias: ${socialMedias}
    ''';
  }
}
