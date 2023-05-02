import 'dart:convert';
import 'dart:io';

import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/event/update/presentation/router/event_update_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

import '../../../core/model/event_model.dart';
import '../../../core/model/media_model.dart';
import '../../../core/model/pair_model.dart';
import '../../../core/model/race_model.dart';
import '../../../core/model/status_model.dart';
import '../../../core/tools/session.dart';
import '../../../core/ui/view_state.dart';
import '../../../login/legacy/domain/model/user_model.dart';
import '../../../shared/media/get_media.usecase.dart';
import '../../core/data/event_home_model.dart';
import '../../core/data/event_standings_model.dart';
import '../../core/data/race_standings_model.dart';
import '../../core/data/set_summary_model.dart';
import '../../detail/domain/get_event_usecase.dart';
import '../../detail/domain/race_standing_usecase.dart';
import '../../detail/domain/remove_subcription_usecase.dart';
import '../../manage/domain/set_result_event_usecase.dart';
import '../../manage/domain/toogle_members_only_usecase.dart';
import '../../manage/domain/toogle_subscriptions_usecase.dart';
import '../../manage/domain/update_event_usecase.dart';
import '../domain/update_race_usecase.dart';

part 'event_update_view_model.g.dart';

class EventUpdateViewModel = _EventUpdateViewModel with _$EventUpdateViewModel;

abstract class _EventUpdateViewModel extends BaseViewModel<EventUpdateRouter>
    with Store {
  _EventUpdateViewModel();

  @override
  @observable
  EventUpdateRouter? flow = EventUpdateRouter.main;

  @override
  @observable
  ViewState state = ViewState.ready;

  @override
  @observable
  String? title = "";

  @observable
  MediaModel? media;

  @override
  @observable
  StatusModel? status;

  @observable
  EventModel? event;

  @observable
  RaceModel? race;

  @observable
  EventStandingsModel? standings;

  @observable
  RaceStandingsModel? raceStandings;

  @observable
  bool isUpdatingResults = false;

  @observable
  ObservableList<UserModel?>? users = ObservableList();

  @observable
  File bannerFile = File('');

  @observable
  ImagePicker picker = ImagePicker();

  @observable
  TextEditingController titleController = TextEditingController();

  @observable
  TextEditingController rulesController = TextEditingController();

  @observable
  List<Pair<TextEditingController, TextEditingController>> settingsEdit = [];

  @observable
  List<Pair<TextEditingController, TextEditingController>> classesEdit = [];

  final _getEventUseCase = Modular.get<GetEventUseCase<EventHomeModel>>();
  final _standingsUC = Modular.get<RaceStandingsUseCase<RaceStandingsModel>>();
  final _removeRegisterUC = Modular.get<RemoveRegisterUseCase<StatusModel>>();
  final _setSummaryUseCase = Modular.get<SetSummaryUseCase<StatusModel>>();
  final _toggleSubsUC = Modular.get<ToogleSubscriptionsUseCase<StatusModel>>();
  final _toggleMembersUC = Modular.get<ToogleMembersOnlyUseCase<StatusModel>>();
  final _updateEventUC = Modular.get<UpdateEventUseCase<StatusModel>>();
  final _getMediaUC = Modular.get<GetMediaUseCase<MediaModel>>();
  final _updateRaceUC = Modular.get<UpdateRaceUseCase<StatusModel>>();

  void getEvent() async {
    state = ViewState.loading;
    _getEventUseCase.params(eventId: Session.instance.getEventId()).invoke(
        success: (data) {
          event = data?.event;
          _getMedia(event?.id);
          titleController.text = event?.title ?? "";
          rulesController.text = event?.rules ?? "";
          settingsEdit = [];
          event?.settings?.forEach((element) {
            settingsEdit
                .add(Pair(TextEditingController(), TextEditingController()));
            settingsEdit.last.first?.text = element?.name ?? "";
            settingsEdit.last.second?.text = element?.value ?? "";
          });
          classesEdit = [];
          event?.classes?.forEach((element) {
            classesEdit
                .add(Pair(TextEditingController(), TextEditingController()));
            classesEdit.last.first?.text = element?.name ?? "";
            classesEdit.last.second?.text =
                element?.maxEntries.toString() ?? "";
          });
          state = ViewState.ready;
        },
        error: onError);
  }

  _getMedia(String? id) async {
    await _getMediaUC.params(id: id).invoke(
        success: (data) {
          media = data;
        },
        error: onError);
  }

  getStandings() async {
    raceStandings = null;
    state = ViewState.loading;
    await _standingsUC.build(id: Session.instance.getRaceId() ?? '').invoke(
        success: (data) {
          raceStandings = data;
          state = ViewState.ready;
        },
        error: onError);
  }

  updateStandings() async {
    raceStandings = null;
    await _standingsUC.build(id: Session.instance.getRaceId() ?? '').invoke(
        success: (data) {
          raceStandings = data;
        },
        error: onError);
  }

  Future<void> removeRegister(String? classId, String userId) async {
    state = ViewState.loading;
    await _removeRegisterUC
        .build(
            classId: classId,
            eventId: Session.instance.getEventId(),
            userId: userId)
        .invoke(
            success: (data) {
              status = data;
              state = ViewState.ready;
            },
            error: onError);
  }

  setSummaryResult(SetSummaryModel? summaryModel) async {
    isUpdatingResults = true;
    await _setSummaryUseCase.build(summaryModel: summaryModel).invoke(
        success: (data) {
          getStandings();
        },
        error: onError);
  }

  toggleSubscriptions() {
    state = ViewState.loading;
    _toggleSubsUC.build(eventId: event?.id ?? '').invoke(
        success: (data) {
          status = data;
          state = ViewState.ready;
          onRoute(EventUpdateRouter.status);
        },
        error: onError);
  }

  toggleMembersOnly() {
    state = ViewState.loading;
    _toggleMembersUC.build(eventId: event?.id ?? '').invoke(
        success: (data) {
          status = data;
          state = ViewState.ready;
          onRoute(EventUpdateRouter.status);
        },
        error: onError);
  }

  updateEvent() async {
    state = ViewState.loading;
    var eventClone = event;
    eventClone?.classes?.asMap().forEach((index, classes) {
      classes?.name = classesEdit[index].first?.text;
      classes?.maxEntries = int.parse(classesEdit[index].second?.text ?? '0');
    });
    eventClone?.settings?.asMap().forEach((index, settings) {
      settings?.name = settingsEdit[index].first?.text;
      settings?.value = settingsEdit[index].second?.text;
    });
    var mediaClone = media;
    if (bannerFile.path.isNotEmpty) {
      mediaClone?.image = base64Encode(bannerFile.readAsBytesSync());
    }
    await _updateEventUC.build(event: eventClone, media: mediaClone).invoke(
        success: (data) {
          status = data;
          state = ViewState.ready;
          onRoute(EventUpdateRouter.status);
        },
        error: onError);
  }

  updateRace(RaceModel? model) async {
    state = ViewState.loading;
    _updateRaceUC
        .build(raceModel: model, eventId: Session.instance.getEventId())
        .invoke(
            success: (data) {
              status = data;
              state = ViewState.ready;
              onRoute(EventUpdateRouter.status);
            },
            error: onError);
  }
}
