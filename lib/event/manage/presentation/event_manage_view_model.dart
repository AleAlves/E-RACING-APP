import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/event/manage/presentation/router/event_manage_router.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/model/event_model.dart';
import '../../../core/model/status_model.dart';
import '../../../core/tools/session.dart';
import '../../../core/ui/view_state.dart';
import '../../../login/legacy/domain/model/user_model.dart';
import '../../core/data/event_home_model.dart';
import '../../core/data/race_standings_model.dart';
import '../../core/data/set_summary_model.dart';
import '../../detail/domain/get_event_usecase.dart';
import '../../detail/domain/race_standing_usecase.dart';
import '../../detail/domain/remove_subcription_usecase.dart';
import '../domain/cancel_race_use_case.dart';
import '../domain/finish_event_usecase.dart';
import '../domain/finish_race_use_case.dart';
import '../domain/set_result_event_usecase.dart';
import '../domain/start_event_usecase.dart';
import '../domain/toogle_members_only_usecase.dart';
import '../domain/toogle_subscriptions_usecase.dart';

part 'event_manage_view_model.g.dart';

class EventManageViewModel = _EventManageViewModel with _$EventManageViewModel;

abstract class _EventManageViewModel extends BaseViewModel<EventManageRouter>
    with Store {
  _EventManageViewModel();

  @override
  @observable
  EventManageRouter? flow = EventManageRouter.main;

  @override
  @observable
  ViewState state = ViewState.ready;

  @override
  @observable
  String? title;

  @override
  @observable
  StatusModel? status;

  @observable
  EventModel? event;

  @observable
  RaceStandingsModel? raceStandings;

  @observable
  bool isUpdatingResults = false;

  @observable
  ObservableList<EventModel?>? events = ObservableList();

  @observable
  ObservableList<UserModel?>? users = ObservableList();

  final _getEventUseCase = Modular.get<GetEventUseCase<EventHomeModel>>();
  final _standingsUC = Modular.get<RaceStandingsUseCase<RaceStandingsModel>>();
  final _removeRegisterUC = Modular.get<RemoveRegisterUseCase<StatusModel>>();
  final _setSummaryUseCase = Modular.get<SetSummaryUseCase<StatusModel>>();
  final _toggleSubsUC = Modular.get<ToogleSubscriptionsUseCase<StatusModel>>();
  final _toggleMembersUC = Modular.get<ToogleMembersOnlyUseCase<StatusModel>>();
  final _startEventUseCase = Modular.get<StartEventUseCase<StatusModel>>();
  final _finishEventUseCase = Modular.get<FinishEventUseCase<StatusModel>>();
  final _finishRaceUseCase = Modular.get<FinishRaceUseCase<StatusModel>>();
  final _cancelRaceUseCase = Modular.get<CancelRaceUseCase<StatusModel>>();

  void getEvent() async {
    state = ViewState.loading;
    _getEventUseCase
        .params(eventId: Session.instance.getEventId() ?? '')
        .invoke(
            success: (data) {
              event = data?.event;
              users = ObservableList.of(data?.users ?? []);
              state = ViewState.ready;
            },
            failure: onError);
  }

  getStandings() async {
    raceStandings = null;
    state = ViewState.loading;
    await _standingsUC.build(id: Session.instance.getRaceId() ?? '').invoke(
        success: (data) {
          raceStandings = data;
          state = ViewState.ready;
          title = raceStandings?.raceName;
        },
        failure: onError);
  }

  updateStandings() async {
    raceStandings = null;
    await _standingsUC.build(id: Session.instance.getRaceId() ?? '').invoke(
        success: (data) {
          raceStandings = data;
          isUpdatingResults = false;
        },
        failure: onError);
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
            failure: onError);
  }

  setSummaryResult(SetSummaryModel? summaryModel) async {
    isUpdatingResults = true;
    await _setSummaryUseCase.build(summaryModel: summaryModel).invoke(
        success: (data) {
          updateStandings();
        },
        failure: onError);
  }

  toggleSubscriptions() {
    state = ViewState.loading;
    _toggleSubsUC.build(eventId: event?.id ?? '').invoke(
        success: (data) {
          status = data;
          state = ViewState.ready;
          onRoute(EventManageRouter.status);
        },
        failure: onError);
  }

  toggleMembersOnly() {
    state = ViewState.loading;
    _toggleMembersUC.build(eventId: event?.id ?? '').invoke(
        success: (data) {
          status = data;
          state = ViewState.ready;
          onRoute(EventManageRouter.status);
        },
        failure: onError);
  }

  goToRace(String id) {
    raceStandings = null;
    Session.instance.setRaceId(id);
    onRoute(EventManageRouter.race);
  }

  startEvent() async {
    state = ViewState.loading;
    await _startEventUseCase.build(id: event?.id ?? '').invoke(
        success: (data) {
          status = data;
          state = ViewState.ready;
          onRoute(EventManageRouter.status);
        },
        failure: onError);
  }

  finishEvent() async {
    state = ViewState.loading;
    await _finishEventUseCase.build(id: event?.id ?? '').invoke(
        success: (data) {
          status = data;
          state = ViewState.ready;
          onRoute(EventManageRouter.status);
        },
        failure: onError);
  }

  finishRace() async {
    state = ViewState.loading;
    await _finishRaceUseCase.build(raceId: Session.instance.getRaceId()).invoke(
        success: (data) {
          status = data;
          state = ViewState.ready;
        },
        failure: onError);
  }

  cancelRace() async {
    state = ViewState.loading;
    await _cancelRaceUseCase.build(raceId: Session.instance.getRaceId()).invoke(
        success: (data) {
          status = data;
          state = ViewState.ready;
        },
        failure: onError);
  }
}
