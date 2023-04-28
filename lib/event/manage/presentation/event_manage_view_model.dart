import 'package:e_racing_app/core/ui/base_view_model.dart';
import 'package:e_racing_app/event/manage/presentation/router/event_manage_router.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/model/event_model.dart';
import '../../../core/model/race_model.dart';
import '../../../core/model/status_model.dart';
import '../../../core/tools/session.dart';
import '../../../core/ui/view_state.dart';
import '../../../login/legacy/domain/model/user_model.dart';
import '../../core/data/event_home_model.dart';
import '../../core/data/event_standings_model.dart';
import '../../core/data/race_standings_model.dart';
import '../../core/data/set_summary_model.dart';
import '../../detail/domain/get_event_usecase.dart';
import '../../detail/domain/race_standing_usecase.dart';
import '../../detail/domain/remove_subcription_usecase.dart';
import '../domain/set_result_event_usecase.dart';
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
  String? title = "";

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
  ObservableList<EventModel?>? events = ObservableList();

  @observable
  ObservableList<UserModel?>? users = ObservableList();

  final _getEventUseCase = Modular.get<GetEventUseCase<EventHomeModel>>();
  final _standingsUC = Modular.get<RaceStandingsUseCase<RaceStandingsModel>>();
  final _removeRegistertUC = Modular.get<RemoveRegisterUseCase<StatusModel>>();
  final _setSumaryUseCase = Modular.get<SetSummaryUseCase<StatusModel>>();
  final _toggleSubsUC = Modular.get<ToogleSubscriptionsUseCase<StatusModel>>();
  final _toggleMembersUC = Modular.get<ToogleMembersOnlyUseCase<StatusModel>>();

  void getEvent() async {
    state = ViewState.loading;
    _getEventUseCase.params(id: Session.instance.getEventId() ?? '').invoke(
        success: (data) {
          event = data?.event;
          users = ObservableList.of(data?.users ?? []);
          state = ViewState.ready;
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
    await _removeRegistertUC
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
    await _setSumaryUseCase.build(summaryModel: summaryModel).invoke(
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
          onRoute(EventManageRouter.status);
        },
        error: onError);
  }

  toggleMembersOnly() {
    state = ViewState.loading;
    _toggleMembersUC.build(eventId: event?.id ?? '').invoke(
        success: (data) {
          status = data;
          state = ViewState.ready;
          onRoute(EventManageRouter.status);
        },
        error: onError);
  }
}
